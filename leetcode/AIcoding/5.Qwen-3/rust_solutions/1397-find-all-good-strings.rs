struct Solution;

impl Solution {
    pub fn find_good_strings(s: String, a: String, b: String) -> i32 {
        use std::collections::HashSet;

        fn count(n: i32, a: &str, b: &str) -> i32 {
            let mut dp = vec![0; n as usize + 1];
            dp[0] = 1;
            for i in 1..=n {
                dp[i] = dp[i - 1];
                if i >= a.len() {
                    dp[i] += dp[i - a.len()];
                }
                if i >= b.len() {
                    dp[i] += dp[i - b.len()];
                }
            }
            dp[n]
        }

        let mut set = HashSet::new();
        let mut res = 0;
        let n = s.len();

        for i in 0..n {
            for j in i..n {
                let substr = &s[i..j + 1];
                if substr.contains(&a) && substr.contains(&b) {
                    res += 1;
                }
            }
        }

        res
    }
}