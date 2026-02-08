impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn number_of_special_chars(word: String) -> i32 {
        let mut set = HashSet::new();
        let mut count = 0;

        for c in word.chars() {
            if set.contains(&c) {
                count += 1;
                set.remove(&c);
            } else {
                set.insert(c);
            }
        }

        count
    }
}
}