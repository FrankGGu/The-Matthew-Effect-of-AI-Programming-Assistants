impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn earliest_second(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut positions = vec![Vec::new(); 26];

        for (i, &c) in t_chars.iter().enumerate() {
            positions[(c as u8 - b'a') as usize].push(i);
        }

        let mut queue = VecDeque::new();
        let mut marked = HashSet::new();
        let mut time = 0;

        for (i, &c) in s_chars.iter().enumerate() {
            if let Some(&pos) = positions[(c as u8 - b'a') as usize].first() {
                if pos == 0 {
                    queue.push_back(i);
                    marked.insert(i);
                }
            }
        }

        while let Some(index) = queue.pop_front() {
            if index == s_chars.len() - 1 {
                return time;
            }

            for (i, &c) in s_chars.iter().enumerate() {
                if !marked.contains(&i) && (i > index) {
                    if let Some(&pos) = positions[(c as u8 - b'a') as usize].first() {
                        if pos == 0 {
                            queue.push_back(i);
                            marked.insert(i);
                        }
                    }
                }
            }

            time += 1;
        }

        -1
    }
}
}