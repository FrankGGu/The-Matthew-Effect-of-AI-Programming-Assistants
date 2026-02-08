impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn is_transformable(s: String, t: String) -> bool {
        let mut pos = vec![VecDeque::new(); 10];
        for (i, c) in s.chars().enumerate() {
            pos[c as usize - '0' as usize].push_back(i);
        }

        for (i, c) in t.chars().enumerate() {
            let d = c as usize - '0' as usize;
            if pos[d].is_empty() {
                return false;
            }
            while let Some(&j) = pos[d].front() {
                if j > i {
                    break;
                }
                pos[d].pop_front();
            }
            if pos[d].is_empty() {
                return false;
            }
            pos[d].pop_front();
        }
        true
    }
}
}