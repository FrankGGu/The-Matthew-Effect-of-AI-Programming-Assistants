impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_equal_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let mut map = HashMap::new();
        let mut max_len = 0;
        let mut left = 0;

        for (right, &num) in nums.iter().enumerate() {
            *map.entry(num).or_insert(0) += 1;

            while *map.get(&num).unwrap() as i32 - *map.get(&nums[left]).unwrap() > k {
                *map.get_mut(&nums[left]).unwrap() -= 1;
                left += 1;
            }

            max_len = std::cmp::max(max_len, right as i32 - left as i32 + 1);
        }

        max_len
    }
}
}