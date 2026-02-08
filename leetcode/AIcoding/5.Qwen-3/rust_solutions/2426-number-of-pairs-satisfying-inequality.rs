impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut set = BTreeSet::new();
        for i in 0..nums1.len() {
            set.insert(nums1[i] - nums2[i]);
        }
        let mut result = 0;
        let mut sorted: Vec<i32> = set.into_iter().collect();
        for i in 0..sorted.len() {
            for j in i + 1..sorted.len() {
                if sorted[j] - sorted[i] > 0 {
                    result += 1;
                }
            }
        }
        result
    }
}
}