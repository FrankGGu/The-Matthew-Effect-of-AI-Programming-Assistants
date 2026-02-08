impl Solution {

use std::collections::HashMap;

struct WordFilter {
    map: HashMap<String, i32>,
}

impl WordFilter {
    fn new(words: Vec<String>) -> Self {
        let mut map = HashMap::new();
        for (i, word) in words.iter().enumerate() {
            let len = word.len();
            for l in 1..=len {
                for r in 1..=len {
                    let prefix = &word[..l];
                    let suffix = &word[len - r..];
                    let key = format!("{}_{}", prefix, suffix);
                    map.insert(key, i as i32);
                }
            }
        }
        WordFilter { map }
    }

    fn search(&self, prefix: String, suffix: String) -> i32 {
        let key = format!("{}_{}", prefix, suffix);
        *self.map.get(&key).unwrap_or(&-1)
    }
}
}