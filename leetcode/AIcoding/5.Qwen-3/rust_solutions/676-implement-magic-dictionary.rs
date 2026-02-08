impl Solution {

use std::collections::HashMap;

struct MagicDictionary {
    trie: TrieNode,
}

struct TrieNode {
    children: HashMap<char, TrieNode>,
    is_end: bool,
}

impl MagicDictionary {
    fn new() -> Self {
        MagicDictionary {
            trie: TrieNode {
                children: HashMap::new(),
                is_end: false,
            },
        }
    }

    fn build_dict(&mut self, words: Vec<String>) {
        for word in words {
            let mut node = &mut self.trie;
            for c in word.chars() {
                node = node.children.entry(c).or_insert_with(|| TrieNode {
                    children: HashMap::new(),
                    is_end: false,
                });
            }
            node.is_end = true;
        }
    }

    fn search(&self, word: String) -> bool {
        let mut node = &self.trie;
        for (i, c) in word.chars().enumerate() {
            for (ch, child) in &node.children {
                if *ch != c {
                    let mut temp = child;
                    let mut found = true;
                    for (j, ch2) in word.chars().enumerate() {
                        if j == i {
                            continue;
                        }
                        if let Some(next) = temp.children.get(&ch2) {
                            temp = next;
                        } else {
                            found = false;
                            break;
                        }
                    }
                    if found && temp.is_end {
                        return true;
                    }
                }
            }
            if let Some(next) = node.children.get(&c) {
                node = next;
            } else {
                return false;
            }
        }
        false
    }
}

pub fn main() {
    let mut md = MagicDictionary::new();
    md.build_dict(vec!["hello".to_string(), "leetcode".to_string()]);
    println!("{}", md.search("helo".to_string())); // true
    println!("{}", md.search("helo".to_string())); // true
}
}