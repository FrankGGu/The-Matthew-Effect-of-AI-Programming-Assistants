impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_x_value_of_array(nums: Vec<i32>, x: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        for (key, &count) in &freq {
            if *key == x {
                result += count;
            }
        }

        result
    }
}
}