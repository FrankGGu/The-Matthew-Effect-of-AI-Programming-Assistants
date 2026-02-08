struct Solution;

impl Solution {
    pub fn is_harshad(num: i32) -> bool {
        let original = num;
        let mut sum = 0;
        let mut n = num.abs();
        while n > 0 {
            sum += n % 10;
            n /= 10;
        }
        if sum == 0 {
            return false;
        }
        original % sum == 0
    }
}