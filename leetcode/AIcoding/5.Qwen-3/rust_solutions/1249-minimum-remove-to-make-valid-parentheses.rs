impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_remove_to_make_valid(s: String) -> String {
        let mut to_remove = HashSet::new();
        let mut stack = Vec::new();

        for (i, c) in s.chars().enumerate() {
            if c == '(' {
                stack.push(i);
            } else if c == ')' {
                if !stack.is_empty() {
                    stack.pop();
                } else {
                    to_remove.insert(i);
                }
            }
        }

        to_remove.extend(stack);

        s.chars()
            .enumerate()
            .filter(|(i, _)| !to_remove.contains(i))
            .map(|(_, c)| c)
            .collect()
    }
}
}