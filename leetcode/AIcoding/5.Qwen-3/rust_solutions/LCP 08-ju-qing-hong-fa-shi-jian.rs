impl Solution {

use std::collections::{HashMap, VecDeque};

struct Solution;

impl Solution {
    pub fn available_seconds(activities: Vec<Vec<i32>>, start_time: i32) -> Vec<i32> {
        let mut events = HashMap::new();
        for activity in activities {
            let time = activity[0];
            let duration = activity[1];
            events.entry(time).or_insert_with(Vec::new).push(duration);
        }

        let mut result = Vec::new();
        let mut queue = VecDeque::new();
        queue.push_back(start_time);

        while let Some(current_time) = queue.pop_front() {
            if current_time < 0 {
                continue;
            }
            if result.contains(&current_time) {
                continue;
            }
            result.push(current_time);
            if let Some(durations) = events.get(&current_time) {
                for &duration in durations {
                    queue.push_back(current_time + duration);
                }
            }
        }

        result.sort();
        result
    }
}
}