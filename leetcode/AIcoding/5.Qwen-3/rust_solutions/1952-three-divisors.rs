struct Solution;

impl Solution {
    pub fn is_divisible_by_three(n: i32) -> bool {
        let mut sum = 0;
        let mut num = n;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum % 3 == 0
    }

    pub fn three_divisors(mut n: i32) -> bool {
        if n < 2 {
            return false;
        }
        let mut count = 0;
        for i in 2..=n {
            if n % i == 0 {
                count += 1;
                if count > 2 {
                    return false;
                }
            }
        }
        count == 2
    }
}