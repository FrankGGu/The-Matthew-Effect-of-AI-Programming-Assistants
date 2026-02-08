impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn critical_connections(n: i32, connections: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut graph = HashMap::new();

        for conn in connections {
            let u = conn[0] as usize;
            let v = conn[1] as usize;
            graph.entry(u).or_insert(Vec::new()).push(v);
            graph.entry(v).or_insert(Vec::new()).push(u);
        }

        let mut time = 0;
        let mut disc = vec![-1; n];
        let mut low = vec![-1; n];
        let mut visited = vec![false; n];
        let mut result = Vec::new();

        fn dfs(
            node: usize,
            parent: usize,
            time: &mut i32,
            disc: &mut Vec<i32>,
            low: &mut Vec<i32>,
            visited: &mut Vec<bool>,
            graph: &HashMap<usize, Vec<usize>>,
            result: &mut Vec<Vec<i32>>,
        ) {
            visited[node] = true;
            *time += 1;
            disc[node] = *time;
            low[node] = *time;

            for &neighbor in graph.get(&node).unwrap_or(&vec![]) {
                if neighbor == parent {
                    continue;
                }

                if !visited[neighbor] {
                    dfs(neighbor, node, time, disc, low, visited, graph, result);
                    low[node] = low[node].min(low[neighbor]);

                    if low[neighbor] > disc[node] {
                        result.push(vec![node as i32, neighbor as i32]);
                    }
                } else {
                    low[node] = low[node].min(disc[neighbor]);
                }
            }
        }

        for i in 0..n {
            if !visited[i] {
                dfs(i, -1 as usize, &mut time, &mut disc, &mut low, &mut visited, &graph, &mut result);
            }
        }

        result
    }
}
}