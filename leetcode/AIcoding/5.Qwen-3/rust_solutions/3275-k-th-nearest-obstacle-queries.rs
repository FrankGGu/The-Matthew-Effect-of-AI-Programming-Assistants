impl Solution {

use std::collections::{BinaryHeap, HashMap};

struct Point {
    x: i32,
    y: i32,
}

struct KthNearestObstacleQueries {}

impl KthNearestObstacleQueries {
    pub fn k_closest_obstacles(
        obstacles: Vec<Vec<i32>>,
        queries: Vec<Vec<i32>>,
        k: i32,
    ) -> Vec<Vec<Vec<i32>>> {
        let mut result = Vec::new();
        let mut map = HashMap::new();

        for obstacle in &obstacles {
            let key = (obstacle[0], obstacle[1]);
            map.entry(key).or_insert_with(Vec::new).push(obstacle.clone());
        }

        for query in &queries {
            let qx = query[0];
            let qy = query[1];
            let mut heap = BinaryHeap::new();

            for (&(ox, oy), _) in &map {
                let dist = (qx - ox).abs() + (qy - oy).abs();
                heap.push((dist, ox, oy));
            }

            let mut res = Vec::new();
            for _ in 0..k {
                if let Some((_, ox, oy)) = heap.pop() {
                    res.push(vec![ox, oy]);
                }
            }

            res.sort_by(|a, b| {
                let d1 = (qx - a[0]).abs() + (qy - a[1]).abs();
                let d2 = (qx - b[0]).abs() + (qy - b[1]).abs();
                d1.cmp(&d2)
            });

            result.push(res);
        }

        result
    }
}
}