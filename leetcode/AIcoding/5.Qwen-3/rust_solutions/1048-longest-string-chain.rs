impl Solution {

use std::cmp::Ordering;
use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn longest_str_chain(words: Vec<String>) -> i32 {
        let mut words = words;
        words.sort_by(|a, b| a.len().cmp(&b.len()));

        let mut dp = HashMap::new();
        let mut max_length = 0;

        for word in words.iter() {
            let mut current_max = 0;
            for i in 0..word.len() {
                let mut prev = word.clone();
                prev.remove(i);
                if let Some(&length) = dp.get(&prev) {
                    current_max = current_max.max(length);
                }
            }
            dp.insert(word, current_max + 1);
            max_length = max_length.max(current_max + 1);
        }

        max_length
    }
}
}