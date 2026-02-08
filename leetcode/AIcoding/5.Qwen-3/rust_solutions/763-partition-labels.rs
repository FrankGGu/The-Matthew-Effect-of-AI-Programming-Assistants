impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn partition_labels(s: String) -> Vec<i32> {
        let mut last = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            last.insert(c, i);
        }

        let mut result = Vec::new();
        let mut start = 0;
        let mut end = 0;

        for (i, c) in s.chars().enumerate() {
            end = std::cmp::max(end, *last.get(&c).unwrap());
            if i == end {
                result.push((end - start + 1) as i32);
                start = i + 1;
            }
        }

        result
    }
}
}