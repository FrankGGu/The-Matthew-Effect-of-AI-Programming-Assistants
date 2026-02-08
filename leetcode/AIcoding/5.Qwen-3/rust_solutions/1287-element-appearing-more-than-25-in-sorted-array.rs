impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_special_integer(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = HashMap::new();

        for &num in &nums {
            let c = count.entry(num).or_insert(0);
            *c += 1;
            if *c > n / 4 {
                return num;
            }
        }

        nums[0]
    }
}
}