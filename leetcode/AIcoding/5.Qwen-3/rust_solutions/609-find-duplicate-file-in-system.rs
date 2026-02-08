impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
        let mut hash_map = HashMap::new();

        for path in paths {
            let parts: Vec<&str> = path.split_whitespace().collect();
            let dir = parts[0];
            for i in 1..parts.len() {
                let file = parts[i];
                let (file_name, content) = file.split_at(file.find('(').unwrap());
                let content = &content[1..content.len() - 1];
                hash_map.entry(content).or_insert_with(Vec::new).push(format!("{}/{}", dir, file_name));
            }
        }

        hash_map.into_values().filter(|v| v.len() > 1).collect()
    }
}
}