impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_balls_in_box(billiards: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &b in &billiards {
            let key = b.abs() as usize;
            *count.entry(key).or_insert(0) += 1;
        }
        *count.values().max().unwrap() as i32
    }
}
}