impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn shortest_distance_after_roads_added(roads: Vec<Vec<i32>>) -> i32 {
        let n = 1000;
        let mut graph = vec![Vec::new(); n as usize];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited.insert(0);

        let mut distance = vec![0; n as usize];

        while let Some(node) = queue.pop_front() {
            if node == n - 1 {
                return distance[node];
            }
            for &neighbor in &graph[node] {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    distance[neighbor] = distance[node] + 1;
                    queue.push_back(neighbor);
                }
            }
        }

        -1
    }
}
}