impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost_to_reach_destination(n: i32, roads: Vec<Vec<i32>>, t: i32, m: i32) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let cost = road[2];
            let time = road[3];
            graph[u].push((v, cost, time));
            graph[v].push((u, cost, time));
        }

        let mut dist = vec![i32::MAX; n];
        let mut time_dist = vec![i32::MAX; n];
        let mut heap = BinaryHeap::new();
        heap.push((0, 0, 0)); // (cost, time, node)
        dist[0] = 0;
        time_dist[0] = 0;

        while let Some((cost, time, u)) = heap.pop() {
            if u == n - 1 {
                return cost;
            }
            if cost > dist[u] || time > time_dist[u] {
                continue;
            }
            for &(v, c, t) in &graph[u] {
                let new_time = time + t;
                let new_cost = cost + c;
                if new_time <= t {
                    if new_cost < dist[v] || (new_cost == dist[v] && new_time < time_dist[v]) {
                        dist[v] = new_cost;
                        time_dist[v] = new_time;
                        heap.push((new_cost, new_time, v));
                    }
                }
            }
        }

        -1
    }
}
}