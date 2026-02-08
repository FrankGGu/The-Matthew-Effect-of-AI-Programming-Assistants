impl Solution {

use std::cmp::min;

impl Solution {
    pub fn distance_between_bus_stops(distance: Vec<i32>, start: i32, end: i32) -> i32 {
        let (start, end) = if start < end { (start, end) } else { (end, start) };
        let mut clockwise = 0;
        let mut counter_clockwise = 0;
        for i in 0..distance.len() {
            if i >= start as usize && i < end as usize {
                clockwise += distance[i];
            } else {
                counter_clockwise += distance[i];
            }
        }
        min(clockwise, counter_clockwise)
    }
}
}