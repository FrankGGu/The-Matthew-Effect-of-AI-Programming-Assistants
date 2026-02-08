struct Solution {}

impl Solution {
    pub fn add_digits(mut num: i32) -> i32 {
        while num >= 10 {
            let mut sum = 0;
            while num > 0 {
                sum += num % 10;
                num /= 10;
            }
            num = sum;
        }
        num
    }
}