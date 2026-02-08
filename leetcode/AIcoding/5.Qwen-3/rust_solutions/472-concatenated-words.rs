impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_concatenated_words(words: Vec<String>) -> Vec<String> {
        let mut word_set = HashSet::new();
        let mut result = Vec::new();

        for word in &words {
            word_set.insert(word.clone());
        }

        for word in &words {
            if dfs(word, &word_set, 0, 0) {
                result.push(word.clone());
            }
        }

        result
    }
}

fn dfs(word: &str, word_set: &HashSet<String>, start: usize, count: i32) -> bool {
    if start == word.len() {
        return count >= 2;
    }

    for end in start + 1..=word.len() {
        let sub = &word[start..end];
        if word_set.contains(sub) {
            if dfs(word, word_set, end, count + 1) {
                return true;
            }
        }
    }

    false
}
}