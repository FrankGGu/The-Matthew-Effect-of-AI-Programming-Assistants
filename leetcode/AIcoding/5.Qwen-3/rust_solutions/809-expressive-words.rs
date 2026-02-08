struct Solution;

impl Solution {
    pub fn expressive_words(mut words: Vec<String>, s: String) -> i32 {
        let mut count = 0;
        for word in words {
            if is_expressive(&word, &s) {
                count += 1;
            }
        }
        count
    }

    fn is_expressive(word: &str, s: &str) -> bool {
        let mut i = 0;
        let mut j = 0;
        while i < word.len() && j < s.len() {
            let w_char = word.chars().nth(i).unwrap();
            let s_char = s.chars().nth(j).unwrap();
            if w_char != s_char {
                return false;
            }
            let mut w_count = 0;
            while i < word.len() && word.chars().nth(i).unwrap() == w_char {
                i += 1;
                w_count += 1;
            }
            let mut s_count = 0;
            while j < s.len() && s.chars().nth(j).unwrap() == s_char {
                j += 1;
                s_count += 1;
            }
            if w_count > s_count || (s_count < 3 && w_count != s_count) {
                return false;
            }
        }
        i == word.len() && j == s.len()
    }
}