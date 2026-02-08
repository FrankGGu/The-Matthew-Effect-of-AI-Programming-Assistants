impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_champion(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut in_degree = vec![0; n];
        let mut graph = vec![Vec::new(); n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            in_degree[v] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut result = Vec::new();
        while let Some(node) = queue.pop_front() {
            result.push(node);
            for &neighbor in &graph[node] {
                in_degree[neighbor] -= 1;
                if in_degree[neighbor] == 0 {
                    queue.push_back(neighbor);
                }
            }
        }

        if result.len() == n {
            result[0] as i32
        } else {
            -1
        }
    }
}
}