impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn find_peak(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut left = 0;
        let mut right = cols - 1;

        while left <= right {
            let mid_col = left + (right - left) / 2;
            let mut max_row = 0;

            for i in 1..rows {
                if matrix[i][mid_col] > matrix[max_row][mid_col] {
                    max_row = i;
                }
            }

            let current = matrix[max_row][mid_col];
            let left_val = if mid_col > 0 { matrix[max_row][mid_col - 1] } else { i32::MIN };
            let right_val = if mid_col < cols - 1 { matrix[max_row][mid_col + 1] } else { i32::MIN };

            match current.cmp(&left_val) {
                Ordering::Greater => {
                    match current.cmp(&right_val) {
                        Ordering::Greater => return vec![max_row as i32, mid_col as i32],
                        _ => left = mid_col + 1,
                    }
                }
                _ => right = mid_col - 1,
            }
        }

        vec![]
    }
}
}