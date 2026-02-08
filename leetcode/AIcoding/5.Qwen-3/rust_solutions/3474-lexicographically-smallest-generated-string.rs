impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_lexicographically_smallest_string(s: String, a: i32, b: i32) -> String {
        let mut visited = HashMap::new();
        let mut queue = std::collections::VecDeque::new();
        let s_chars: Vec<char> = s.chars().collect();
        let mut result = s.clone();

        queue.push_back(s);
        visited.insert(s.clone(), true);

        while let Some(current) = queue.pop_front() {
            if current < result {
                result = current.clone();
            }

            let mut next1 = current.clone();
            for i in 0..next1.len() {
                let c = next1.as_bytes()[i] as i32;
                let new_c = (c + a) % 26;
                next1 = next1[..i].to_string() + &((new_c + b'0') as u8 as char).to_string() + &next1[i + 1..];
            }
            if !visited.contains_key(&next1) {
                visited.insert(next1.clone(), true);
                queue.push_back(next1);
            }

            let mut next2 = current.clone();
            let len = next2.len();
            let last_char = next2.as_bytes()[len - 1] as i32;
            let new_last_char = (last_char + a) % 26;
            next2 = next2[..len - 1].to_string() + &((new_last_char + b'0') as u8 as char).to_string();
            if !visited.contains_key(&next2) {
                visited.insert(next2.clone(), true);
                queue.push_back(next2);
            }
        }

        result
    }
}
}