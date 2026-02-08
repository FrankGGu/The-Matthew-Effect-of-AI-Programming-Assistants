impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeMap;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Interval {
    pub start: i32,
    pub end: i32,
}

impl Solution {
    pub fn find_right_interval(mut intervals: Vec<Interval>) -> Vec<i32> {
        let n = intervals.len();
        let mut result = vec![-1; n];
        let mut sorted_intervals = intervals.clone();

        sorted_intervals.sort_by(|a, b| a.start.cmp(&b.start));

        for i in 0..n {
            let target = intervals[i].start;
            let mut left = 0;
            let mut right = n - 1;

            while left <= right {
                let mid = (left + right) / 2;
                if sorted_intervals[mid].start >= target {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            if left < n {
                result[i] = intervals.iter().position(|x| *x == sorted_intervals[left]).unwrap() as i32;
            }
        }

        result
    }
}
}