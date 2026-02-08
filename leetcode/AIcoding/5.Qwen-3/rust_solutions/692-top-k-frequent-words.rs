impl Solution {

use std::collections::{HashMap, BinaryHeap};
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn top_k_frequent(words: Vec<String>, k: i32) -> Vec<String> {
        let mut freq = HashMap::new();
        for word in &words {
            *freq.entry(word).or_insert(0) += 1;
        }

        let mut heap = BinaryHeap::new();
        for (word, count) in &freq {
            heap.push((Reverse(*count), word.clone()));
        }

        let mut result = Vec::new();
        for _ in 0..k {
            if let Some((Reverse(_), word)) = heap.pop() {
                result.push(word);
            }
        }

        result
    }
}
}