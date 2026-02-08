impl Solution {

use std::collections::HashMap;

struct WordDictionary {
    children: HashMap<char, Box<WordDictionary>>,
    is_end: bool,
}

impl WordDictionary {
    fn new() -> Self {
        WordDictionary {
            children: HashMap::new(),
            is_end: false,
        }
    }

    fn add_word(&mut self, word: String) {
        let mut node = self;
        for c in word.chars() {
            node = node.children.entry(c).or_insert_with(WordDictionary::new);
        }
        node.is_end = true;
    }

    fn search(&self, word: String) -> bool {
        self.search_helper(&word, 0)
    }

    fn search_helper(&self, word: &str, index: usize) -> bool {
        if index == word.len() {
            return self.is_end;
        }

        let c = word.chars().nth(index).unwrap();
        if c == '.' {
            for child in self.children.values() {
                if child.search_helper(word, index + 1) {
                    return true;
                }
            }
            false
        } else {
            if let Some(child) = self.children.get(&c) {
                child.search_helper(word, index + 1)
            } else {
                false
            }
        }
    }
}

fn main() {}

pub fn create() -> WordDictionary {
    WordDictionary::new()
}

pub fn add_word(word: String, dict: &mut WordDictionary) {
    dict.add_word(word);
}

pub fn search(word: String, dict: &WordDictionary) -> bool {
    dict.search(word)
}
}