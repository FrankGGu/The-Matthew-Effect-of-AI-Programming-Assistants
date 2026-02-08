impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn count_unreachable_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut graph = vec![Vec::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut components = Vec::new();

        for i in 0..n {
            if !visited[i] {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;
                let mut size = 0;

                while let Some(node) = queue.pop_front() {
                    size += 1;
                    for &neighbor in &graph[node] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            queue.push_back(neighbor);
                        }
                    }
                }

                components.push(size);
            }
        }

        let total = (n as i64 * (n as i64 - 1)) / 2;
        let sum = components.iter().map(|&s| (s as i64 * (s as i64 - 1)) / 2).sum::<i64>();
        total - sum
    }
}
}