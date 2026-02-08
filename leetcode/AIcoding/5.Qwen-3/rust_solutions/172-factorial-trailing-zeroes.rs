struct Solution {}

impl Solution {
    pub fn trailing_zeroes(n: i32) -> i32 {
        let mut count = 0;
        let mut num = n;
        while num > 0 {
            num /= 5;
            count += num;
        }
        count
    }
}