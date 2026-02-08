impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn maximum_multiplication_score(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut max_score = i32::MIN;
        let mut result = 0;

        for i in 0..nums1.len() {
            let score = nums1[i] * nums2[i];
            match score.cmp(&max_score) {
                Ordering::Greater => {
                    max_score = score;
                    result = i as i32;
                },
                _ => {}
            }
        }

        result
    }
}
}