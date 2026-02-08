impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn sum_subarray_ranges(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut result = 0;
        let mut set = HashSet::new();

        for i in 0..n {
            set.clear();
            for j in i..n {
                set.insert(nums[j]);
                let min = *set.iter().min().unwrap();
                let max = *set.iter().max().unwrap();
                result += max - min;
            }
        }

        result
    }
}
}