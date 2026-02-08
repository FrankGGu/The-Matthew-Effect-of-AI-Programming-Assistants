impl Solution {

use std::collections::{HashMap, VecDeque};

struct UnionFind {
    parent: HashMap<char, char>,
}

impl UnionFind {
    fn new() -> Self {
        UnionFind {
            parent: HashMap::new(),
        }
    }

    fn find(&mut self, x: char) -> char {
        if *self.parent.get(&x).unwrap_or(&x) != x {
            self.parent.insert(x, self.find(*self.parent.get(&x).unwrap()));
        }
        *self.parent.get(&x).unwrap()
    }

    fn union(&mut self, x: char, y: char) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            self.parent.insert(root_x, root_y);
        }
    }

    fn is_connected(&mut self, x: char, y: char) -> bool {
        self.find(x) == self.find(y)
    }
}

impl Solution {
    pub fn equations_possible(s: Vec<String>) -> bool {
        let mut uf = UnionFind::new();
        for s in &s {
            let chars: Vec<char> = s.chars().collect();
            if chars[1] == '=' {
                uf.union(chars[0], chars[2]);
            }
        }

        for s in &s {
            let chars: Vec<char> = s.chars().collect();
            if chars[1] == '!' {
                if uf.find(chars[0]) == uf.find(chars[2]) {
                    return false;
                }
            }
        }

        true
    }
}
}