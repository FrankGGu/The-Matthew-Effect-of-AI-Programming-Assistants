impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn garden_no_adjacency(n: i32, paths: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];

        for path in paths {
            let u = path[0] as usize;
            let v = path[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut result = vec![0; n];

        for i in 0..n {
            let mut used = HashMap::new();
            for &neighbor in &graph[i] {
                if result[neighbor] != 0 {
                    used.insert(result[neighbor], ());
                }
            }

            for color in 1..=4 {
                if !used.contains_key(&color) {
                    result[i] = color;
                    break;
                }
            }
        }

        result.into_iter().map(|x| x as i32).collect()
    }
}
}