impl Solution {

use std::cmp;

impl Solution {
    pub fn min_swaps(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let ones = arr.iter().filter(|&&x| x == 1).count();
        if ones == 0 || ones == n {
            return 0;
        }

        let mut window_ones = 0;
        for i in 0..ones {
            if arr[i] == 1 {
                window_ones += 1;
            }
        }

        let mut max_window_ones = window_ones;
        for i in ones..n {
            if arr[i - ones] == 1 {
                window_ones -= 1;
            }
            if arr[i] == 1 {
                window_ones += 1;
            }
            max_window_ones = cmp::max(max_window_ones, window_ones);
        }

        (ones as i32) - max_window_ones
    }
}
}