impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn missing_observations(rolls: Vec<i32>, mean: i32, n: i32) -> Vec<i32> {
        let m = rolls.len() as i32;
        let total_sum: i32 = rolls.iter().sum();
        let required_total = (m + n) * mean;
        let missing_sum = required_total - total_sum;

        if missing_sum < n || missing_sum > 6 * n {
            return vec![];
        }

        let mut result = vec![];
        let mut remaining = missing_sum;
        let mut count = n;

        while count > 0 {
            let val = (remaining as f64 / count as f64).ceil() as i32;
            result.push(val);
            remaining -= val;
            count -= 1;
        }

        result
    }
}
}