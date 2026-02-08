impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_valid_strings(queries: Vec<String>, dictionary: Vec<String>) -> i32 {
        let mut trie = Trie::new();
        for word in &dictionary {
            trie.insert(word);
        }

        let mut result = 0;
        for query in queries {
            let mut queue = VecDeque::new();
            queue.push_back(&trie.root);
            let mut found = false;

            for c in query.chars() {
                let mut next_queue = VecDeque::new();
                while let Some(node) = queue.pop_front() {
                    if let Some(child) = node.children.get(&c) {
                        next_queue.push_back(child);
                    }
                }
                if next_queue.is_empty() {
                    break;
                }
                queue = next_queue;
                found = true;
            }

            if !found {
                result += 1;
            }
        }

        result
    }
}

struct Trie {
    root: Node,
}

struct Node {
    children: std::collections::HashMap<char, Box<Node>>,
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: Node {
                children: std::collections::HashMap::new(),
            },
        }
    }

    fn insert(&mut self, word: &str) {
        let mut node = &mut self.root;
        for c in word.chars() {
            node = node.children.entry(c).or_insert_with(|| Box::new(Node { children: std::collections::HashMap::new() }));
        }
    }
}
}