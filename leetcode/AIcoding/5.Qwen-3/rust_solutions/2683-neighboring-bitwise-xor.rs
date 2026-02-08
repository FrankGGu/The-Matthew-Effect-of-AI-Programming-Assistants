struct Solution;

impl Solution {
    pub fn is_valid_sequence(s: String, t: String) -> bool {
        if s.len() < t.len() {
            return false;
        }

        let mut i = 0;
        for c in t.chars() {
            if i >= s.len() {
                return false;
            }
            if s.chars().nth(i).unwrap() != c {
                return false;
            }
            i += 1;
        }

        true
    }
}