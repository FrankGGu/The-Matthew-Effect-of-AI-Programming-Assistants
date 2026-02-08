impl Solution {

use std::collections::HashMap;

struct MapSum {}

impl MapSum {
    fn new() -> Self {
        MapSum {}
    }

    fn insert(&mut self, key: String, val: i32) {
        let mut current = &mut self.root;
        for c in key.chars() {
            if !current.children.contains_key(&c) {
                current.children.insert(c, Node::new());
            }
            current = current.children.get_mut(&c).unwrap();
        }
        current.value = val;
    }

    fn sum(&self, prefix: String) -> i32 {
        let mut current = &self.root;
        for c in prefix.chars() {
            if let Some(node) = current.children.get(&c) {
                current = node;
            } else {
                return 0;
            }
        }
        self.dfs(current)
    }

    fn dfs(&self, node: &Node) -> i32 {
        let mut total = node.value;
        for child in node.children.values() {
            total += self.dfs(child);
        }
        total
    }

    struct Node {
        children: HashMap<char, Node>,
        value: i32,
    }

    impl Node {
        fn new() -> Self {
            Node {
                children: HashMap::new(),
                value: 0,
            }
        }
    }

    fn root(&self) -> &Node {
        &self.root
    }
}
}