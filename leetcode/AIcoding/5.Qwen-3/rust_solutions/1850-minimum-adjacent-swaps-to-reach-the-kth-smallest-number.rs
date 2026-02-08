impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn get_min_swaps(mut num: String, k: i32) -> i32 {
        let mut num = num.chars().collect::<Vec<_>>();
        let mut swaps = 0;
        let k = k as usize;

        for i in 0..k {
            let mut min_idx = i;
            for j in i + 1..num.len() {
                if num[j] < num[min_idx] {
                    min_idx = j;
                }
            }

            for j in min_idx..i {
                num.swap(j, j - 1);
                swaps += 1;
            }
        }

        swaps as i32
    }
}
}