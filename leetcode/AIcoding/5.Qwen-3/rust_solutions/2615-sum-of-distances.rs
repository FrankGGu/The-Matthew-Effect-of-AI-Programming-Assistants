impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn sum_distances(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut count = vec![1; n];
        let mut res = vec![0; n];

        fn dfs(u: usize, parent: usize, graph: &Vec<Vec<usize>>, count: &mut Vec<i32>, res: &mut Vec<i32>) {
            for v in &graph[u] {
                if *v != parent {
                    dfs(*v, u, graph, count, res);
                    count[u] += count[*v];
                    res[u] += res[*v] + count[*v];
                }
            }
        }

        fn dfs2(u: usize, parent: usize, graph: &Vec<Vec<usize>>, count: &mut Vec<i32>, res: &mut Vec<i32>) {
            for v in &graph[u] {
                if *v != parent {
                    res[*v] = res[u] - count[*v] + (count.len() as i32 - count[*v]);
                    dfs2(*v, u, graph, count, res);
                }
            }
        }

        dfs(0, 0, &graph, &mut count, &mut res);
        dfs2(0, 0, &graph, &mut count, &mut res);

        res
    }
}
}