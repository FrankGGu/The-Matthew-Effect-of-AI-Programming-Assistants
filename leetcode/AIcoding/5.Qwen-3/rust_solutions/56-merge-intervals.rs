impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct Interval {
    pub start: i32,
    pub end: i32,
}

impl Solution {
    pub fn merge(mut intervals: Vec<Interval>) -> Vec<Interval> {
        if intervals.is_empty() {
            return vec![];
        }

        intervals.sort_by(|a, b| {
            if a.start != b.start {
                a.start.cmp(&b.start)
            } else {
                a.end.cmp(&b.end)
            }
        });

        let mut merged = Vec::new();
        let mut current = intervals[0].clone();

        for interval in intervals.into_iter().skip(1) {
            if interval.start <= current.end {
                current.end = current.end.max(interval.end);
            } else {
                merged.push(current);
                current = interval;
            }
        }

        merged.push(current);
        merged
    }
}
}