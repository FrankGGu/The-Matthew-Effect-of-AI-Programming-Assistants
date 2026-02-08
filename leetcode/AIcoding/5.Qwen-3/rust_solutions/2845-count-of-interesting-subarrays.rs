impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_interesting_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        count.insert(0, 1);
        let mut result = 0;
        let mut prefix = 0;
        let k = k as usize;

        for num in nums {
            if num % 3 == 1 {
                prefix += 1;
            } else if num % 3 == 2 {
                prefix -= 1;
            }

            let target = prefix - k;
            if let Some(&c) = count.get(&target) {
                result += c;
            }

            *count.entry(prefix).or_insert(0) += 1;
        }

        result
    }
}
}