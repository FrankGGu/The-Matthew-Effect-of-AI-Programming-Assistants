impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn kth_distinct(arr: Vec<String>, k: i32) -> String {
        let mut count = HashMap::new();
        for s in &arr {
            *count.entry(s).or_insert(0) += 1;
        }

        let mut result = String::new();
        for s in arr {
            if count[&s] == 1 {
                k -= 1;
                if k == 0 {
                    return s;
                }
            }
        }

        result
    }
}
}