struct Solution;

impl Solution {
    pub fn is_subsequence(s: String, t: String) -> bool {
        let mut i = 0;
        let mut j = 0;
        let s_len = s.len();
        let t_len = t.len();

        while i < s_len && j < t_len {
            if s.as_bytes()[i] == t.as_bytes()[j] {
                i += 1;
            }
            j += 1;
        }

        i == s_len
    }
}