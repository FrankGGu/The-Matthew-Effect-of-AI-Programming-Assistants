impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_matrix_sum(matrix: Vec<Vec<i64>>) -> i64 {
        let mut min_abs = i64::MAX;
        let mut total_sum = 0;
        let mut negative_count = 0;

        for row in matrix {
            for val in row {
                let abs_val = val.abs();
                total_sum += val;
                if abs_val < min_abs {
                    min_abs = abs_val;
                }
                if val < 0 {
                    negative_count += 1;
                }
            }
        }

        if negative_count % 2 == 0 {
            total_sum
        } else {
            total_sum - 2 * min_abs
        }
    }
}
}