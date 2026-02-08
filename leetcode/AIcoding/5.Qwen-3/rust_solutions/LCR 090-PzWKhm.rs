impl Solution {

use std::cmp;

impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        if nums.len() == 1 {
            return nums[0];
        }
        if nums.len() == 2 {
            return cmp::max(nums[0], nums[1]);
        }

        fn helper(nums: &[i32]) -> i32 {
            let mut prev = 0;
            let mut curr = 0;
            for &num in nums {
                let temp = curr;
                curr = cmp::max(curr, prev + num);
                prev = temp;
            }
            curr
        }

        cmp::max(helper(&nums[1..]), helper(&nums[..nums.len()-1]))
    }
}
}