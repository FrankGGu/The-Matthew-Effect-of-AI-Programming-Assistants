impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn get_happy_string(n: i32, k: i32) -> String {
        let mut result = Vec::new();
        let mut queue = VecDeque::new();
        queue.push_back(("", 0));

        while let Some((s, depth)) = queue.pop_front() {
            if depth == n as usize {
                result.push(s.to_string());
                continue;
            }
            for c in ['a', 'b', 'c'] {
                if s.is_empty() || s.chars().last().unwrap() != c {
                    let mut new_s = s.to_string();
                    new_s.push(c);
                    queue.push_back((&new_s[..], depth + 1));
                }
            }
        }

        result.get(k as usize - 1).map_or("".to_string(), |s| s.clone())
    }
}
}