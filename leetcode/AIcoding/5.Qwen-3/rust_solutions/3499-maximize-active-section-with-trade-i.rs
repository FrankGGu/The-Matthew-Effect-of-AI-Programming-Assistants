impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_active_section(trades: Vec<Vec<i32>>) -> i32 {
        let mut map = HashMap::new();
        for trade in trades {
            let start = trade[0];
            let end = trade[1];
            *map.entry(start).or_insert(0) += 1;
            *map.entry(end + 1).or_insert(0) -= 1;
        }

        let mut max_count = 0;
        let mut current_count = 0;
        let mut prev_time = 0;

        for (time, delta) in map {
            if prev_time != 0 && prev_time < time {
                current_count = 0;
            }
            current_count += delta;
            max_count = std::cmp::max(max_count, current_count);
            prev_time = time;
        }

        max_count
    }
}
}