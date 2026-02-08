struct Solution;

impl Solution {
    pub fn is_substring_present(s: String) -> bool {
        let reversed = s.chars().rev().collect::<String>();
        for i in 0..s.len() {
            for j in i + 1..=s.len() {
                let substr = &s[i..j];
                if reversed.contains(substr) {
                    return true;
                }
            }
        }
        false
    }
}