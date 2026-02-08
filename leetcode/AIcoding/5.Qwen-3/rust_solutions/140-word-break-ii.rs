impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> Vec<String> {
        let word_set: HashSet<String> = word_dict.into_iter().collect();
        let mut memo: std::collections::HashMap<usize, Vec<String>> = std::collections::HashMap::new();
        Self::dfs(&s, 0, &word_set, &mut memo)
    }

    fn dfs(s: &str, start: usize, word_set: &HashSet<String>, memo: &mut std::collections::HashMap<usize, Vec<String>>) -> Vec<String> {
        if let Some(result) = memo.get(&start) {
            return result.clone();
        }

        let mut result = Vec::new();
        if start == s.len() {
            result.push("".to_string());
            return result;
        }

        for end in start + 1..=s.len() {
            let word = &s[start..end];
            if word_set.contains(word) {
                let next_words = Self::dfs(s, end, word_set, memo);
                for next in next_words {
                    if next.is_empty() {
                        result.push(word.to_string());
                    } else {
                        result.push(format!("{} {}", word, next));
                    }
                }
            }
        }

        memo.insert(start, result.clone());
        result
    }
}
}