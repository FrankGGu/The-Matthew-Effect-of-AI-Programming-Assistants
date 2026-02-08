impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn replace_elements(arr: Vec<i32>) -> Vec<i32> {
        let mut max_so_far = -1;
        let mut result = arr.clone();

        for i in (0..result.len()).rev() {
            let temp = result[i];
            result[i] = max_so_far;
            max_so_far = max_so_far.max(temp);
        }

        result
    }
}

pub struct Solution;
}