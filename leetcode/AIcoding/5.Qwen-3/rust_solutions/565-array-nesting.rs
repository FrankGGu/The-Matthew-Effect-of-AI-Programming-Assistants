impl Solution {

use std::cmp;

impl Solution {
    pub fn array_nesting(nums: Vec<i32>) -> i32 {
        let mut visited = vec![false; nums.len()];
        let mut max_length = 0;

        for i in 0..nums.len() {
            if !visited[i] {
                let mut current = i;
                let mut length = 0;

                while !visited[current] {
                    visited[current] = true;
                    current = nums[current] as usize;
                    length += 1;
                }

                max_length = cmp::max(max_length, length);
            }
        }

        max_length
    }
}
}