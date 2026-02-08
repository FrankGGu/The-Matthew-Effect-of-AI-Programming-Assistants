impl Solution {

use std::collections::{HashMap, BinaryHeap};

impl Solution {
    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for time in times {
            let u = time[0];
            let v = time[1];
            let w = time[2];
            graph.entry(u).or_insert_with(Vec::new).push((v, w));
        }

        let mut dist = vec![i32::MAX; (n + 1) as usize];
        dist[k as usize] = 0;

        let mut heap = BinaryHeap::new();
        heap.push((0, k));

        while let Some((time, node)) = heap.pop() {
            if time > dist[node as usize] {
                continue;
            }
            if let Some(neighbors) = graph.get(&node) {
                for &(neighbor, weight) in neighbors {
                    let new_time = time + weight;
                    if new_time < dist[neighbor as usize] {
                        dist[neighbor as usize] = new_time;
                        heap.push((new_time, neighbor));
                    }
                }
            }
        }

        let max_time = dist.into_iter().skip(1).fold(i32::MIN, |a, b| a.max(b));
        if max_time == i32::MAX { -1 } else { max_time }
    }
}
}