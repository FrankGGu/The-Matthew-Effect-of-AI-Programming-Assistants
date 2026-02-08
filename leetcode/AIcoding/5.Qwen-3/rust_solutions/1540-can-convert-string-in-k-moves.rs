impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_convert_string(target: String, initial: String, k: i32) -> bool {
        if target.len() != initial.len() {
            return false;
        }

        let mut freq = HashMap::new();

        for (t, i) in target.chars().zip(initial.chars()) {
            if t != i {
                let diff = ((t as u8 - i as u8) + 26) % 26;
                *freq.entry(diff).or_insert(0) += 1;
            }
        }

        for (diff, count) in &freq {
            let max_move = *k;
            let max_possible = (max_move as i32 - diff) / 26;
            if *count > max_possible {
                return false;
            }
        }

        true
    }
}
}