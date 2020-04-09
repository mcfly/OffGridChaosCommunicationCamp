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
    public class NavCloudComponent : MonoBehaviour, ISerializationCallbackReceiver
    {
        public NavCloudData data = null;


        private const int ROOT_ID = 0;
        private const int INVALID = -1;

        // if position is within the NavCloud, this will return the node that it lies within
        public NavCloudData.Item GetNavCloudDataForPosition(Vector3 position)
        {
            NavCloudData.Item toInspect = data.items[ROOT_ID];

            while (true) // let's hope our data is correctly formed eh eh eh
            {
                int index = (int) toInspect.octantFor(position);

                if (toInspect.octree[index] == INVALID)
                {
                    if(toInspect.isLeaf)
                        return toInspect;

                    return null;
                }

                toInspect = data.items[toInspect.octree[index]];
            }
        }

        // this assumes that position is NOT within the NavCloud. It will return a node
        // that is accessible from position, or null if it cannot.
        public NavCloudData.Item BestNodeFor(Vector3 position)
        {
            NavCloudData.Item toInspect = data.items[ROOT_ID];
            NavCloudData.Item immediateParent = null;

            while (true) // let's hope our data is correctly formed eh eh eh
            {
                int index = (int) toInspect.octantFor(position);

                if (toInspect.octree[index] == INVALID)
                {
                    // we could assert that we are not a leaf at this point if we wanted

                    // we know which PositionType we'd look in if we could (index)
                    // so what we'd like to do is look for nodes of at least our current level in the hierarchy
                    // that make up at most 8 nodes (including this one) in which we search for candidates to be 
                    // 'the best node' for this vector.
                    // the reason we have to do this is because adjacent ancestor nodes could actually be a much
                    // better fit, due to the arbitrary arrangement of the octree

                    // so, if the non-existent node we looked for is UFR, that means this one (its parent) will be the LNL of the 8
                    // nodes we are looking to search in.
                    NavCloudData.Item.Octant desiredOctant = NavCloudData.Item.opposing((NavCloudData.Item.Octant) index);

                    Vector3[] searchPoints = new Vector3[8];
                    searchPoints[0] = toInspect.position;

                    //bool upperMatches = (NavCloudData.Item.isUpper(desiredOctant) && NavCloudData.Item.isUpper(toInspect.octant));
                    //bool farMatches = (NavCloudData.Item.isFar(desiredOctant) && NavCloudData.Item.isFar(toInspect.octant));
                    //bool leftMatch = (NavCloudData.Item.isLeft(desiredOctant) && NavCloudData.Item.isLeft(toInspect.octant));

                    // our aim here is to find a node that contains both our inspect position and its opposite.
                    Vector3 oppositePosition = toInspect.position;
                    float candidateSize = (toInspect.size * 0.5f) + 0.1f; // TODO: 0.1f should be a small number based on the minimum size of volumes
                    oppositePosition.x += NavCloudData.Item.isLeft((NavCloudData.Item.Octant)index) ? -candidateSize : candidateSize;
                    oppositePosition.y += NavCloudData.Item.isUpper((NavCloudData.Item.Octant)index) ? candidateSize : -candidateSize;
                    oppositePosition.z += NavCloudData.Item.isFar((NavCloudData.Item.Octant)index) ? candidateSize : -candidateSize;
                    searchPoints[1] = oppositePosition;

                    // we don't know the orientation of these octants but we don't need to, just need to know
                    // that they're opposite. Because we are axis alined the other 6 points are just the permutations of 
                    // the two opposite vertices. I hope.
                    searchPoints[2] = new Vector3(searchPoints[0].x, searchPoints[1].y, searchPoints[0].z);
                    searchPoints[3] = new Vector3(searchPoints[1].x, searchPoints[0].y, searchPoints[0].z);
                    searchPoints[4] = new Vector3(searchPoints[1].x, searchPoints[1].y, searchPoints[0].z);
                    searchPoints[5] = new Vector3(searchPoints[0].x, searchPoints[1].y, searchPoints[1].z);
                    searchPoints[6] = new Vector3(searchPoints[0].x, searchPoints[0].y, searchPoints[1].z);
                    searchPoints[7] = new Vector3(searchPoints[1].x, searchPoints[0].y, searchPoints[1].z);
                    
                    // we want to find the level that contains both the opposing and this type of position. 
                    int nextParentID = toInspect.parent;
                    Bounds parentBounds = new Bounds();
                    Vector3 parentSize = new Vector3();
                    while (nextParentID > 0)
                    {
                        parentBounds.center = data.items[nextParentID].position;
                        parentSize.Set(data.items[nextParentID].size, data.items[nextParentID].size, data.items[nextParentID].size);
                        parentBounds.size = parentSize;

                        // if it contains the 'opposite' position then we are golden.
                        // It definitely contains our initial position because it's our parent!
                        if (parentBounds.Contains(oppositePosition))
                            break; 

                        // otherwise go up another level.
                        nextParentID = data.items[nextParentID].parent;
                    }

                    if(nextParentID == -1) // we are at the very edge and need to adjust - TODO
                    {
                        nextParentID = 0; // let's use the root to start.
                    }

                    List<NavCloudData.Item> candidates = new List<NavCloudData.Item>(8);
                    foreach(Vector3 toSearch in searchPoints)
                    {
                        NavCloudData.Item.Octant nextOctant = data.items[nextParentID].octantFor(toSearch);
                        int next = data.items[nextParentID].octree[(int)nextOctant]; ;
                        while (next != -1)
                        {
                            NavCloudData.Item loopItem = data.items[next];
                            nextOctant = loopItem.octantFor(toSearch);
                            next = loopItem.octree[(int)nextOctant];

                            if (next == -1)
                            {
                                if(!candidates.Contains(loopItem))
                                    candidates.Add(loopItem);

                                break;
                            }
                        }
                    }

                    float nearest = float.MaxValue;
                    NavCloudData.Item toReturn = null;
                    foreach(NavCloudData.Item candidate in candidates)
                    {   // we're on the home straight now! go through the candidates and work out which are a) accessible and b) closest
                        RaycastHit hitinfo;
                        if (!Physics.SphereCast(position, 1.0f, candidate.position - position, out hitinfo, candidate.size + toInspect.size / 2.0f, 1 << 11))
                        {
                            float distance = (position - candidate.position).sqrMagnitude;
                            if(distance < nearest)
                            {
                                toReturn = candidate;
                            }
                        }
                    }

                    return toReturn;
                }

                immediateParent = toInspect;
                toInspect = data.items[toInspect.octree[index]];
            }
        }

        // this takes the root of the Nav Hierarchy and flattens it into a bunch of data and indices
        public void ProcessHierarchy(GameObject root)
        {
            data = ScriptableObject.CreateInstance<NavCloudData>();

            int objectCount = CountChildren(root) + 1; // +1 is for the root!

            if (objectCount > 0)
            {
                data.items = new NavCloudData.Item[objectCount];

                Process(root, ROOT_ID);
            }

            foreach (NavCloudData.Item item in data.items)
            {
                if (item.UFL != -1)
                    data.items[item.UFL].octant = NavCloudData.Item.Octant.kUFL;
                if (item.UFR != -1)
                    data.items[item.UFR].octant = NavCloudData.Item.Octant.kUFR;
                if (item.UNL != -1)
                    data.items[item.UNL].octant = NavCloudData.Item.Octant.kUNL;
                if (item.UNR != -1)
                    data.items[item.UNR].octant = NavCloudData.Item.Octant.kUNR;
                if (item.LFL != -1)
                    data.items[item.LFL].octant = NavCloudData.Item.Octant.kLFL;
                if (item.LFR != -1)
                    data.items[item.LFR].octant = NavCloudData.Item.Octant.kLFR;
                if (item.LNL != -1)
                    data.items[item.LNL].octant = NavCloudData.Item.Octant.kLNL;
                if (item.LNR != -1)
                    data.items[item.LNR].octant = NavCloudData.Item.Octant.kLNR;
            }
        }

        private void Process(GameObject go, int parentIndex)
        {
            NavCloudNode node = go.GetComponent<NavCloudNode>();
            NavCloudVolume vol = go.GetComponent<NavCloudVolume>();


#if GAME_CORE
            Logger.Assert(node != null, "Where is the node!");
#endif
            if (node != null)
            {
                int index = node.id;

                data.items[index] = new NavCloudData.Item();
                data.items[index].id = index;
                data.items[index].parent = parentIndex;
                data.items[index].position = go.transform.position;
                data.items[index].size = vol != null ? vol.size : -1.0f;

                data.items[index].UFL = node.UFL != null ? node.UFL.id : -1;
                data.items[index].UFR = node.UFR != null ? node.UFR.id : -1;
                data.items[index].UNL = node.UNL != null ? node.UNL.id : -1;
                data.items[index].UNR = node.UNR != null ? node.UNR.id : -1;
                data.items[index].LFL = node.LFL != null ? node.LFL.id : -1;
                data.items[index].LFR = node.LFR != null ? node.LFR.id : -1;
                data.items[index].LNL = node.LNL != null ? node.LNL.id : -1;
                data.items[index].LNR = node.LNR != null ? node.LNR.id : -1;

                if (vol != null && vol.weightedObjects.Count > 0)
                {
                    data.items[index].keys = vol.weightedObjects.Keys.Select(key => key.GetComponent<NavCloudNode>().id).ToArray();
                    data.items[index].values = vol.weightedObjects.Values.ToArray();

                    data.items[index].orderedList = new List<KeyValuePair<int, float>>(vol.weightedObjects.Count);
                    for (int i = 0; i < data.items[index].keys.Length; ++i)
                    {
                        data.items[index].orderedList.Add(new KeyValuePair<int, float>(data.items[index].keys[i], data.items[index].values[i]));
                    }
                    data.items[index].orderedList.Sort((first, second) =>
                     {
                         if (first.Value == second.Value) return 0;
                         return first.Value < second.Value ? -1 : 1;
                     });
                }

                foreach (Transform child in go.transform)
                {
                    Process(child.gameObject, index);
                }
            }          
        }

        private int CountChildren(GameObject go)
        {
            int count = 0;

            foreach (Transform child in go.transform)
            {
                count += CountChildren(child.gameObject);    // add the number of children the child has to total
                ++count;                           // add the child itself to total
            }

            return count;
        }

#if UNITY_EDITOR
        static int adjacent = -1;

        [UnityEditor.DrawGizmo(UnityEditor.GizmoType.Selected | UnityEditor.GizmoType.Active | UnityEditor.GizmoType.InSelectionHierarchy)]
        static void RenderBoxGizmoSelected(NavCloudComponent navVolume, UnityEditor.GizmoType gizmoType)
        {
            if (navVolume.data != null)
            {
                NavCloudData.Item toInspect = null;
                if(adjacent != -1)
                {
                    toInspect = navVolume.data.items[adjacent];
                }

                foreach (NavCloudData.Item n in navVolume.data.items)
                {
                    if (n.isLeaf)
                    {
                        Gizmos.color = new Color(1.0f, 1.0f, 0.0f, 0.1f);

                        if (toInspect != null)
                        {
                            if (n == toInspect)
                                Gizmos.color = new Color(1.0f, 0.0f, 0.0f, 0.75f);
                            else if (toInspect.keys.Contains(n.id))
                                Gizmos.color = new Color(0.0f, 1.0f, 0.0f, 0.5f);
                        }

                        Gizmos.DrawCube(n.position, new Vector3(n.size, n.size, n.size));
                    }
                }
            }
        }

#if GAME_CORE
        [MenuItem("Off Grid/Cycle NavCloud")]
        static void ShowAdjacency()
        {
            GameObject ncc = GameObject.Find("NavCloud");
            if (ncc != null)
            {
                adjacent = Random.Range(0, ncc.GetComponent<NavCloudComponent>().data.items.Length - 1);
            }
        }
#endif
#endif

        #region A_STAR
        public List<NavCloudData.Item> FindRoute(NavCloudData.Item from, NavCloudData.Item to)
        {
            // Yes, I used the wikipedia article.
            List<NavCloudData.Item> closed = new List<NavCloudData.Item>(128);
            List<NavCloudData.Item> open = new List<NavCloudData.Item>(128);
            open.Add(from);

            Dictionary<NavCloudData.Item, NavCloudData.Item> cameFrom = new Dictionary<NavCloudData.Item, NavCloudData.Item>(128);

            // 'gScore': the 'actual' score of getting from the start navVolume to the key navVolume
            Dictionary<NavCloudData.Item, float> scoreFromStart = new Dictionary<NavCloudData.Item, float>(1024);
            scoreFromStart[from] = 0.0f;

            // 'fScore': the presumed score of getting from the start navVolume to the goal navVolume via the key navVolume
            Dictionary<NavCloudData.Item, float> scoreViaNode = new Dictionary<NavCloudData.Item, float>(1024);
            scoreViaNode[from] = Score(from, to);

            while (open.Count > 0)
            {
                // current is set to the navVolume in the open set with the lowest fScore.
                NavCloudData.Item current = null;
                float small = float.MaxValue;
                foreach (NavCloudData.Item candidate in open)
                {
                    float? score = scoreViaNode[candidate];
                    if (score.HasValue && score < small)
                    {
                        small = score.Value;
                        current = candidate;
                    }
                }

                // finished!
                if (current == to)
                {
                    return Path(cameFrom, current);
                }

                open.Remove(current);
                closed.Add(current);

                // otherwise look for neighbours that havent been evaluated
                if (current.orderedList != null)
                {
                    foreach (KeyValuePair<int, float> pair in current.orderedList)
                    {
                        NavCloudData.Item neighbour = data.items[pair.Key];
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
                            scoreViaNode[neighbour] = score + Score(neighbour, to);
                        }
                    }
                }
            }

            return new List<NavCloudData.Item>(0);
        }

        private List<NavCloudData.Item> Path(Dictionary<NavCloudData.Item, NavCloudData.Item> cameFrom, NavCloudData.Item current)
        {
            List<NavCloudData.Item> path = new List<NavCloudData.Item>(64);
            path.Add(current);

            if (cameFrom.Count() > 0)
            {
                NavCloudData.Item next = cameFrom[current];
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

        private static float Score(NavCloudData.Item from, NavCloudData.Item to)
        {
            if (from != null && to != null)
            {
                return (from.position - to.position).sqrMagnitude;
            }

            return float.PositiveInfinity;
        }
#endregion

        public void OnBeforeSerialize()
        {
            if(data != null && data.items != null)
            {
                foreach (NavCloudData.Item n in data.items)
                {
                    if (n.orderedList != null)
                    {
                        n.keys = n.orderedList.Select(x => x.Key).ToArray();
                        n.values = n.orderedList.Select(x => x.Value).ToArray();
                    }
                }
            }
        }

        public void OnAfterDeserialize()
        {
            if (data != null && data.items != null)
            {
                foreach (NavCloudData.Item n in data.items)
                {
                    if (n.keys != null && n.keys.Length > 0)
                    {
                        n.orderedList = new List<KeyValuePair<int, float>>(n.keys.Length);
                        for (int i = 0; i < n.keys.Length; ++i)
                        {
                            n.orderedList.Add(new KeyValuePair<int, float>(n.keys[i], n.values[i]));
                        }
                        n.orderedList.Sort((first, second) =>
                        {
                            if (first.Value == second.Value) return 0;
                            return first.Value < second.Value ? -1 : 1;
                        });
                    }
                }
            }
        }
    }
}