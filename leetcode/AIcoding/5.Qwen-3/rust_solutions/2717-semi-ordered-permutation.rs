impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn semi_ordered_permutation(nums: Vec<i32>) -> i32 {
        let n = nums.len() as i32;
        let mut pos = vec![0; (n + 1) as usize];

        for (i, &num) in nums.iter().enumerate() {
            pos[num as usize] = i as i32;
        }

        if pos[1] < pos[2] {
            return (pos[2] - pos[1] - 1) + (n - 2 - pos[2]);
        } else {
            return (pos[1] - pos[2] - 1) + (n - 2 - pos[1]);
        }
    }
}
}