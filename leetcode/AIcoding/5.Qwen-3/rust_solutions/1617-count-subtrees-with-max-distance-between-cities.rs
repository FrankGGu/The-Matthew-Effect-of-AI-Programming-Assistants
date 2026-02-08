impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn count_max_distance_subtrees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut result = vec![0; n];

        for root in 0..n {
            let mut visited = vec![false; n];
            let mut max_dist = 0;
            let mut queue = VecDeque::new();
            queue.push_back((root, 0));
            visited[root] = true;

            while let Some((node, dist)) = queue.pop_front() {
                max_dist = max_dist.max(dist);
                for &neighbor in &adj[node] {
                    if !visited[neighbor] {
                        visited[neighbor] = true;
                        queue.push_back((neighbor, dist + 1));
                    }
                }
            }

            result[max_dist] += 1;
        }

        result
    }
}
}