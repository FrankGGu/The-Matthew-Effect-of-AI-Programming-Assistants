impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_sequence_value(arr: Vec<i32>) -> i32 {
        let mut max_val = 0;
        let mut current = 0;
        for &num in &arr {
            match num.cmp(&0) {
                Ordering::Greater => current += num,
                _ => current = 0,
            }
            max_val = max_val.max(current);
        }
        max_val
    }
}
}