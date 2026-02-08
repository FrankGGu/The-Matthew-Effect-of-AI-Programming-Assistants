impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn nth_ugly_number(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![1; n];
        let mut i2 = 0;
        let mut i3 = 0;
        let mut i5 = 0;

        for i in 1..n {
            let next2 = dp[i2] * 2;
            let next3 = dp[i3] * 3;
            let next5 = dp[i5] * 5;

            let next = match (next2.cmp(&next3), next2.cmp(&next5)) {
                (Ordering::Less, Ordering::Less) => next2,
                (Ordering::Less, _) => next5,
                (Ordering::Equal, Ordering::Less) => next2,
                (Ordering::Equal, _) => next5,
                _ => next3,
            };

            dp[i] = next;

            if next == next2 {
                i2 += 1;
            }
            if next == next3 {
                i3 += 1;
            }
            if next == next5 {
                i5 += 1;
            }
        }

        dp[n - 1]
    }
}
}