impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_profit_assignment(
        n: i32,
        edges: Vec<Vec<i32>>,
        profit: Vec<i32>,
        queries: Vec<Vec<i32>>,
    ) -> Vec<i32> {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
        }

        let mut in_degree = vec![0; n as usize];
        for u in 0..n as usize {
            for &v in &graph[u] {
                in_degree[v as usize] += 1;
            }
        }

        let mut topo_order = Vec::new();
        let mut queue = VecDeque::new();

        for i in 0..n as usize {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        while let Some(u) = queue.pop_front() {
            topo_order.push(u);
            for &v in &graph[u] {
                in_degree[v as usize] -= 1;
                if in_degree[v as usize] == 0 {
                    queue.push_back(v as usize);
                }
            }
        }

        let mut dp = vec![0; n as usize];
        for &u in &topo_order {
            for &v in &graph[u] {
                dp[v as usize] = dp[v as usize].max(dp[u] + profit[v as usize]);
            }
        }

        let mut result = Vec::new();
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            result.push(dp[v] - dp[u]);
        }

        result
    }
}
}