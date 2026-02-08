impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn is_possible(n: i32, edges: Vec<Vec<i32>>) -> bool {
        let n = n as usize;
        let mut degree = vec![0; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut odd: Vec<usize> = degree.iter().enumerate().filter(|&(_, &d)| d % 2 == 1).map(|(i, _)| i).collect();

        if odd.len() == 0 {
            return true;
        }

        if odd.len() != 2 {
            return false;
        }

        let (u, v) = (odd[0], odd[1]);

        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(u);
        visited[u] = true;

        while let Some(node) = queue.pop_front() {
            for neighbor in 0..n {
                if !visited[neighbor] && (edges.iter().any(|e| (e[0] as usize == node && e[1] as usize == neighbor) || (e[0] as usize == neighbor && e[1] as usize == node))) {
                    visited[neighbor] = true;
                    queue.push_back(neighbor);
                }
            }
        }

        visited[v]
    }
}
}