impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
        let mut freq = HashMap::new();
        for task in tasks {
            *freq.entry(task).or_insert(0) += 1;
        }

        let max_freq = freq.values().max().unwrap();
        let count_max_freq = freq.values().filter(|&&v| v == *max_freq).count();

        (*max_freq as i32 - 1) * (n + 1) + count_max_freq as i32
    }
}
}