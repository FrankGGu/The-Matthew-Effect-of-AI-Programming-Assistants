impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn min_common_val(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let set1: HashSet<_> = nums1.into_iter().collect();
        let set2: HashSet<_> = nums2.into_iter().collect();

        let mut common: Vec<_> = set1.intersection(&set2).cloned().collect();
        common.sort();

        common.into_iter().next().copied().unwrap_or(-1)
    }
}
}