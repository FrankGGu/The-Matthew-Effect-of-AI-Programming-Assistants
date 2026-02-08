impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_edge_reversals_to_make_all_reachable(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited[0] = true;

        let mut count = 0;
        let mut stack = vec![0];
        let mut parent = vec![0; n];
        let mut children = vec![vec![]; n];

        while let Some(u) = stack.pop() {
            for &v in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    parent[v] = u;
                    children[u].push(v);
                    stack.push(v);
                }
            }
        }

        let mut res = 0;
        for u in 0..n {
            for &v in &children[u] {
                res += 1;
            }
        }

        let mut queue = VecDeque::new();
        queue.push_back(0);
        let mut visited = vec![false; n];
        visited[0] = true;

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    queue.push_back(v);
                    if parent[v] == u {
                        res -= 1;
                    } else {
                        res += 1;
                    }
                }
            }
        }

        res
    }
}
}