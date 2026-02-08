impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn divide_array(nums: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        for &v in count.values() {
            if v % 2 != 0 {
                return false;
            }
        }
        true
    }
}
}