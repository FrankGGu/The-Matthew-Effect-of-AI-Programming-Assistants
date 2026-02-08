impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_set_size(mut arr: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &arr {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut count = 0;
        let mut size = 0;
        for (_, &freq_val) in &mut freq {
            count += freq_val;
            size += 1;
            if count >= arr.len() / 2 {
                return size;
            }
        }

        size
    }
}
}