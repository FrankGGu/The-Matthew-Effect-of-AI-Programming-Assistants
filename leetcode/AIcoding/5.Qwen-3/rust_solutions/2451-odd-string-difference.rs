impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn odd_string(mut words: Vec<String>) -> String {
        let mut map = HashMap::new();

        for word in &words {
            let mut diff = Vec::new();
            for i in 1..word.len() {
                let d = (word.as_bytes()[i] as i32 - word.as_bytes()[i-1] as i32).abs();
                diff.push(d);
            }
            map.entry(diff).or_insert_with(Vec::new).push(word.clone());
        }

        for v in map.values() {
            if v.len() == 1 {
                return v[0].clone();
            }
        }

        unreachable!()
    }
}
}