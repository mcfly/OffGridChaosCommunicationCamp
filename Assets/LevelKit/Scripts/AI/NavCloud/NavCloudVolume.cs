// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif
using System.Linq;

namespace NavCloud
{ 
    public class NavCloudVolume : MonoBehaviour, ISerializationCallbackReceiver
    {
        public int depth;
        public float size;

        public Dictionary<GameObject, float> weightedObjects = new Dictionary<GameObject, float>(32);
        public List<KeyValuePair<GameObject, float>> orderedList = new List<KeyValuePair<GameObject, float>>(32);

        [SerializeField] private List<GameObject> keys = new List<GameObject>(32);
        [SerializeField] private List<float> values = new List<float>(32);

        [HideInInspector] public const float minimumSize = 1.0f;

        public void OnBeforeSerialize()
        {
            keys = weightedObjects.Keys.ToList();
            values = weightedObjects.Values.ToList();
        }

        public void OnAfterDeserialize()
        {
            weightedObjects.Clear();
    #if GAME_CORE
            Logger.Assert(keys.Count == values.Count, "Something is wrong, Steve");
    #endif
            for (int i = 0; i < keys.Count; ++i)
            {
                weightedObjects.Add(keys[i], values[i]);
                orderedList.Add(new KeyValuePair<GameObject, float>(keys[i], values[i]));
            }

            orderedList.Sort((first, second) =>
                {
                    if (first.Value == second.Value) return 0;
                    return first.Value < second.Value ? -1 : 1;
                });

            keys.Clear();
            values.Clear();
        }

#if UNITY_EDITOR
        [DrawGizmo(GizmoType.Selected | GizmoType.Active | GizmoType.InSelectionHierarchy)]
        static void RenderBoxGizmoSelected(NavCloudVolume navVolume, GizmoType gizmoType)
        {
            Gizmos.color = Color.yellow;
            Gizmos.DrawWireCube(navVolume.transform.position, new Vector3(navVolume.size, navVolume.size, navVolume.size));
        }
#endif

        private void OnEnable()
        {

        }

        private void OnDisable()
        {

        }

        private void Awake()
        {

        }

        public void DetermineAdjacency(NavCloudVolume[] nodes)
        {
            //internalData = ScriptableObject.CreateInstance<NavCloudVolume.Node>();

            BoxCollider ourBox = gameObject.GetComponent<BoxCollider>();
            if (ourBox == null)
                return;

            Vector3 toExpandBy = new Vector3(minimumSize, minimumSize, minimumSize);


            // PS - this is *much* quicker (by hours on large levels) but couldn't verify 100% it's workign correctly as even the old approach seems to have issues.
            //Bounds testBounds = new Bounds(ourBox.bounds.center, ourBox.bounds.size);
            //testBounds.size += toExpandBy;
            //Collider[] neighbours = (Physics.OverlapBox(ourBox.center, testBounds.size, Quaternion.identity));
            //foreach (Collider c in neighbours) {
            //	GameObject nO = c.gameObject;
            //	if (!weightedObjects.ContainsKey(nO)) {
            //		NavCloudVolume nV = nO.GetComponent<NavCloudVolume>();
            //		if (nV != null) {
            //			Vector3 closestPoint = testBounds.ClosestPoint(transform.position);
            //			float weight = (transform.position - closestPoint).sqrMagnitude;
            //			weightedObjects[nO] = weight;
            //			if (!nV.weightedObjects.ContainsKey(this.gameObject)) {
            //				nV.weightedObjects.Add(this.gameObject, weight);
            //			}
            //		}
            //	}
            //}
            // PS

            foreach (NavCloudVolume n in nodes)
            {
                if (n == this)
                {
                    continue;
                }

                // so the dirty thing I am going to try is this. We grab the Bounds from each candidate navVolume.
                // we then expand that Bounds artificially by 10% of our navVolume, and test if it overlaps.
                // What could go wrong?
                GameObject go = n.gameObject;

                BoxCollider box = go.GetComponent<BoxCollider>();
                if (box != null)
                {
                    Bounds bounds = new Bounds(box.bounds.center, box.bounds.size);
                    bounds.size += toExpandBy;

                    if (ourBox.bounds.Intersects(bounds))
                    {
                        Vector3 closestPoint = bounds.ClosestPoint(transform.position);
                        float weight = (transform.position - closestPoint).sqrMagnitude;
                        weightedObjects[go] = weight;

                        // Let's speed things up by filling in the neighbourt's data as well:
                        NavCloudVolume neighbour = go.GetComponent<NavCloudVolume>();
                        if (!neighbour.weightedObjects.ContainsKey(this.gameObject))
                        {
                            neighbour.weightedObjects.Add(this.gameObject, weight);
                        }
                    }
                }
            }
        }

        // we will want to coroutine this.
        public List<NavCloudVolume> FindRouteFrom(NavCloudVolume destination)
        {
            // Yes, I used the wikipedia article.

            List<NavCloudVolume> closed = new List<NavCloudVolume>(128);
            List<NavCloudVolume> open = new List<NavCloudVolume>(128);
            open.Add(this);

            Dictionary<NavCloudVolume, NavCloudVolume> cameFrom = new Dictionary<NavCloudVolume, NavCloudVolume>(128);

            // 'gScore': the 'actual' score of getting from the start navVolume to the key navVolume
            Dictionary<NavCloudVolume, float> scoreFromStart = new Dictionary<NavCloudVolume, float>(1024);
            scoreFromStart[this] = 0.0f;

            // 'fScore': the presumed score of getting from the start navVolume to the goal navVolume via the key navVolume
            Dictionary<NavCloudVolume, float> scoreViaNode = new Dictionary<NavCloudVolume, float>(1024);
            scoreViaNode[this] = Score(this, destination);

            while (open.Count > 0)
            {
                // current is set to the navVolume in the open set with the lowest fScore.
                NavCloudVolume current = null;
                float small = float.MaxValue;
                foreach (NavCloudVolume candidate in open)
                {
                    float? score = scoreViaNode[candidate];
                    if (score.HasValue && score < small)
                    {
                        small = score.Value;
                        current = candidate;
                    }
                }

                // finished!
                if (current == destination)
                {
                    return Path(cameFrom, current);
                }

                open.Remove(current);
                closed.Add(current);

                // otherwise look for neighbours that havent been evaluated
                foreach (KeyValuePair<GameObject, float> pair in current.orderedList) // weightedObjects)
                {
                    NavCloudVolume neighbour = pair.Key.GetComponent<NavCloudVolume>();
                    if (neighbour != null)
                    {
                        // already been here
                        if (closed.Contains(neighbour))
                            continue;

                        // aha! add it
                        if (!open.Contains(neighbour))
                        {
                            open.Add(neighbour);
                        }


                        float score = scoreFromStart[current] + pair.Value;
                        if (scoreFromStart.ContainsKey(neighbour) && score >= scoreFromStart[neighbour])
                        {
                            continue; // this isn't the navVolume we are looking for.
                        }

                        // oh my goodness this is exciting. this is a good path. let's do it.
                        cameFrom[neighbour] = current;
                        scoreFromStart[neighbour] = score;
                        scoreViaNode[neighbour] = score + Score(neighbour, destination);
                    }
                }
            }

            return new List<NavCloudVolume>(0);
        }

        private List<NavCloudVolume> Path(Dictionary<NavCloudVolume, NavCloudVolume> cameFrom, NavCloudVolume current)
        {
            List<NavCloudVolume> path = new List<NavCloudVolume>(64);
            path.Add(current);

            if (cameFrom.Count() > 0)
            {
                NavCloudVolume next = cameFrom[current];
                while (true)
                {
                    path.Add(next);
                    if (cameFrom.ContainsKey(next))
                    {
                        next = cameFrom[next];
                    }
                    else break;
                }
            }

            return path;
        }

        private static float Score(NavCloudVolume from, NavCloudVolume to)
        {
            if (from != null && to != null)
            {
                return (from.transform.position - to.transform.position).sqrMagnitude;
            }

            return float.PositiveInfinity;
        }
    }
}
