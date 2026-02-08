impl Solution {

use std::collections::HashMap;

#[derive(Default)]
struct ThroneInheritance {
    king: String,
    children: HashMap<String, Vec<String>>,
    alive: HashMap<String, bool>,
}

impl ThroneInheritance {
    fn new(king_name: String) -> Self {
        ThroneInheritance {
            king: king_name,
            children: HashMap::new(),
            alive: HashMap::new(),
        }
    }

    fn birth(&mut self, parent: String, child: String) {
        self.children.entry(parent).or_insert_with(Vec::new).push(child);
        self.alive.insert(child, true);
    }

    fn death(&mut self, name: String) {
        self.alive.insert(name, false);
    }

    fn get_inheritance_order(&self) -> Vec<String> {
        let mut result = Vec::new();
        self.dfs(&self.king, &mut result);
        result
    }

    fn dfs(&self, name: &str, result: &mut Vec<String>) {
        if self.alive.get(name).copied().unwrap_or(false) {
            result.push(name.to_string());
        }

        if let Some(children) = self.children.get(name) {
            for child in children {
                self.dfs(child, result);
            }
        }
    }
}
}