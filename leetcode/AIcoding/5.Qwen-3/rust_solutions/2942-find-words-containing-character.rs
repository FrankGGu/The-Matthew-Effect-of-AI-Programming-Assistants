struct Solution;

impl Solution {
    pub fn find_words_containing(s: String, c: char) -> Vec<String> {
        s.split_whitespace()
            .filter(|word| word.contains(c))
            .map(|word| word.to_string())
            .collect()
    }
}