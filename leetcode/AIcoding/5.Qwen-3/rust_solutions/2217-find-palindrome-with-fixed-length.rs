impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn palindrome_pairs(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut word_to_index = std::collections::HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            word_to_index.insert(num, i);
        }

        for (i, &num) in nums.iter().enumerate() {
            let s = num.to_string();
            let len = s.len();
            for j in 0..=len {
                let left = &s[..j];
                let right = &s[j..];
                if left.is_empty() {
                    continue;
                }
                let reversed_left = left.chars().rev().collect::<String>();
                if let Some(&k) = word_to_index.get(&reversed_left.parse().ok()?) {
                    if k != i && is_palindrome(&right) {
                        result.push(vec![i as i32, k as i32]);
                    }
                }
                let reversed_right = right.chars().rev().collect::<String>();
                if let Some(&k) = word_to_index.get(&reversed_right.parse().ok()?) {
                    if k != i && is_palindrome(&left) {
                        result.push(vec![k as i32, i as i32]);
                    }
                }
            }
        }

        result.into_iter().filter(|pair| pair[0] != pair[1]).collect()
    }
}

fn is_palindrome(s: &str) -> bool {
    s == s.chars().rev().collect::<String>()
}
}