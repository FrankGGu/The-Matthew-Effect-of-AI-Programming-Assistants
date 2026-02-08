impl Solution {

use std::collections::BTreeSet;

struct Solution {}

impl Solution {
    pub fn falling_squares(mut intervals: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut res = Vec::new();
        let mut intervals = intervals;
        let mut overlaps = BTreeSet::new();
        let mut heights = Vec::new();

        for interval in &intervals {
            let left = interval[0];
            let right = interval[1];
            let height = interval[1] - interval[0];

            let mut new_height = 0;
            let mut new_left = left;
            let mut new_right = right;

            for i in 0..heights.len() {
                let (h_left, h_right, h_height) = heights[i];
                if !(right <= h_left || left >= h_right) {
                    new_height = std::cmp::max(new_height, h_height);
                    new_left = std::cmp::min(new_left, h_left);
                    new_right = std::cmp::max(new_right, h_right);
                }
            }

            new_height += height;
            heights.push((new_left, new_right, new_height));
            res.push(vec![new_left, new_height]);
        }

        res
    }
}
}