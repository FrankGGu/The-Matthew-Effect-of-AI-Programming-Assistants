impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn max_distance(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut min_x = i32::MAX;
        let mut max_x = i32::MIN;
        let mut min_y = i32::MAX;
        let mut max_y = i32::MIN;

        for point in &points {
            let x = point[0];
            let y = point[1];
            min_x = min_x.min(x);
            max_x = max_x.max(x);
            min_y = min_y.min(y);
            max_y = max_y.max(y);
        }

        (max_x - min_x).max(max_y - min_y)
    }
}
}