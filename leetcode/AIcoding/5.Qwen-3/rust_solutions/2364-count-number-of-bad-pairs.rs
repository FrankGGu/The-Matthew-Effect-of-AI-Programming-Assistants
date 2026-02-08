impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_bad_pairs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut map = HashMap::new();
        let mut total = 0;
        for (i, &num) in nums.iter().enumerate() {
            let count = map.entry(num).or_insert(0);
            *count += 1;
            total += *count - 1;
        }
        total as i32
    }
}
}