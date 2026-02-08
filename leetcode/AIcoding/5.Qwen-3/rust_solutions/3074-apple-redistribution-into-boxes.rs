impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_divide_into_k_boxes(mut apples: Vec<i32>, k: i32) -> bool {
        let mut count = HashMap::new();
        for &apple in &apples {
            *count.entry(apple).or_insert(0) += 1;
        }

        for (_, &freq) in &count {
            if freq > k {
                return false;
            }
        }

        true
    }
}
}