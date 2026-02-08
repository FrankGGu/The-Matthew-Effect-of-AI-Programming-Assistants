impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn alert_names(mut key_name: Vec<String>, key_time: Vec<String>) -> Vec<String> {
        let mut name_time: HashMap<String, Vec<i32>> = HashMap::new();

        for i in 0..key_name.len() {
            let name = &key_name[i];
            let time = &key_time[i];
            let hour = time.split(':').next().unwrap().parse::<i32>().unwrap();
            let minute = time.split(':').nth(1).unwrap().parse::<i32>().unwrap();
            let total_min = hour * 60 + minute;
            name_time.entry(name.clone()).or_insert_with(Vec::new).push(total_min);
        }

        let mut result = Vec::new();

        for (name, times) in name_time {
            let mut sorted = times.clone();
            sorted.sort();
            for i in 2..sorted.len() {
                if sorted[i] - sorted[i - 2] <= 60 {
                    result.push(name.clone());
                    break;
                }
            }
        }

        result.sort();
        result
    }
}
}