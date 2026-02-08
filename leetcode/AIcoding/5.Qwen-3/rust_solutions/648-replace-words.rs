impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn replace_words(mut dictionary: Vec<String>, mut sentence: String) -> String {
        dictionary.sort_by(|a, b| a.len().cmp(&b.len()));
        let mut root_map = HashMap::new();

        for word in &dictionary {
            let mut prefix = String::new();
            for c in word.chars() {
                prefix.push(c);
                if !root_map.contains_key(&prefix) {
                    root_map.insert(prefix.clone(), word.clone());
                }
            }
        }

        let words: Vec<&str> = sentence.split_whitespace().collect();
        let mut result = Vec::new();

        for word in words {
            let mut prefix = String::new();
            let mut replaced = false;
            for c in word.chars() {
                prefix.push(c);
                if let Some(root) = root_map.get(&prefix) {
                    result.push(root);
                    replaced = true;
                    break;
                }
            }
            if !replaced {
                result.push(word);
            }
        }

        result.join(" ")
    }
}
}