impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn check_similar_paths(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut parent = vec![0; n];
        let mut depth = vec![0; n];
        let mut visited = vec![false; n];

        fn dfs(u: usize, p: usize, d: i32, graph: &Vec<Vec<usize>>, parent: &mut Vec<usize>, depth: &mut Vec<i32>, visited: &mut Vec<bool>) {
            visited[u] = true;
            parent[u] = p;
            depth[u] = d;
            for &v in graph[u].iter() {
                if !visited[v] {
                    dfs(v, u, d + 1, graph, parent, depth, visited);
                }
            }
        }

        dfs(0, 0, 0, &graph, &mut parent, &mut depth, &mut visited);

        let mut lca_table = vec![vec![0; n]; 20];
        for i in 0..n {
            lca_table[0][i] = parent[i];
        }

        for j in 1..20 {
            for i in 0..n {
                lca_table[j][i] = lca_table[j - 1][lca_table[j - 1][i]];
            }
        }

        fn get_lca(u: usize, v: usize, depth: &Vec<i32>, lca_table: &Vec<Vec<usize>>) -> usize {
            if depth[u] < depth[v] {
                std::mem::swap(&mut u, &mut v);
            }

            for j in (0..20).rev() {
                if depth[u] - (1 << j) >= depth[v] {
                    u = lca_table[j][u];
                }
            }

            if u == v {
                return u;
            }

            for j in (0..20).rev() {
                if lca_table[j][u] != lca_table[j][v] {
                    u = lca_table[j][u];
                    v = lca_table[j][v];
                }
            }

            lca_table[0][u]
        }

        let mut result = Vec::new();
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let k = query[2] as usize;

            let lca = get_lca(u, v, &depth, &lca_table);
            let dist = depth[u] + depth[v] - 2 * depth[lca];
            if dist < k {
                result.push(false);
            } else {
                let mut path = HashSet::new();
                let mut current = u;
                while current != lca {
                    path.insert(current);
                    current = parent[current];
                }
                path.insert(lca);

                current = v;
                while current != lca {
                    path.insert(current);
                    current = parent[current];
                }

                result.push(path.len() >= k);
            }
        }

        result
    }
}
}