impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn buddy_strings(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }
        let mut diff = Vec::new();
        for (i, (a, b)) in s.chars().zip(goal.chars()).enumerate() {
            if a != b {
                diff.push(i);
                if diff.len() > 2 {
                    return false;
                }
            }
        }
        if diff.len() == 0 {
            let mut set = HashSet::new();
            for c in s.chars() {
                if !set.insert(c) {
                    return true;
                }
            }
            return false
        }
        if diff.len() == 2 {
            let i = diff[0];
            let j = diff[1];
            s.chars().nth(i) == goal.chars().nth(j) && s.chars().nth(j) == goal.chars().nth(i)
        } else {
            false
        }
    }
}
}