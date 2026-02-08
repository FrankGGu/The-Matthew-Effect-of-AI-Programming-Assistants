impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_chain<P>(pairs: Vec<P>) -> i32
    where
        P: std::ops::Index<usize, Output = i32>,
        P: std::marker::Copy,
    {
        let mut pairs = pairs;
        pairs.sort_by(|a, b| {
            if a[1] < b[1] {
                Ordering::Less
            } else if a[1] > b[1] {
                Ordering::Greater
            } else {
                Ordering::Equal
            }
        });

        let mut count = 0;
        let mut last_end = i32::MIN;

        for pair in pairs {
            if pair[0] > last_end {
                count += 1;
                last_end = pair[1];
            }
        }

        count
    }
}
}