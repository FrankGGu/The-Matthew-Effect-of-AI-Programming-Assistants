impl Solution {

use std::cmp;

impl Solution {
    pub fn number_of_cuts(mut n: i32) -> i32 {
        if n == 1 {
            return 0;
        }
        if n % 2 == 0 {
            return n / 2;
        }
        n - 1
    }
}
}