impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn min_travel_time(mut roads: Vec<Vec<i32>>, mut queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = roads.len();
        let m = queries.len();

        let mut graph = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let t = road[2];
            graph[u].push((v, t));
            graph[v].push((u, t));
        }

        let mut dist = vec![vec![i32::MAX]; n];
        for i in 0..n {
            dist[i][i] = 0;
        }

        for i in 0..n {
            let mut pq = BinaryHeap::new();
            pq.push(Reverse((0, i)));

            while let Some(Reverse((d, u))) = pq.pop() {
                if d > dist[i][u] {
                    continue;
                }
                for &(v, w) in &graph[u] {
                    if dist[i][v] > d + w {
                        dist[i][v] = d + w;
                        pq.push(Reverse((dist[i][v], v)));
                    }
                }
            }
        }

        let mut result = vec![0; m];
        for (j, query) in queries.into_iter().enumerate() {
            let a = query[0] as usize;
            let b = query[1] as usize;
            result[j] = dist[a][b];
        }

        result
    }
}
}