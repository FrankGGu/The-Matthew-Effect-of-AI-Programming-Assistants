impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn beautiful_indices(s: String, a: String, b: String) -> Vec<i32> {
        let mut indices = Vec::new();
        let a_len = a.len();
        let b_len = b.len();
        let s_len = s.len();

        if a_len == 0 || b_len == 0 {
            return (0..s_len as i32).collect();
        }

        let a_positions = Self::find_all_occurrences(&s, &a);
        let b_positions = Self::find_all_occurrences(&s, &b);

        let b_set: HashSet<usize> = b_positions.into_iter().collect();

        for &pos in &a_positions {
            let is_beautiful = (pos as i32 - a_len as i32) < 0 || !b_set.contains(&(pos - a_len));
            let is_beautiful = is_beautiful && (pos + a_len >= s_len || !b_set.contains(&(pos + a_len)));
            if is_beautiful {
                indices.push(pos as i32);
            }
        }

        indices
    }

    fn find_all_occurrences(s: &str, pattern: &str) -> Vec<usize> {
        let mut result = Vec::new();
        let pattern_len = pattern.len();
        let s_len = s.len();

        if pattern_len == 0 || s_len < pattern_len {
            return result;
        }

        for i in 0..=s_len - pattern_len {
            if &s[i..i + pattern_len] == pattern {
                result.push(i);
            }
        }

        result
    }
}
}