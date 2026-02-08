impl Solution {

use std::iter;

impl Solution {
    pub fn difference_between_element_and_digit_sum(nums: Vec<i32>) -> i32 {
        let element_sum: i32 = nums.iter().sum();
        let digit_sum: i32 = nums
            .iter()
            .flat_map(|&num| {
                num.to_string()
                    .chars()
                    .map(|c| c.to_digit(10).unwrap() as i32)
            })
            .sum();
        element_sum - digit_sum
    }
}
}