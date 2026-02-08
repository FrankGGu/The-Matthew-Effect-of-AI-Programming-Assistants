impl Solution {
    pub fn append_characters(s: String, t: String) -> i32 {
        let mut i = 0;
        let mut j = 0;
        let s_len = s.len();
        let t_len = t.len();

        while i < s_len && j < t_len {
            if s.chars().nth(i) == t.chars().nth(j) {
                j += 1;
            }
            i += 1;
        }

        (t_len - j) as i32
    }
}