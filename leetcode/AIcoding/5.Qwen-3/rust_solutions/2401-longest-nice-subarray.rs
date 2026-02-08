impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_nice_subarray(nums: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..nums.len() {
            let num = nums[right];
            while map.contains_key(&num) && map[&num] >= left {
                left += 1;
            }
            map.insert(num, right);
            max_len = std::cmp::max(max_len, (right - left + 1) as i32);
        }

        max_len
    }
}
}