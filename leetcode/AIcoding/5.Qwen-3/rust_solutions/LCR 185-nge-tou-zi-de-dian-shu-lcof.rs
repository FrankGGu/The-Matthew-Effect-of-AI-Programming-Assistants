impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn stats_probability(stat: Vec<Vec<i32>>) -> Vec<f64> {
        let mut freq = HashMap::new();
        for pair in stat {
            let key = (pair[0], pair[1]);
            *freq.entry(key).or_insert(0) += 1;
        }

        let total = stat.len() as f64;
        let mut result = Vec::new();
        for (_, count) in &freq {
            result.push(*count as f64 / total);
        }
        result
    }
}
}