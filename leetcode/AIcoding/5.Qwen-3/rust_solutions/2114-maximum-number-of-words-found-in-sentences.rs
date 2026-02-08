struct Solution;

impl Solution {
    pub fn most_words_found(sentences: Vec<String>) -> i32 {
        let mut max_words = 0;
        for sentence in sentences {
            let words: Vec<&str> = sentence.split_whitespace().collect();
            let word_count = words.len();
            if word_count > max_words {
                max_words = word_count;
            }
        }
        max_words as i32
    }
}