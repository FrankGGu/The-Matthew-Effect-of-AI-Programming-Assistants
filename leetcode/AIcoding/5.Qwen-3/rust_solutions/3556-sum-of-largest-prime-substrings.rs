impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn largest_prime_substring(s: String) -> i32 {
        fn is_prime(n: i32) -> bool {
            if n < 2 {
                return false;
            }
            for i in 2..=((n as f64).sqrt() as i32) {
                if n % i == 0 {
                    return false;
                }
            }
            true
        }

        let mut max_prime = 0;
        let chars: Vec<char> = s.chars().collect();
        let len = chars.len();

        for i in 0..len {
            for j in i + 1..=len {
                let substr = &chars[i..j];
                let num_str: String = substr.iter().collect();
                if let Ok(num) = num_str.parse::<i32>() {
                    if is_prime(num) {
                        max_prime = std::cmp::max(max_prime, num);
                    }
                }
            }
        }

        max_prime
    }
}
}