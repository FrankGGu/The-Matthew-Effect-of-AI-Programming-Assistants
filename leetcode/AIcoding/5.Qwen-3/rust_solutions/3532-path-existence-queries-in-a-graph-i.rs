impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn check_distances(graph: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = graph.len();
        let mut result = Vec::with_capacity(queries.len());

        for query in queries {
            let (u, v) = (query[0] as usize, query[1] as usize);
            let mut visited = vec![false; n];
            let mut queue = VecDeque::new();
            queue.push_back((u, 0));
            visited[u] = true;
            let mut found = false;

            while let Some((node, dist)) = queue.pop_front() {
                if node == v {
                    result.push(dist == query[2]);
                    found = true;
                    break;
                }

                for &neighbor in &graph[node] {
                    let neighbor = neighbor as usize;
                    if !visited[neighbor] {
                        visited[neighbor] = true;
                        queue.push_back((neighbor, dist + 1));
                    }
                }
            }

            if !found {
                result.push(false);
            }
        }

        result
    }
}
}