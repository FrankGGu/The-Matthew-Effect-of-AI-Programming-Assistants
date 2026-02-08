impl Solution {

use std::collections::HashSet;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct DataFrame {
    pub data: Vec<Vec<i32>>,
}

impl DataFrame {
    pub fn drop_duplicate_rows(mut self) -> Self {
        let mut seen = HashSet::new();
        let mut result = Vec::new();
        for row in self.data {
            let key: String = row.iter().map(|&x| x.to_string()).collect();
            if !seen.contains(&key) {
                seen.insert(key);
                result.push(row);
            }
        }
        DataFrame { data: result }
    }
}
}