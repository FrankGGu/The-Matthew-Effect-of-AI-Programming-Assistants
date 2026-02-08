impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_increments(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let mut res = 0;
        for i in 0..nums.len() {
            if nums[i] < k {
                res += k - nums[i];
                nums[i] = k;
            }
            if i > 0 && nums[i] == nums[i - 1] {
                res += 1;
                nums[i] += 1;
            }
        }
        res
    }
}
}