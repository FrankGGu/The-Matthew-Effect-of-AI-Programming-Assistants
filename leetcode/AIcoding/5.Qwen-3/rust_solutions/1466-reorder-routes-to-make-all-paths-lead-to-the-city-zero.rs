impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_reorder(n: i32, adj: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in adj {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push((v, true));
            graph[v].push((u, false));
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited.insert(0);
        let mut result = 0;

        while let Some(node) = queue.pop_front() {
            for &(neighbor, is_original) in &graph[node] {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                    if is_original {
                        result += 1;
                    }
                }
            }
        }

        result
    }
}

pub struct Solution;
}