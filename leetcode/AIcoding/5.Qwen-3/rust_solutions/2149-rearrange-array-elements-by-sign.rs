impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn rearrange_by_sign(nums: Vec<i32>, n: i32) -> Vec<i32> {
        let mut pos = VecDeque::new();
        let mut neg = VecDeque::new();

        for num in nums {
            if num > 0 {
                pos.push_back(num);
            } else {
                neg.push_back(num);
            }
        }

        let mut result = Vec::new();
        let mut i = 0;
        while i < n as usize {
            result.push(pos[i]);
            result.push(neg[i]);
            i += 1;
        }

        result
    }
}
}