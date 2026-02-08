impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn similar_pairs(mut words: Vec<String>) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for word in &mut words {
            let mut set = std::collections::HashSet::new();
            for c in word.chars() {
                set.insert(c);
            }
            let key: String = set.into_iter().collect();
            *map.entry(key).or_insert(0) += 1;
        }

        for v in map.values() {
            if *v >= 2 {
                count += v * (v - 1) / 2;
            }
        }

        count
    }
}
}