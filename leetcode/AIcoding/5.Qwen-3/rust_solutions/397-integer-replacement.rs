struct Solution {}

impl Solution {
    pub fn integer_replacement(n: i32) -> i32 {
        let mut n = n;
        let mut count = 0;
        while n > 1 {
            if n % 2 == 0 {
                n /= 2;
            } else {
                if n == 1 {
                    break;
                }
                if (n & 1) == 0 {
                    n /= 2;
                } else {
                    n += 1;
                }
            }
            count += 1;
        }
        count
    }
}