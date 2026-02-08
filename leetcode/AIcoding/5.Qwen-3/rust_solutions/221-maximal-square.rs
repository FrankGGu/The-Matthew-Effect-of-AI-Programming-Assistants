impl Solution {

use std::cmp::max;

impl Solution {
    pub fn maximal_square(mut matrix: Vec<Vec<char>>) -> i32 {
        let rows = matrix.len();
        let cols = if rows > 0 { matrix[0].len() } else { 0 };
        let mut dp = vec![vec![0; cols]; rows];
        let mut max_side = 0;

        for i in 0..rows {
            for j in 0..cols {
                if matrix[i][j] == '1' {
                    if i == 0 || j == 0 {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = (min(dp[i - 1][j], dp[i][j - 1]) + 1).min(2);
                    }
                    max_side = max(max_side, dp[i][j]);
                }
            }
        }

        max_side * max_side
    }
}

fn min(a: i32, b: i32) -> i32 {
    if a < b { a } else { b }
}

struct Solution;
}