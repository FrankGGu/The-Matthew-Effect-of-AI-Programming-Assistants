impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn smallest_subsequence(s: String, m: i32) -> String {
        let mut stack = VecDeque::new();
        let mut last_occurrence = vec![0; 26];
        let mut visited = vec![false; 26];

        for (i, c) in s.chars().enumerate() {
            last_occurrence[(c as u8 - b'a') as usize] = i;
        }

        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            if visited[idx] {
                continue;
            }

            while let Some(&top) = stack.back() {
                let top_idx = (top as u8 - b'a') as usize;
                if last_occurrence[top_idx] > i && !visited[top_idx] {
                    stack.pop_back();
                    visited[top_idx] = false;
                } else {
                    break;
                }
            }

            stack.push_back(c);
            visited[idx] = true;
        }

        stack.into_iter().take(m as usize).collect()
    }
}
}