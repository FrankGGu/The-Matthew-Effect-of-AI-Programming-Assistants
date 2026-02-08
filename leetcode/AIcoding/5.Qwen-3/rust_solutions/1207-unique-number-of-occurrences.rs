impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn unique_occurrences(arr: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        for num in arr {
            *count.entry(num).or_insert(0) += 1;
        }
        let mut seen = HashMap::new();
        for &v in count.values() {
            if seen.contains_key(&v) {
                return false;
            }
            seen.insert(v, ());
        }
        true
    }
}
}