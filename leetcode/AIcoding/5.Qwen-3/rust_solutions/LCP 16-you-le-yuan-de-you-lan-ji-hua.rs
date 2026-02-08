impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_time(mut rides: Vec<Vec<i32>>, mut time: i32, mut k: i32) -> i32 {
        let n = rides.len();
        let mut graph = vec![vec![]; n];
        for i in 0..n {
            let (a, b) = (rides[i][0], rides[i][1]);
            graph[a as usize].push(b);
            graph[b as usize].push(a);
        }

        let mut visited = vec![false; n];
        let mut result = i32::MAX;

        fn dfs(
            graph: &Vec<Vec<i32>>,
            visited: &mut Vec<bool>,
            current: i32,
            time: i32,
            k: i32,
            result: &mut i32,
        ) {
            if k == 0 {
                *result = std::cmp::min(*result, time);
                return;
            }

            for &neighbor in graph[current as usize].iter() {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    dfs(graph, visited, neighbor, time + 1, k - 1, result);
                    visited[neighbor as usize] = false;
                }
            }
        }

        for i in 0..n {
            visited[i] = true;
            dfs(&graph, &mut visited, i as i32, 0, k, &mut result);
            visited[i] = false;
        }

        result
    }
}
}