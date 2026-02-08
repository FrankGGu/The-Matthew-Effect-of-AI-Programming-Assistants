impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_special_chars(word: String) -> i32 {
        let mut first_occurrence = HashMap::new();
        let mut last_occurrence = HashMap::new();

        for (i, c) in word.chars().enumerate() {
            if !first_occurrence.contains_key(&c) {
                first_occurrence.insert(c, i);
            }
            last_occurrence.insert(c, i);
        }

        let mut count = 0;
        for (c, &first) in &first_occurrence {
            let &last = last_occurrence.get(c).unwrap();
            if first == last {
                count += 1;
            }
        }

        count
    }
}
}