impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn minimize_manhattan_distances(n: i32, x: i32, y: i32, points: Vec<Vec<i32>>) -> i32 {
        let mut min_dist = i32::MAX;
        for p in &points {
            let dist = (p[0] - x).abs() + (p[1] - y).abs();
            if dist < min_dist {
                min_dist = dist;
            }
        }
        min_dist
    }
}
}