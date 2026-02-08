impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_well_performing_interval(books: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        map.insert(0, -1);
        let mut max_len = 0;
        let mut score = 0;

        for (i, &book) in books.iter().enumerate() {
            score += if book > 5 { 1 } else { -1 };

            if let Some(&prev) = map.get(&score) {
                max_len = std::cmp::max(max_len, i as i32 - prev);
            } else {
                map.insert(score, i as i32);
            }
        }

        max_len
    }
}
}