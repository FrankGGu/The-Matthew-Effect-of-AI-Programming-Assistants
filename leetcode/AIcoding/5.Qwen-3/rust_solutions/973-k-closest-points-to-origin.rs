impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn k_closest_points_to_origin(mut points: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let k = k as usize;
        points.sort_by(|a, b| {
            let dist_a = a[0].pow(2) + a[1].pow(2);
            let dist_b = b[0].pow(2) + b[1].pow(2);
            dist_a.cmp(&dist_b)
        });
        points.truncate(k);
        points
    }
}
}