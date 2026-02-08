struct Solution;

impl Solution {
    pub fn num_unique_good_subsequences(s: String) -> i32 {
        let mut dp = vec![0; 2];
        let mut last = [false; 26];
        let mut has_zero = false;
        let mut has_one = false;

        for c in s.chars() {
            let idx = (c as u8 - b'a') as usize;
            if c == '0' {
                has_zero = true;
            } else if c == '1' {
                has_one = true;
            }
            let prev = dp[0];
            dp[0] = dp[1];
            dp[1] = prev + 1;
            if last[idx] {
                dp[1] -= dp[0];
            }
            last[idx] = true;
        }

        let result = dp[1] - dp[0];
        if has_zero && has_one {
            result
        } else {
            result - 1
        }
    }
}