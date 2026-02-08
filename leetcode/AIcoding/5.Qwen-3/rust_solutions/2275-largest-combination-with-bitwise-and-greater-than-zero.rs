impl Solution {

use std::cmp::max;

struct Solution {}

impl Solution {
    pub fn largest_combination(mut candidates: Vec<i32>) -> i32 {
        let mut max_count = 0;
        for i in 0..32 {
            let mut count = 0;
            for &num in &candidates {
                if (num >> i) & 1 == 1 {
                    count += 1;
                }
            }
            max_count = max(max_count, count);
        }
        max_count
    }
}
}