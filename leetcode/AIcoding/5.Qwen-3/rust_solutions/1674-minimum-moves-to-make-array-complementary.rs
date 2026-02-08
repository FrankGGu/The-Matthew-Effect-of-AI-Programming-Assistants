impl Solution {

use std::cmp::min;

struct Solution;

impl Solution {
    pub fn min_moved_stones_less_than_or_equal_to_x(
        arr: Vec<i32>,
        x: i32,
    ) -> i32 {
        let n = arr.len();
        let mut sorted = arr.clone();
        sorted.sort();
        let mut res = 0;
        let mut left = 0;
        for right in 0..n {
            while sorted[right] - sorted[left] > x {
                left += 1;
            }
            res = max(res, right - left + 1);
        }
        (n as i32) - res
    }

    pub fn min_moves_to_make_array_complementary(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut sorted = arr.clone();
        sorted.sort();
        let mut min_moves = n as i32;
        let mut left = 0;
        for right in 0..n {
            while sorted[right] - sorted[left] > 1 {
                left += 1;
            }
            let current = right - left + 1;
            min_moves = min(min_moves, n as i32 - current);
        }
        min_moves
    }
}
}