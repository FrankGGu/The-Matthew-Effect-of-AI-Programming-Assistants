impl Solution {

use std::cmp;

impl Solution {
    pub fn max_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut res = 0;
        for &num in &nums {
            let complement = k - num;
            if num == complement {
                if let Some(count) = freq.get(&num) {
                    res += *count / 2;
                    *freq.get_mut(&num).unwrap() = 0;
                }
            } else {
                if let (Some(count), Some(complement_count)) = (freq.get(&num), freq.get(&complement)) {
                    res += cmp::min(*count, *complement_count);
                    *freq.get_mut(&num).unwrap() = 0;
                    *freq.get_mut(&complement).unwrap() = 0;
                }
            }
        }

        res
    }
}
}