impl Solution {

use std::collections::{BinaryHeap, HashMap};
use std::cmp::Ordering;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Interval {
    start: i32,
    end: i32,
}

impl Ord for Interval {
    fn cmp(&self, other: &Self) -> Ordering {
        self.end.cmp(&other.end)
    }
}

impl PartialOrd for Interval {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialOrd for Interval {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for Interval {
    fn eq(&self, other: &Self) -> bool {
        self.start == other.start && self.end == other.end
    }
}

impl Eq for Interval {}

fn main() {}

struct Solution;

impl Solution {
    pub fn min_intervals(intervals: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut intervals = intervals;
        intervals.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut queries: Vec<(i32, usize)> = queries.into_iter().enumerate().collect();
        queries.sort_by(|a, b| a.0.cmp(&b.0));

        let mut res = vec![0; queries.len()];
        let mut heap = BinaryHeap::new();

        let mut i = 0;
        for (q_idx, &q) in queries.iter() {
            while i < intervals.len() && intervals[i][1] < q {
                i += 1;
            }
            while let Some(&Interval { start, end }) = heap.peek() {
                if end < q {
                    heap.pop();
                } else {
                    break;
                }
            }
            while i < intervals.len() && intervals[i][1] <= q {
                let start = intervals[i][0];
                let end = intervals[i][1];
                heap.push(Interval { start, end });
                i += 1;
            }
            if let Some(&Interval { start, end }) = heap.peek() {
                res[q_idx] = end - start + 1;
            } else {
                res[q_idx] = -1;
            }
        }

        res
    }
}
}