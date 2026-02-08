impl Solution {

use std::cmp::Ordering;
use std::collections::HashSet;

impl Solution {
    pub fn minimum_abs_diff(arr: Vec<i32>) -> Vec<Vec<i32>> {
        let mut arr = arr;
        arr.sort();
        let mut min_diff = i32::MAX;
        let mut result = Vec::new();

        for i in 0..arr.len() - 1 {
            let diff = arr[i + 1] - arr[i];
            match diff.cmp(&min_diff) {
                Ordering::Less => {
                    min_diff = diff;
                    result.clear();
                    result.push(vec![arr[i], arr[i + 1]]);
                },
                Ordering::Equal => {
                    result.push(vec![arr[i], arr[i + 1]]);
                },
                _ => {}
            }
        }

        result
    }
}
}