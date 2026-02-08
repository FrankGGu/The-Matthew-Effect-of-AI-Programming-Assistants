impl Solution {

use std::cmp::Ordering;
use std::str::FromStr;

impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut times = Vec::new();
        for time in time_points {
            let parts: Vec<&str> = time.split(':').collect();
            let hours = i32::from_str(parts[0]).unwrap();
            let minutes = i32::from_str(parts[1]).unwrap();
            times.push(hours * 60 + minutes);
        }
        times.sort();
        let mut min_diff = i32::MAX;
        for i in 0..times.len() {
            let diff = (times[(i + 1) % times.len()] - times[i]).abs();
            min_diff = min_diff.min(diff);
        }
        min_diff
    }
}
}