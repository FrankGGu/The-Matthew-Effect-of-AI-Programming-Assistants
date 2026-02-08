struct Solution;

impl Solution {
    pub fn can_remove(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut i = 0;
        let mut j = 0;
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        while i < s.len() && j < t.len() {
            if s_bytes[i] == t_bytes[j] {
                i += 1;
                j += 1;
            } else if s_bytes[i] == b'L' {
                return false;
            } else if s_bytes[i] == b'R' {
                if j == 0 || t_bytes[j - 1] != b'R' {
                    return false;
                }
                j += 1;
            } else {
                return false;
            }
        }

        i == s.len() && j == t.len()
    }

    pub fn can_transform(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut i = 0;
        let mut j = 0;
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        while i < s.len() && j < t.len() {
            if s_bytes[i] == t_bytes[j] {
                i += 1;
                j += 1;
            } else if s_bytes[i] == b'L' {
                if j == 0 || t_bytes[j - 1] != b'L' {
                    return false;
                }
                j += 1;
            } else if s_bytes[i] == b'R' {
                if j == 0 || t_bytes[j - 1] != b'R' {
                    return false;
                }
                j += 1;
            } else {
                return false;
            }
        }

        i == s.len() && j == t.len()
    }
}