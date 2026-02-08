impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn can_convert(mut nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let mut count = 0;
        for i in 1..n {
            if nums[i] < nums[i - 1] {
                count += 1;
                if count > k {
                    return false;
                }
                nums[i] = nums[i - 1];
            }
        }
        true
    }
}
}