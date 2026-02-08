impl Solution {

use std::cmp;

impl Solution {
    pub fn min_eating_speed(piles: Vec<i32>, h: i32) -> i32 {
        let (mut left, mut right) = (1, *piles.iter().max().unwrap());

        while left < right {
            let mid = left + (right - left) / 2;
            let hours = piles.iter().map(|&pile| (pile + mid - 1) / mid).sum::<i32>();

            if hours <= h {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}

struct Solution;
}