impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_possible(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let m = grid[0].len();

        let mut total_sum = 0;
        for row in &grid {
            for &val in row {
                total_sum += val;
            }
        }

        if total_sum % 2 != 0 {
            return false;
        }

        let target = total_sum / 2;

        let mut visited = HashSet::new();
        let mut dp = vec![false; target as usize + 1];
        dp[0] = true;

        for row in grid {
            for &val in &row {
                for i in (val..=target).rev() {
                    if dp[i - val as usize] {
                        dp[i] = true;
                    }
                }
            }
        }

        dp[target as usize]
    }
}
}