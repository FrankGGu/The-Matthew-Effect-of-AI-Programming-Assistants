struct Solution {}

impl Solution {
    pub fn nth_ugly_number(n: i32) -> i32 {
        let mut dp = vec![1; n as usize];
        let mut i = 0;
        let mut j = 0;
        let mut k = 0;

        for m in 1..n as usize {
            let next2 = dp[i] * 2;
            let next3 = dp[j] * 3;
            let next5 = dp[k] * 5;
            let next = next2.min(next3).min(next5);
            dp[m] = next;

            if next == next2 {
                i += 1;
            }
            if next == next3 {
                j += 1;
            }
            if next == next5 {
                k += 1;
            }
        }

        dp[n as usize - 1]
    }
}