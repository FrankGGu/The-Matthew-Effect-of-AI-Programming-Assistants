impl Solution {

use std::cmp::Ordering;

#[derive(Debug, PartialEq, Eq)]
pub struct Interval {
    pub start: i32,
    pub end: i32,
}

impl Solution {
    pub fn erase_overlap_intervals(mut intervals: Vec<Interval>) -> i32 {
        if intervals.is_empty() {
            return 0;
        }

        intervals.sort_by(|a, b| {
            if a.end != b.end {
                a.end.cmp(&b.end)
            } else {
                a.start.cmp(&b.start)
            }
        });

        let mut count = 1;
        let mut last_end = intervals[0].end;

        for interval in intervals.iter().skip(1) {
            if interval.start >= last_end {
                count += 1;
                last_end = interval.end;
            }
        }

        count
    }
}
}