impl Solution {

use std::cmp::Ordering;

#[derive(Debug, PartialEq, Eq)]
pub struct Interval {
    pub start: i32,
    pub end: i32,
}

impl Solution {
    pub fn interval_intersection(
        a: Vec<Interval>,
        b: Vec<Interval>,
    ) -> Vec<Interval> {
        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < a.len() && j < b.len() {
            let start = a[i].start.max(b[j].start);
            let end = a[i].end.min(b[j].end);

            if start <= end {
                result.push(Interval { start, end });
            }

            if a[i].end < b[j].end {
                i += 1;
            } else {
                j += 1;
            }
        }

        result
    }
}
}