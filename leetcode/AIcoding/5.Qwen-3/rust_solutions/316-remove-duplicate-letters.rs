impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn remove_duplicate_letters(s: String) -> String {
        let mut last_occurrence = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            last_occurrence.insert(c, i);
        }

        let mut stack = Vec::new();
        let mut visited = HashMap::new();

        for (i, c) in s.chars().enumerate() {
            if visited.contains_key(&c) {
                continue;
            }

            while let Some(&top) = stack.last() {
                if top < c && i < *last_occurrence.get(&top).unwrap() {
                    stack.pop();
                    visited.remove(&top);
                } else {
                    break;
                }
            }

            stack.push(c);
            visited.insert(c, true);
        }

        stack.into_iter().collect()
    }
}
}