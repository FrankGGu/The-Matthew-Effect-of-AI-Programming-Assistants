impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn eventual_safe_states(mut graph: Vec<Vec<i32>>) -> Vec<i32> {
        let n = graph.len();
        let mut out_degree = vec![0; n];
        let mut reverse_graph = vec![Vec::new(); n];

        for (i, neighbors) in graph.iter().enumerate() {
            for &neighbor in neighbors {
                reverse_graph[neighbor as usize].push(i);
                out_degree[i] += 1;
            }
        }

        let mut queue = VecDeque::new();
        let mut safe = vec![false; n];

        for i in 0..n {
            if out_degree[i] == 0 {
                queue.push_back(i);
                safe[i] = true;
            }
        }

        while let Some(node) = queue.pop_front() {
            for &prev in &reverse_graph[node] {
                out_degree[prev] -= 1;
                if out_degree[prev] == 0 {
                    safe[prev] = true;
                    queue.push_back(prev);
                }
            }
        }

        let mut result = Vec::new();
        for i in 0..n {
            if safe[i] {
                result.push(i as i32);
            }
        }

        result.sort();
        result
    }
}
}