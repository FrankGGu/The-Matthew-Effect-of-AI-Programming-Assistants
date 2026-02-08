impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn restore_string(s: String, indices: Vec<i32>) -> String {
        let mut map = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            map.insert(indices[i], c);
        }
        let mut result = String::with_capacity(s.len());
        for i in 0..s.len() {
            result.push(*map.get(&(i as i32)).unwrap());
        }
        result
    }
}
}