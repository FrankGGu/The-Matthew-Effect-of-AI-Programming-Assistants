impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost(n: i32, m: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let mut h = horizontal_cuts;
        let mut v = vertical_cuts;
        h.push(0);
        h.push(n);
        v.push(0);
        v.push(m);
        h.sort();
        v.sort();

        let mut h_diff = BinaryHeap::new();
        for i in 1..h.len() {
            h_diff.push(Reverse(h[i] - h[i-1]));
        }

        let mut v_diff = BinaryHeap::new();
        for i in 1..v.len() {
            v_diff.push(Reverse(v[i] - v[i-1]));
        }

        let mut max_h = 0;
        let mut max_v = 0;

        while let Some(Reverse(d)) = h_diff.pop() {
            max_h += d;
        }

        while let Some(Reverse(d)) = v_diff.pop() {
            max_v += d;
        }

        (max_h * max_v) % 1000000007
    }
}
}