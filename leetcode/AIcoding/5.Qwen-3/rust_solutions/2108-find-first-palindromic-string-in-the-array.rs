impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn first_palindrome(words: Vec<String>) -> String {
        for word in words {
            let mut is_palindrome = true;
            let len = word.len();
            for i in 0..len / 2 {
                if word.as_bytes()[i] != word.as_bytes()[len - 1 - i] {
                    is_palindrome = false;
                    break;
                }
            }
            if is_palindrome {
                return word;
            }
        }
        String::new()
    }
}
}