impl Solution {

use std::collections::{BTreeSet, HashMap};

impl Solution {
    pub fn avoid_flood(photos: Vec<i32>) -> Vec<String> {
        let n = photos.len();
        let mut result = vec![String::from("full"); n];
        let mut lake_to_day = HashMap::new();
        let mut available_days = BTreeSet::new();

        for (i, &lake) in photos.iter().enumerate() {
            if lake == -1 {
                available_days.insert(i);
                continue;
            }

            if let Some(&prev_day) = lake_to_day.get(&lake) {
                if let Some(&day) = available_days.range(prev_day..).next() {
                    result[day] = format!("{}{}", "lake", lake);
                    available_days.remove(&day);
                } else {
                    return vec![];
                }
            }

            lake_to_day.insert(lake, i);
        }

        result
    }
}
}