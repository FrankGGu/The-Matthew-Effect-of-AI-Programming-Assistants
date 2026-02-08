impl Solution {

use std::cmp;

impl Solution {
    pub fn max_rep_opt_k_length(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;

        let mut left = 0;
        let mut max_len = 0;
        let mut count = std::collections::HashMap::new();

        for right in 0..n {
            *count.entry(s[right]).or_insert(0) += 1;

            while right - left + 1 - (count.values().sum::<i32>() - *count.values().max().unwrap()) > k {
                *count.entry(s[left]).or_insert(0) -= 1;
                if *count.entry(s[left]).or_insert(0) == 0 {
                    count.remove(&s[left]);
                }
                left += 1;
            }

            max_len = cmp::max(max_len, right - left + 1);
        }

        max_len as i32
    }
}
}