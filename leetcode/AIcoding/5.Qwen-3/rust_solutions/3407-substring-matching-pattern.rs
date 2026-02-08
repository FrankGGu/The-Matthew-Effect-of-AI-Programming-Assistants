impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn word_pattern(pattern: String, s: String) -> bool {
        let pattern_chars: Vec<char> = pattern.chars().collect();
        let words: Vec<&str> = s.split_whitespace().collect();

        if pattern_chars.len() != words.len() {
            return false;
        }

        let mut char_to_word = HashMap::new();
        let mut word_to_char = HashMap::new();

        for (c, word) in pattern_chars.iter().zip(words.iter()) {
            match char_to_word.get(c) {
                Some(existing_word) => {
                    if existing_word != word {
                        return false;
                    }
                },
                None => {
                    char_to_word.insert(c, *word);
                }
            }

            match word_to_char.get(word) {
                Some(existing_char) => {
                    if existing_char != c {
                        return false;
                    }
                },
                None => {
                    word_to_char.insert(*word, *c);
                }
            }
        }

        true
    }
}
}