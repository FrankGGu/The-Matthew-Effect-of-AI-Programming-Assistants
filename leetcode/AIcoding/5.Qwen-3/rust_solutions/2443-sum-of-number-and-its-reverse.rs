struct Solution;

impl Solution {
    pub fn sum_of_number_and_reverse(num: i32) -> i32 {
        let reversed = num.to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
        num + reversed
    }
}