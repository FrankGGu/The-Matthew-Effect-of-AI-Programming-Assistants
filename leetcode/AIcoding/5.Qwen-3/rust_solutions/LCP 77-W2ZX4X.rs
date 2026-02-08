impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn min_stamina_required(runes: Vec<char>, stamina: i32) -> i32 {
        let mut count = HashMap::new();
        for &c in &runes {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut required = 0;
        for (_, &v) in &count {
            required += v;
        }

        if required <= stamina {
            0
        } else {
            required - stamina
        }
    }
}
}