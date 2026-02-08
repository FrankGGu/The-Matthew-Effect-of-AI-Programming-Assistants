impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn are_equal(a: String, b: String) -> bool {
        fn count_digits(s: &str) -> HashMap<char, i32> {
            let mut map = HashMap::new();
            for c in s.chars() {
                *map.entry(c).or_insert(0) += 1;
            }
            map
        }

        let a_count = count_digits(&a);
        let b_count = count_digits(&b);

        if a_count.len() != b_count.len() {
            return false;
        }

        for (k, v) in &a_count {
            if *b_count.get(k).unwrap_or(&0) != *v {
                return false;
            }
        }

        true
    }
}
}