impl Solution {

use std::cmp::max;

struct Solution;

impl Solution {
    pub fn max_manhattan_distance(mut points: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = points.len();
        let mut max_dist = 0;

        for i in 0..n {
            for j in i + 1..n {
                let x1 = points[i][0];
                let y1 = points[i][1];
                let x2 = points[j][0];
                let y2 = points[j][1];

                let dist = (x1 - x2).abs() + (y1 - y2).abs();
                max_dist = max(max_dist, dist);
            }
        }

        max_dist
    }
}
}