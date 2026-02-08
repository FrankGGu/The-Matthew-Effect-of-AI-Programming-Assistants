impl Solution {

use std::collections::{BinaryHeap, HashSet};

impl Solution {
    pub fn second_minimum_time(n: i32, edges: Vec<Vec<i32>>, time: i32, _path: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut dist = vec![i32::MAX; n];
        let mut second_dist = vec![i32::MAX; n];

        let mut heap = BinaryHeap::new();
        heap.push((0, 0));

        while let Some((d, node)) = heap.pop() {
            if d > second_dist[node] {
                continue;
            }

            for &neighbor in &graph[node] {
                let new_d = d + time;
                if new_d < dist[neighbor] {
                    std::mem::swap(&mut dist[neighbor], &mut second_dist[neighbor]);
                    dist[neighbor] = new_d;
                    heap.push((dist[neighbor], neighbor));
                } else if new_d != dist[neighbor] && new_d < second_dist[neighbor] {
                    second_dist[neighbor] = new_d;
                    heap.push((new_d, neighbor));
                }
            }
        }

        second_dist[n - 1]
    }
}

struct Solution {}
}