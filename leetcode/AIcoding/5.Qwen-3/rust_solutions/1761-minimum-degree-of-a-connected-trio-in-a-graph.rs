impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn min_trio_degree(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![HashSet::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].insert(v);
            graph[v].insert(u);
        }

        let mut min_degree = i32::MAX;

        for i in 0..n {
            for j in graph[i].iter() {
                if *j > i {
                    for k in graph[*j].iter() {
                        if *k > *j && graph[i].contains(k) {
                            let degree = graph[i].len() as i32 + graph[*j].len() as i32 + graph[*k].len() as i32;
                            min_degree = std::cmp::min(min_degree, degree);
                        }
                    }
                }
            }
        }

        if min_degree == i32::MAX {
            -1
        } else {
            min_degree
        }
    }
}
}