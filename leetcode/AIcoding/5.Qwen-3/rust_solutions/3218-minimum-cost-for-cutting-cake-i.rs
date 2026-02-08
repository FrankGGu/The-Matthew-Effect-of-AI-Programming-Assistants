impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost_to_cut_cake(mut horizontal_cuts: Vec<i32>, mut vertical_cuts: Vec<i32>) -> i32 {
        horizontal_cuts.sort();
        vertical_cuts.sort();

        let mut max_h = 0;
        let mut prev = 0;
        for h in horizontal_cuts {
            max_h = max_h.max(h - prev);
            prev = h;
        }
        max_h = max_h.max(1000000000 - prev);

        let mut max_v = 0;
        let mut prev_v = 0;
        for v in vertical_cuts {
            max_v = max_v.max(v - prev_v);
            prev_v = v;
        }
        max_v = max_v.max(1000000000 - prev_v);

        (max_h as i64 * max_v as i64) as i32
    }
}
}