impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn busy_student(start_time: Vec<i32>, end_time: Vec<i32>) -> i32 {
        let mut time_map = HashMap::new();
        for i in 0..start_time.len() {
            let start = start_time[i];
            let end = end_time[i];
            for t in start..=end {
                *time_map.entry(t).or_insert(0) += 1;
            }
        }
        time_map.values().max().copied().unwrap_or(0)
    }
}
}