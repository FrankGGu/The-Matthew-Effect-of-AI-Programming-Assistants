impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_number_of_balloons(text: String) -> i32 {
        let mut count = HashMap::new();
        for c in text.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut min_count = i32::MAX;
        for c in "balloon".chars() {
            let required = match c {
                'b' => 1,
                'a' => 1,
                'l' => 2,
                'o' => 2,
                'n' => 1,
                _ => 0,
            };
            let available = *count.get(&c).unwrap_or(&0);
            min_count = std::cmp::min(min_count, available / required);
        }

        min_count
    }
}
}