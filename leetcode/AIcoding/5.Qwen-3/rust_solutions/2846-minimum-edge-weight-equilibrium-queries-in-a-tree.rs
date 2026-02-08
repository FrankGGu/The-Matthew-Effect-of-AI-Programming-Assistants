impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn min_edge_sum(mut queries: Vec<Vec<i32>>, edges: Vec<Vec<i32>>, values: Vec<i32>) -> Vec<i32> {
        let n = values.len();
        let mut graph = vec![vec![]; n];
        for i in 0..edges.len() {
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            graph[u].push((v, i));
            graph[v].push((u, i));
        }

        let mut edge_values = vec![0; edges.len()];
        for i in 0..edges.len() {
            edge_values[i] = values[edges[i][0] as usize] + values[edges[i][1] as usize];
        }

        let mut parent = vec![0; n];
        let mut depth = vec![0; n];
        let mut size = vec![0; n];
        let mut subtree_sum = vec![0; n];

        fn dfs(u: usize, p: usize, graph: &Vec<Vec<(usize, usize)>>, values: &Vec<i32>, parent: &mut Vec<usize>, depth: &mut Vec<usize>, size: &mut Vec<usize>, subtree_sum: &mut Vec<i32>) {
            parent[u] = p;
            depth[u] = depth[p] + 1;
            size[u] = 1;
            subtree_sum[u] = values[u];
            for &(v, _) in &graph[u] {
                if v != p {
                    dfs(v, u, graph, values, parent, depth, size, subtree_sum);
                    size[u] += size[v];
                    subtree_sum[u] += subtree_sum[v];
                }
            }
        }

        dfs(0, 0, &graph, &values, &mut parent, &mut depth, &mut size, &mut subtree_sum);

        let mut result = vec![0; queries.len()];
        for i in 0..queries.len() {
            let u = queries[i][0] as usize;
            let v = queries[i][1] as usize;
            let mut sum = 0;
            let mut lca = u;
            while lca != v {
                let mut max_subtree = 0;
                let mut edge_idx = 0;
                for &(neighbor, idx) in &graph[lca] {
                    if neighbor != parent[lca] && size[neighbor] > max_subtree {
                        max_subtree = size[neighbor];
                        edge_idx = idx;
                    }
                }
                sum += edge_values[edge_idx];
                lca = parent[lca];
            }
            result[i] = sum;
        }

        result
    }
}
}