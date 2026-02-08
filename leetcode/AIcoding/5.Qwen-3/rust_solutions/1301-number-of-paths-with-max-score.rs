impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn path_with_max_score(board: Vec<String>) -> Vec<i32> {
        let rows = board.len();
        let cols = board[0].len();
        let mut dp = vec![vec![(-1, 0); cols]; rows];
        dp[rows - 1][cols - 1] = (0, 1);

        for i in (0..rows).rev() {
            for j in (0..cols).rev() {
                if i == rows - 1 && j == cols - 1 {
                    continue;
                }
                if board[i][j..j + 1] == "X" {
                    continue;
                }
                let mut max_val = -1;
                let mut count = 0;
                for (di, dj) in &[(1, 0), (0, 1), (1, 1)] {
                    let ni = i + di;
                    let nj = j + dj;
                    if ni < rows && nj < cols {
                        let (val, cnt) = dp[ni][nj];
                        if val != -1 {
                            match val.cmp(&max_val) {
                                Ordering::Greater => {
                                    max_val = val;
                                    count = cnt;
                                }
                                Ordering::Equal => {
                                    count += cnt;
                                }
                                _ => {}
                            }
                        }
                    }
                }
                if max_val != -1 {
                    let current_val = board[i][j..j + 1].parse::<i32>().unwrap();
                    dp[i][j] = (current_val + max_val, count);
                }
            }
        }

        let (max_score, count) = dp[0][0];
        vec![max_score, count]
    }
}
}