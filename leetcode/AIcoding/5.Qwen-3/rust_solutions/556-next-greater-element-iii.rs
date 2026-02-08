impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn next_greater_element(mut n: i32) -> i32 {
        let mut digits: Vec<char> = n.to_string().chars().collect();
        let len = digits.len();
        let mut i = len - 1;

        while i > 0 && digits[i - 1] >= digits[i] {
            i -= 1;
        }

        if i == 0 {
            return -1;
        }

        let mut j = len - 1;
        while digits[j] <= digits[i - 1] {
            j -= 1;
        }

        digits.swap(i - 1, j);
        digits[i..].reverse();

        let result: String = digits.iter().collect();
        match result.parse::<i32>() {
            Ok(num) => num,
            Err(_) => -1,
        }
    }
}
}