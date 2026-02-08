impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn prime_palindrome(n: i32) -> String {
        let mut n = n;
        let mut s = n.to_string();
        let len = s.len();

        if len == 1 {
            return (n..=10).find(|&x| x.to_string() == x.to_string().chars().rev().collect::<String>()).unwrap().to_string();
        }

        let mut half_len = len / 2;
        let mut first_half = s[..half_len].to_string();
        let mut second_half = s[len - half_len..].to_string();

        let mut is_even = len % 2 == 0;
        let mut middle_char = if !is_even { Some(s[half_len..half_len + 1].to_string()) } else { None };

        let mut candidates = vec![];

        for i in 0..=9 {
            let mut temp = first_half.clone();
            temp.push(i.to_string().chars().next().unwrap());
            let mut candidate = temp.clone();

            if let Some(c) = middle_char {
                candidate.push(c.chars().next().unwrap());
            }

            candidate.push_str(&second_half);

            if candidate.len() < len {
                continue;
            }

            if candidate.len() > len {
                let mut new_candidate = temp;
                if !is_even {
                    new_candidate.push(middle_char.unwrap().chars().next().unwrap());
                }
                new_candidate.push_str(&second_half);
                candidates.push(new_candidate);
                continue;
            }

            if candidate.len() == len {
                candidates.push(candidate);
            }
        }

        let mut min_candidate = String::new();
        for candidate in candidates {
            let reversed = candidate.chars().rev().collect::<String>();
            if candidate == reversed {
                if min_candidate.is_empty() || candidate < min_candidate {
                    min_candidate = candidate;
                }
            }
        }

        if !min_candidate.is_empty() {
            return min_candidate;
        }

        let mut new_len = len + 1;
        let mut new_first_half = "1".to_string();
        for _ in 1..(new_len / 2) {
            new_first_half.push('0');
        }

        let mut new_candidate = new_first_half.clone();
        if new_len % 2 == 1 {
            new_candidate.push('0');
        }
        new_candidate.push_str(&new_first_half);

        new_candidate
    }
}
}