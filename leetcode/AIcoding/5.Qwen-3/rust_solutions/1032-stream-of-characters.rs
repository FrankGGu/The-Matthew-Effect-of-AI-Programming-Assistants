impl Solution {

use std::collections::HashMap;

struct StreamChecker {
    trie: Trie,
    max_len: usize,
}

struct Trie {
    children: HashMap<char, Trie>,
    is_end: bool,
}

impl Trie {
    fn new() -> Self {
        Trie {
            children: HashMap::new(),
            is_end: false,
        }
    }
}

impl StreamChecker {
    fn new(words: Vec<String>) -> Self {
        let mut trie = Trie::new();
        let mut max_len = 0;
        for word in &words {
            let mut node = &mut trie;
            for c in word.chars().rev() {
                node = node.children.entry(c).or_insert(Trie::new());
            }
            node.is_end = true;
            max_len = std::cmp::max(max_len, word.len());
        }
        StreamChecker { trie, max_len }
    }

    fn query(&mut self, letter: char) -> bool {
        let mut node = &self.trie;
        for i in 0..self.max_len {
            if let Some(child) = node.children.get(&letter) {
                node = child;
                if node.is_end {
                    return true;
                }
            } else {
                return false;
            }
            // Move to next character (we need to check the next character in the stream)
            // but since we are using a reversed trie, we have to reverse the order again
            // So we just keep moving through the trie as we add characters
        }
        false
    }
}
}