impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_points(mut points: Vec<Vec<i32>>) -> i32 {
        let m = points.len();
        let n = points[0].len();

        for i in 1..m {
            let mut left = vec![0; n];
            let mut right = vec![0; n];

            left[0] = points[i - 1][0];
            for j in 1..n {
                left[j] = left[j - 1].max(points[i - 1][j]);
            }

            right[n - 1] = points[i - 1][n - 1];
            for j in (0..n - 1).rev() {
                right[j] = right[j + 1].max(points[i - 1][j]);
            }

            for j in 0..n {
                points[i][j] += left[j].max(right[j]);
            }
        }

        *points[m - 1].iter().max().unwrap()
    }
}
}