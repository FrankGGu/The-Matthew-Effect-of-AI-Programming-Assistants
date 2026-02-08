impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn added_integer(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums2 {
            *count.entry(num).or_insert(0) += 1;
        }

        for &num in &nums1 {
            let freq = count.get(&num).unwrap_or(&0);
            if *freq == 0 {
                return num - nums1[0];
            } else {
                *count.get_mut(&num).unwrap() -= 1;
            }
        }

        nums2[0] - nums1[0]
    }
}
}