impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn valid_path(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32) -> bool {
        let n = n as usize;
        let mut graph = vec![Vec::new(); n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        queue.push_back(source as usize);
        visited.insert(source as usize);

        while let Some(node) = queue.pop_front() {
            if node == destination as usize {
                return true;
            }
            for &neighbor in &graph[node] {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        false
    }
}
}