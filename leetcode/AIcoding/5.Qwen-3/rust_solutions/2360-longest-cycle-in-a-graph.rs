impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn longest_cycle(mut graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        let mut visited = vec![false; n];
        let mut max_length = -1;

        for i in 0..n {
            if !visited[i] {
                let mut parent = vec![-1; n];
                let mut dist = vec![0; n];
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;
                dist[i] = 0;

                while let Some(node) = queue.pop_front() {
                    for &neighbor in &graph[node] {
                        let neighbor = neighbor as usize;
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            parent[neighbor] = node as i32;
                            dist[neighbor] = dist[node] + 1;
                            queue.push_back(neighbor);
                        } else if parent[node] != neighbor as i32 {
                            let cycle_length = dist[node] - dist[neighbor] + 1;
                            if cycle_length > max_length {
                                max_length = cycle_length;
                            }
                        }
                    }
                }
            }
        }

        max_length
    }
}
}