impl Solution {

use std::collections::{HashMap, VecDeque};

struct Solution {}

impl Solution {
    pub fn cycle_length_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut depth = vec![0; n as usize + 1];
        let mut parent = vec![0; n as usize + 1];
        let mut queue = VecDeque::new();

        for i in 1..=n as usize {
            depth[i] = 0;
            parent[i] = 0;
        }

        queue.push_back(1);
        while let Some(u) = queue.pop_front() {
            for v in [2 * u, 2 * u + 1].iter() {
                if *v <= n as usize {
                    depth[*v] = depth[u] + 1;
                    parent[*v] = u;
                    queue.push_back(*v);
                }
            }
        }

        let mut result = Vec::new();
        for q in queries {
            let u = q[0] as usize;
            let v = q[1] as usize;
            let mut lca = 0;
            let mut du = depth[u];
            let mut dv = depth[v];

            while du != dv {
                if du > dv {
                    u = parent[u];
                    du -= 1;
                } else {
                    v = parent[v];
                    dv -= 1;
                }
            }

            while u != v {
                u = parent[u];
                v = parent[v];
            }

            lca = u;
            result.push((depth[u] - depth[lca]) + (depth[v] - depth[lca]));
        }

        result
    }
}
}