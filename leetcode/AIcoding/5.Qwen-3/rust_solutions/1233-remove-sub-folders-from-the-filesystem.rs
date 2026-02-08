impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn remove_subfolders(mut folder: Vec<String>) -> Vec<String> {
        folder.sort();
        let mut result = Vec::new();
        let mut prev = String::new();

        for f in folder {
            if !prev.starts_with(&f) {
                result.push(f.clone());
                prev = f;
            }
        }

        result
    }
}
}