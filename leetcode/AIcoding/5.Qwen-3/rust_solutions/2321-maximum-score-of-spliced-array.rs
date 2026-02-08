impl Solution {

use std::cmp;

impl Solution {
    pub fn max_sum_subarray(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut max_diff = 0;
        let mut current_diff = 0;
        let mut max_subarray = 0;
        let mut current_subarray = 0;

        for i in 0..nums1.len() {
            let diff = nums1[i] - nums2[i];
            current_diff += diff;
            if current_diff < 0 {
                current_diff = 0;
            }
            max_diff = cmp::max(max_diff, current_diff);

            let sub_diff = nums2[i] - nums1[i];
            current_subarray += sub_diff;
            if current_subarray < 0 {
                current_subarray = 0;
            }
            max_subarray = cmp::max(max_subarray, current_subarray);
        }

        cmp::max(max_diff, max_subarray)
    }

    pub fn max_score_of_spliced_array(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let max1 = Self::max_sum_subarray(nums1.clone(), nums2.clone());
        let max2 = Self::max_sum_subarray(nums2, nums1);
        cmp::max(max1, max2)
    }
}
}