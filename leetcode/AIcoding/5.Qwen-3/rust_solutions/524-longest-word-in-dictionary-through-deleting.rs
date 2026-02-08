impl Solution {

use std::cmp::Ordering;
use std::collections::HashSet;

impl Solution {
    pub fn find_longest_word(mut s: String, mut d: Vec<String>) -> String {
        d.sort_by(|a, b| match b.len().cmp(&a.len()) {
            Ordering::Equal => a.cmp(b),
            other => other,
        });

        for word in d {
            if is_subsequence(&word, &s) {
                return word;
            }
        }

        String::new()
    }
}

fn is_subsequence(sub: &str, s: &str) -> bool {
    let mut i = 0;
    for c in s.chars() {
        if i < sub.len() && sub.chars().nth(i) == Some(c) {
            i += 1;
        }
    }
    i == sub.len()
}
}