impl Solution {
    pub fn can_reach(s: String, a: i32, b: i32) -> bool {
        let n = s.len();
        let mut dp = vec![false; n];
        dp[0] = true;
        for i in 0..n {
            if !dp[i] {
                continue;
            }
            let i64 = i as i64;
            let a_i = i64 + a;
            if a_i < n as i64 {
                dp[a_i as usize] = true;
            }
            let b_i = i64 + b;
            if b_i < n as i64 {
                dp[b_i as usize] = true;
            }
        }
        dp[n - 1]
    }
}