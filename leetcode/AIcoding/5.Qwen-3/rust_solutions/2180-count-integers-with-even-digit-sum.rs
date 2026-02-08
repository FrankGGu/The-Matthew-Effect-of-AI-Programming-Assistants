struct Solution;

impl Solution {
    pub fn count_even(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            let mut sum = 0;
            let mut num = i;
            while num > 0 {
                sum += num % 10;
                num /= 10;
            }
            if sum % 2 == 0 {
                count += 1;
            }
        }
        count
    }
}