impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost_to_make_arrays_identical(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> i32 {
        let mut diff = BinaryHeap::new();
        for i in 0..nums1.len() {
            let d = nums1[i] - nums2[i];
            match d.cmp(&0) {
                Ordering::Greater => {
                    diff.push((d, 0));
                }
                Ordering::Less => {
                    diff.push(((-d), 1));
                },
                _ => {}
            }
        }

        let mut cost = 0;
        while let Some((val, typ)) = diff.pop() {
            if typ == 0 {
                cost += val;
            } else {
                cost += val;
            }
        }

        cost
    }
}

struct Solution {}
}