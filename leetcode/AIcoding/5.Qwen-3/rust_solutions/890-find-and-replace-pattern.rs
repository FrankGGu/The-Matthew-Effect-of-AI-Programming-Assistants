impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
        fn match_pattern(word: &str, pattern: &str) -> bool {
            if word.len() != pattern.len() {
                return false;
            }
            let mut word_map = HashMap::new();
            let mut pattern_map = HashMap::new();
            for (w, p) in word.chars().zip(pattern.chars()) {
                if let Some(&mapped_w) = word_map.get(&p) {
                    if mapped_w != w {
                        return false;
                    }
                } else {
                    word_map.insert(p, w);
                }
                if let Some(&mapped_p) = pattern_map.get(&w) {
                    if mapped_p != p {
                        return false;
                    }
                } else {
                    pattern_map.insert(w, p);
                }
            }
            true
        }

        words.into_iter()
            .filter(|word| match_pattern(word, &pattern))
            .collect()
    }
}
}