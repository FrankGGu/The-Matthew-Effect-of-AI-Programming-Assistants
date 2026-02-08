struct Solution;

impl Solution {
    pub fn arrange_words(s: String) -> String {
        let words: Vec<&str> = s.split_whitespace().collect();
        let mut words = words.into_iter().map(|w| w.to_lowercase()).collect::<Vec<String>>();
        words.sort_by_key(|w| w.len());
        words.join(" ")
    }
}