impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_envelopes(mut envelopes: Vec<Vec<i32>>) -> i32 {
        envelopes.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut dp = Vec::new();
        for envelope in envelopes {
            let h = envelope[1];
            let mut left = 0;
            let mut right = dp.len();
            while left < right {
                let mid = (left + right) / 2;
                if dp[mid] < h {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            if left == dp.len() {
                dp.push(h);
            } else {
                dp[left] = h;
            }
        }
        dp.len() as i32
    }
}
}