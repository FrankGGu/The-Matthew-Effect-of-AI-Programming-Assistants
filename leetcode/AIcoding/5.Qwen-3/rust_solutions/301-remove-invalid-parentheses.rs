impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn remove_invalid_parentheses(s: String) -> Vec<String> {
        fn is_valid(s: &str) -> bool {
            let mut count = 0;
            for c in s.chars() {
                match c {
                    '(' => count += 1,
                    ')' => {
                        if count == 0 {
                            return false;
                        }
                        count -= 1;
                    }
                    _ => {}
                }
            }
            count == 0
        }

        let mut result = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(s.clone());

        let mut found = false;

        while let Some(current) = queue.pop_front() {
            if is_valid(&current) {
                result.insert(current);
                found = true;
            } else if !found {
                for i in 0..current.len() {
                    let mut next = current.clone();
                    next.remove(i);
                    queue.push_back(next);
                }
            }
        }

        result.into_iter().collect()
    }
}
}