impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn get_longest_subsequence(s: String, k: i32) -> Vec<i32> {
        let s = s.chars().collect::<Vec<char>>();
        let n = s.len();
        let mut dp = vec![vec![]; n];
        let mut max_len = 0;
        let mut result = vec![];

        for i in 0..n {
            for j in 0..i {
                if s[i] != s[j] && dp[j].len() + 1 > dp[i].len() {
                    dp[i] = dp[j].clone();
                }
            }
            dp[i].push(i as i32);

            if dp[i].len() > max_len {
                max_len = dp[i].len();
                result = dp[i].clone();
            }
        }

        result
    }
}
}