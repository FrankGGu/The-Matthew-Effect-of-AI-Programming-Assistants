struct Solution;

impl Solution {
    pub fn longest_vowel_substring(s: String) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut max_len = 0;
        let mut current_len = 0;
        let mut prev_char = '\0';

        for c in s.chars() {
            if vowels.contains(&c) {
                if c >= prev_char {
                    current_len += 1;
                } else {
                    current_len = 1;
                }
                max_len = std::cmp::max(max_len, current_len);
            } else {
                current_len = 0;
            }
            prev_char = c;
        }

        max_len
    }
}