impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_smallest_palindrome(s: String) -> String {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut odd_char = None;
        let mut half = String::new();

        for (c, &count) in &freq {
            if count % 2 == 1 {
                if odd_char.is_none() {
                    odd_char = Some(*c);
                }
            }
            let mut temp = *c;
            for _ in 0..(count / 2) {
                half.push(temp);
            }
        }

        let mut half_chars: Vec<char> = half.chars().collect();
        half_chars.sort();
        let half_sorted = half_chars.into_iter().collect::<String>();

        let mut result = half_sorted.clone();
        if let Some(c) = odd_char {
            result.push(c);
        }
        result.push_str(&half_sorted.chars().rev().collect::<String>());
        result
    }
}
}