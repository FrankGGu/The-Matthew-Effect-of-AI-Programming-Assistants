impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn two_out_of_three(mut nums1: Vec<i32>, mut nums2: Vec<i32>, mut nums3: Vec<i32>) -> Vec<i32> {
        let set1: HashSet<_> = nums1.drain(..).collect();
        let set2: HashSet<_> = nums2.drain(..).collect();
        let set3: HashSet<_> = nums3.drain(..).collect();

        let mut result = HashSet::new();
        for num in &set1 {
            if set2.contains(num) || set3.contains(num) {
                result.insert(*num);
            }
        }
        for num in &set2 {
            if set1.contains(num) || set3.contains(num) {
                result.insert(*num);
            }
        }
        for num in &set3 {
            if set1.contains(num) || set2.contains(num) {
                result.insert(*num);
            }
        }

        result.into_iter().collect()
    }
}
}