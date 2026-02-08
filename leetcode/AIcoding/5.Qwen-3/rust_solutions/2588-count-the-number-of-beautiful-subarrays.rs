impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn beautiful_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut prefix_xor = 0;
        let mut count = 0;
        let mut map = HashMap::new();
        map.insert(0, 1);

        for num in nums {
            prefix_xor ^= num;
            let target = prefix_xor ^ k;
            count += *map.get(&target).unwrap_or(&0);
            *map.entry(prefix_xor).or_insert(0) += 1;
        }

        count
    }
}

pub struct Solution;
}