impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_score(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];

        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let score = road[2];
            graph[u].push((v, score));
            graph[v].push((u, score));
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited.insert(0);

        let mut min_score = i32::MAX;

        while let Some(node) = queue.pop_front() {
            for &(neighbor, score) in &graph[node] {
                min_score = min_score.min(score);
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        min_score
    }
}
}