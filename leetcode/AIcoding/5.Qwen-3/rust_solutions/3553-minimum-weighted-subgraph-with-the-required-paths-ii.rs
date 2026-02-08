impl Solution {

use std::collections::{HashMap, BinaryHeap};

impl Solution {
    pub fn min_edges_to_make_connected(n: i32, edges: Vec<Vec<i32>>, restricted: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for e in edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut restricted_set = HashMap::new();
        for &r in &restricted {
            restricted_set.insert(r as usize, ());
        }

        let mut visited = vec![false; n];
        let mut queue = BinaryHeap::new();
        let mut count = 0;

        for i in 0..n {
            if !visited[i] && !restricted_set.contains_key(&i) {
                count += 1;
                queue.push((0, i));
                while let Some((_, node)) = queue.pop() {
                    if visited[node] {
                        continue;
                    }
                    visited[node] = true;
                    for &neighbor in &graph[node] {
                        if !visited[neighbor] && !restricted_set.contains_key(&neighbor) {
                            queue.push((0, neighbor));
                        }
                    }
                }
            }
        }

        count - 1
    }
}
}