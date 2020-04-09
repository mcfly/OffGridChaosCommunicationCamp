// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace NavCloud
{
    public class NavCloudData : ScriptableObject
    {
        public Item[] items;

        [System.Serializable]
        public class Item
        {
            public int id;
            public int depth;

            public Vector3 position;
            public float size; // cube, currently

            //public Dictionary<int, float> weightedObjects;
            public List<KeyValuePair<int, float>> orderedList;
            public int[] keys;
            public float[] values;

            public Octant octant = Octant.kMaxPosition;
            public int parent = -1;
            public bool isLeaf = false;

            public enum Octant
            {
                kUFL = 0,
                kUFR,
                kUNL,
                kUNR,
                kLFL,
                kLFR,
                kLNL,
                kLNR,
                kMaxPosition
            }

            public int[] octree = { -1, -1, -1, -1, -1, -1, -1, -1 }; // size 8.

            public int UFL { get { return octree[(int)Octant.kUFL]; } set { octree[(int)Octant.kUFL] = value; calcLeaf(); } }
            public int UFR { get { return octree[(int)Octant.kUFR]; } set { octree[(int)Octant.kUFR] = value; calcLeaf(); } }
            public int UNL { get { return octree[(int)Octant.kUNL]; } set { octree[(int)Octant.kUNL] = value; calcLeaf(); } }
            public int UNR { get { return octree[(int)Octant.kUNR]; } set { octree[(int)Octant.kUNR] = value; calcLeaf(); } }
            public int LFL { get { return octree[(int)Octant.kLFL]; } set { octree[(int)Octant.kLFL] = value; calcLeaf(); } }
            public int LFR { get { return octree[(int)Octant.kLFR]; } set { octree[(int)Octant.kLFR] = value; calcLeaf(); } }
            public int LNL { get { return octree[(int)Octant.kLNL]; } set { octree[(int)Octant.kLNL] = value; calcLeaf(); } }
            public int LNR { get { return octree[(int)Octant.kLNR]; } set { octree[(int)Octant.kLNR] = value; calcLeaf(); } }

            private void calcLeaf()
            {
                foreach (int i in octree)
                {
                    if (i != -1)
                    {
                        isLeaf = false;
                        return;
                    }
                    isLeaf = true;
                }
            }

            public Octant octantFor(Vector3 p)
            {
                bool greatX = p.x > this.position.x;
                bool greatY = p.y > this.position.y;
                bool greatZ = p.z > this.position.z;

                int index = greatY ? 0 : 4;
                index += greatZ ? 0 : 2;
                index += greatX ? 1 : 0;

                return (Octant)index;
            }

            private static readonly Octant[] opposed = { Octant.kLNR, Octant.kLNL, Octant.kLFR, Octant.kLFL, Octant.kUNR, Octant.kUNL, Octant.kUFR, Octant.kUFL };
            public static Octant opposing(Octant p)
            {
                return opposed[(int)p];
            }

            public static bool isUpper(Octant p)
            {
                return p <= Octant.kUNR;
            }

            public static bool isFar(Octant p)
            {
                return ((int)p) % 4 < 2;
            }

            public static bool isLeft(Octant p)
            {
                return ((int)p) % 2 == 0;
            }
        }
    }
}

