impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn maximize_xor(mut nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut trie = Trie::new();
        for num in &nums {
            trie.insert(*num);
        }

        let mut result = Vec::with_capacity(queries.len());
        for query in queries {
            let (index, val) = (query[0], query[1]);
            result.push(trie.max_xor(val));
        }

        result
    }
}

struct Trie {
    root: Node,
}

struct Node {
    children: [Option<Box<Node>>; 2],
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: Node {
                children: [None, None],
            },
        }
    }

    fn insert(&mut self, num: i32) {
        let mut node = &mut self.root;
        for i in (0..31).rev() {
            let bit = (num >> i) & 1;
            if node.children[bit as usize].is_none() {
                node.children[bit as usize] = Some(Box::new(Node {
                    children: [None, None],
                }));
            }
            node = node.children[bit as usize].as_mut().unwrap();
        }
    }

    fn max_xor(&self, num: i32) -> i32 {
        let mut node = &self.root;
        let mut max_xor = 0;
        for i in (0..31).rev() {
            let bit = (num >> i) & 1;
            let desired_bit = 1 - bit;
            if let Some(child) = &node.children[desired_bit as usize] {
                max_xor |= 1 << i;
                node = child;
            } else {
                node = node.children[bit as usize].as_ref().unwrap();
            }
        }
        max_xor
    }
}
}