impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn palindrome_pairs(words: Vec<String>) -> Vec<Vec<i32>> {
        let mut word_to_index = HashMap::new();
        for (i, word) in words.iter().enumerate() {
            word_to_index.insert(word, i);
        }

        let mut result = Vec::new();

        for (i, word) in words.iter().enumerate() {
            let word_len = word.len();
            for j in 0..word_len {
                let left = &word[..j];
                let right = &word[j..];

                if is_palindrome(left) {
                    let reversed_right = right.chars().rev().collect::<String>();
                    if let Some(&k) = word_to_index.get(&reversed_right) {
                        if k != i {
                            result.push(vec![k as i32, i as i32]);
                        }
                    }
                }

                if is_palindrome(right) {
                    let reversed_left = left.chars().rev().collect::<String>();
                    if let Some(&k) = word_to_index.get(&reversed_left) {
                        if k != i {
                            result.push(vec![i as i32, k as i32]);
                        }
                    }
                }
            }
        }

        result.sort();
        result.dedup();
        result
    }
}

fn is_palindrome(s: &str) -> bool {
    s == s.chars().rev().collect::<String>()
}
}