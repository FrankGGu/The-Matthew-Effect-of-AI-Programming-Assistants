impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(hours: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        let mut count = 0;
        for &h in &hours {
            let rem = (24 - h % 24) % 24;
            count += *map.get(&rem).unwrap_or(&0);
            *map.entry(h % 24).or_insert(0) += 1;
        }
        count
    }
}
}