impl Solution {

use std::cmp::min;

impl Solution {
    pub fn max_triangle_height(red: i32, blue: i32) -> i32 {
        let mut height = 0;
        let mut r = red;
        let mut b = blue;

        while r >= 0 && b >= 0 {
            height += 1;
            if r > b {
                r -= 1;
            } else {
                b -= 1;
            }
        }

        height - 1
    }
}
}