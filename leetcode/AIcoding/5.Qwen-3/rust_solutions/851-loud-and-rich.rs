impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn loud_and_rich(who: Vec<i32>, freq: Vec<Vec<i32>>) -> Vec<i32> {
        let n = who.len() as i32;
        let mut graph = vec![vec![]; n as usize];
        for edge in freq {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
        }

        let mut result = vec![0; n as usize];
        let mut visited = vec![false; n as usize];

        for i in 0..n as usize {
            dfs(i, &graph, &mut visited, &mut result, &who);
        }

        result
    }
}

fn dfs(
    node: usize,
    graph: &Vec<Vec<usize>>,
    visited: &mut Vec<bool>,
    result: &mut Vec<i32>,
    who: &Vec<i32>,
) {
    if visited[node] {
        return;
    }

    visited[node] = true;
    let mut max_who = who[node];

    for &neighbor in &graph[node] {
        dfs(neighbor, graph, visited, result, who);
        if who[neighbor] > max_who {
            max_who = who[neighbor];
        }
    }

    result[node] = max_who;
}
}