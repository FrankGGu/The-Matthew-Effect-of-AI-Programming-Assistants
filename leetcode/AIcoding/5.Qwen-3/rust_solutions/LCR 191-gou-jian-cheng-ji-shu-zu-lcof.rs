impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn count_points(rings: String) -> i32 {
        let mut map = HashMap::new();
        let chars: Vec<char> = rings.chars().collect();

        for i in (0..chars.len()).step_by(2) {
            let color = chars[i];
            let index = chars[i + 1].to_digit(10).unwrap() as u8;
            *map.entry(index).or_insert(0) += 1;
        }

        map.values().filter(|&&v| v >= 3).count() as i32
    }
}
}