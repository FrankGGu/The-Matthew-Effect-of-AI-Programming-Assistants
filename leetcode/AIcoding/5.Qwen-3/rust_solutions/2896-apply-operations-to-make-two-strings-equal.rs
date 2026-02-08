struct Solution;

impl Solution {
    pub fn check_strings_equal(s: String, t: String) -> bool {
        let mut s_chars = s.chars().collect::<Vec<char>>();
        let mut t_chars = t.chars().collect::<Vec<char>>();

        s_chars.sort();
        t_chars.sort();

        s_chars == t_chars
    }
}