impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn count_submatrices(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut count = 0;
        let mut row_sums = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                row_sums[j] += matrix[i][j];
            }

            for j in 0..n {
                let mut current_sum = 0;
                for l in j..n {
                    current_sum += row_sums[l];
                    if current_sum < k {
                        count += 1;
                    } else {
                        break;
                    }
                }
            }
        }

        count
    }
}
}