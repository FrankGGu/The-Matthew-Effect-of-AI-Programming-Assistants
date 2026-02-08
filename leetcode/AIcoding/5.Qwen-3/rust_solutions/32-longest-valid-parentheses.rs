struct Solution;

impl Solution {
    pub fn longest_valid_parentheses(s: String) -> i32 {
        let mut max_len = 0;
        let mut dp = vec![0; s.len()];

        for i in 1..s.len() {
            if s.as_bytes()[i] == b')' {
                if s.as_bytes()[i - 1] == b'(' {
                    dp[i] = if i >= 2 { dp[i - 2] + 2 } else { 2 };
                } else if i > 0 && s.as_bytes()[i - 1] == b')' && dp[i - 1] > 0 {
                    let prev_idx = i - dp[i - 1] - 1;
                    if prev_idx >= 0 && s.as_bytes()[prev_idx] == b'(' {
                        dp[i] = dp[i - 1] + 2;
                        if prev_idx > 0 {
                            dp[i] += dp[prev_idx - 1];
                        }
                    }
                }
                max_len = std::cmp::max(max_len, dp[i]);
            }
        }

        max_len
    }
}