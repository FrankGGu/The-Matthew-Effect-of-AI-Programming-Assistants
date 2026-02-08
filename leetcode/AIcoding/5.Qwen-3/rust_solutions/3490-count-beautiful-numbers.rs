impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_beautiful_numbers(mut n: i32) -> i32 {
        let mut result = 0;
        let mut digits = vec![];

        while n > 0 {
            digits.push(n % 10);
            n /= 10;
        }

        let len = digits.len();
        let mut used = vec![false; 10];
        let mut count = 0;

        fn dfs(pos: usize, tight: bool, leading_zero: bool, sum: i32, used: &mut Vec<bool>, digits: &[i32], len: usize, count: &mut i32) {
            if pos == len {
                if !leading_zero && sum % 3 == 0 {
                    *count += 1;
                }
                return;
            }

            let max_digit = if tight { digits[pos] } else { 9 };

            for d in 0..=max_digit {
                let new_tight = tight && (d == max_digit);
                let new_leading_zero = leading_zero && (d == 0);
                let new_sum = if leading_zero && d == 0 {
                    sum
                } else {
                    sum + d
                };

                if !new_leading_zero && used[d as usize] {
                    continue;
                }

                used[d as usize] = true;
                dfs(pos + 1, new_tight, new_leading_zero, new_sum, used, digits, len, count);
                used[d as usize] = false;
            }
        }

        dfs(0, true, true, 0, &mut used, &digits, len, &mut result);

        result
    }
}
}