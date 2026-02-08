impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn difference_of_sums(nums: Vec<i32>, m: i32) -> i32 {
        let mut divisible = 0;
        let mut non_divisible = 0;
        for &num in &nums {
            if num % m == 0 {
                divisible += num;
            } else {
                non_divisible += num;
            }
        }
        non_divisible - divisible
    }
}
}