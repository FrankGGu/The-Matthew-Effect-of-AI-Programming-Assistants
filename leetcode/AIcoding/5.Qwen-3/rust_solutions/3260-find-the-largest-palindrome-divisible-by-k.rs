impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn largest_palindrome(n: i32) -> i32 {
        if n == 1 {
            return 9;
        }

        let mut max_num = 10_i64.pow(n as u32) - 1;
        let min_num = 10_i64.pow(n as u32 - 1);

        for left in (min_num..=max_num).rev() {
            let mut right = left;
            let mut palindrome = 0;
            let mut temp = left;

            while temp > 0 {
                palindrome = palindrome * 10 + temp % 10;
                temp /= 10;
            }

            palindrome = palindrome * 10 + left;

            for i in (min_num..=max_num).rev() {
                if i * i < palindrome {
                    break;
                }
                if palindrome % i == 0 {
                    return palindrome as i32;
                }
            }
        }

        9
    }
}
}