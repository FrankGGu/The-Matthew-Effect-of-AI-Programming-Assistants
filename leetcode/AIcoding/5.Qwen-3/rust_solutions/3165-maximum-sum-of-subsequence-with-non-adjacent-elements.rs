impl Solution {

use std::cmp;

impl Solution {
    pub fn max_sum_subsequence(nums: Vec<i32>) -> i32 {
        let mut prev = 0;
        let mut curr = 0;

        for num in nums {
            let temp = curr;
            curr = cmp::max(curr, prev + num);
            prev = temp;
        }

        curr
    }
}
}