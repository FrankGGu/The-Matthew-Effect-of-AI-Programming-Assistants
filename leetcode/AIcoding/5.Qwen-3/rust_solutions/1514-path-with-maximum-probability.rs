impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_probability(n: i32, edges: Vec<Vec<i32>>, start_node: i32, end_node: i32) -> f64 {
        let n = n as usize;
        let mut graph = HashMap::new();

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let prob = edge[2] as f64;

            graph.entry(u).or_insert_with(Vec::new).push((v, prob));
            graph.entry(v).or_insert_with(Vec::new).push((u, prob));
        }

        let mut max_prob = vec![0.0; n];
        max_prob[start_node as usize] = 1.0;

        let mut queue = VecDeque::new();
        queue.push_back(start_node as usize);

        while let Some(node) = queue.pop_front() {
            for &(neighbor, prob) in graph.get(&node).into_iter().flatten() {
                if max_prob[neighbor] < max_prob[node] * prob {
                    max_prob[neighbor] = max_prob[node] * prob;
                    queue.push_back(neighbor);
                }
            }
        }

        max_prob[end_node as usize]
    }
}
}