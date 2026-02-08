struct Solution;

impl Solution {
    pub fn distance_limited_paths_exist(mut n: i32, mut queries: Vec<Vec<i32>>, mut connections: Vec<Vec<i32>>) -> Vec<bool> {
        use std::collections::HashMap;

        let mut parent = (0..n).collect::<Vec<_>>();
        let mut rank = vec![1; n as usize];

        fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
            if parent[x as usize] != x {
                parent[x as usize] = find(parent, parent[x as usize]);
            }
            parent[x as usize]
        }

        fn union(parent: &mut Vec<i32>, rank: &mut Vec<i32>, x: i32, y: i32) {
            let x_root = find(parent, x);
            let y_root = find(parent, y);
            if x_root == y_root {
                return;
            }
            if rank[x_root as usize] < rank[y_root as usize] {
                parent[x_root as usize] = y_root;
            } else {
                parent[y_root as usize] = x_root;
                if rank[x_root as usize] == rank[y_root as usize] {
                    rank[x_root as usize] += 1;
                }
            }
        }

        for q in &mut queries {
            q.push(*q.iter().nth(0).unwrap());
            q.push(*q.iter().nth(1).unwrap());
            q.push(*q.iter().nth(2).unwrap());
        }

        queries.sort_by(|a, b| a[2].cmp(&b[2]));

        connections.sort_by(|a, b| a[2].cmp(&b[2]));

        let mut result = vec![false; queries.len()];
        let mut ptr = 0;

        for query in queries {
            let u = query[0];
            let v = query[1];
            let limit = query[2];

            while ptr < connections.len() && connections[ptr][2] < limit {
                union(&mut parent, &mut rank, connections[ptr][0], connections[ptr][1]);
                ptr += 1;
            }

            let root_u = find(&mut parent, u);
            let root_v = find(&mut parent, v);

            result[query[3] as usize] = root_u == root_v;
        }

        result
    }
}