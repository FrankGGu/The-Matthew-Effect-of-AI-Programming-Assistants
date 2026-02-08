impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<_> = intervals.into_iter().map(|v| (v[0], v[1])).collect();
        intervals.sort_by(|a, b| a.1.cmp(&b.1));

        let mut heap = BinaryHeap::new();
        let mut max_score = 0;

        for (start, end) in intervals {
            while let Some((prev_end, prev_score)) = heap.peek() {
                if *prev_end < start {
                    heap.pop();
                    max_score = std::cmp::max(max_score, *prev_score);
                } else {
                    break;
                }
            }
            heap.push((end, max_score + 1));
        }

        max_score
    }
}
}