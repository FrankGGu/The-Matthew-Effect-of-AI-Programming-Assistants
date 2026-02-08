impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_sum_of_hourglass(matrix: Vec<Vec<i32>>) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut max_sum = i32::MIN;

        for i in 0..rows - 2 {
            for j in 0..cols - 2 {
                let top = matrix[i][j] + matrix[i][j+1] + matrix[i][j+2];
                let middle = matrix[i+1][j+1];
                let bottom = matrix[i+2][j] + matrix[i+2][j+1] + matrix[i+2][j+2];
                let current_sum = top + middle + bottom;
                max_sum = max(max_sum, current_sum);
            }
        }

        max_sum
    }
}
}