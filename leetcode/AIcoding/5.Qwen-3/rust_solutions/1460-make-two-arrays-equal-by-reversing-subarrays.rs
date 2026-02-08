impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_be_equal(target: Vec<i32>, arr: Vec<i32>) -> bool {
        let mut count = HashMap::new();

        for &num in &target {
            *count.entry(num).or_insert(0) += 1;
        }

        for &num in &arr {
            *count.entry(num).or_insert(0) -= 1;
        }

        count.values().all(|&v| v == 0)
    }
}
}