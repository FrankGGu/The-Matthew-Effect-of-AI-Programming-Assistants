struct Solution;

impl Solution {
    pub fn is_happy(n: i32) -> bool {
        let mut slow = n;
        let mut fast = n;

        loop {
            slow = Self::sum_of_squares(slow);
            fast = Self::sum_of_squares(Self::sum_of_squares(fast));

            if slow == 1 {
                return true;
            }

            if slow == fast {
                return false;
            }
        }
    }

    fn sum_of_squares(mut n: i32) -> i32 {
        let mut sum = 0;
        while n > 0 {
            let digit = n % 10;
            sum += digit * digit;
            n /= 10;
        }
        sum
    }
}