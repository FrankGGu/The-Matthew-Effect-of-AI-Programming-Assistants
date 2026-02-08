impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_number(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> i32 {
        let set1: HashSet<i32> = nums1.drain(..).collect();
        let set2: HashSet<i32> = nums2.drain(..).collect();

        let common: Vec<i32> = set1.intersection(&set2).cloned().collect();
        if !common.is_empty() {
            return *common.iter().min().unwrap();
        }

        let min1 = *nums1.iter().min().unwrap();
        let min2 = *nums2.iter().min().unwrap();

        if min1 < min2 {
            min1 * 10 + min2
        } else {
            min2 * 10 + min1
        }
    }
}
}