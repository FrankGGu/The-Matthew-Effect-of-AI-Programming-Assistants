impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
        let mut result = Vec::new();
        let s_len = s.len();
        let p_len = p.len();

        if p_len > s_len {
            return result;
        }

        let mut p_count = HashMap::new();
        for c in p.chars() {
            *p_count.entry(c).or_insert(0) += 1;
        }

        let mut window_count = HashMap::new();
        for i in 0..p_len {
            let c = s.chars().nth(i).unwrap();
            *window_count.entry(c).or_insert(0) += 1;
        }

        if window_count == p_count {
            result.push(0);
        }

        for i in p_len..s_len {
            let out_char = s.chars().nth(i - p_len).unwrap();
            let in_char = s.chars().nth(i).unwrap();

            *window_count.entry(out_char).or_insert(0) -= 1;
            if window_count[&out_char] == 0 {
                window_count.remove(&out_char);
            }

            *window_count.entry(in_char).or_insert(0) += 1;

            if window_count == p_count {
                result.push((i - p_len + 1) as i32);
            }
        }

        result
    }
}
}