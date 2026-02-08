impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn maximum_points(mut battles: Vec<Vec<i32>>) -> i32 {
        battles.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut max_points = 0;
        let mut heap = BinaryHeap::new();

        for battle in battles {
            let (time, points) = (battle[0], battle[1]);
            while let Some(&(t, p)) = heap.peek() {
                if t < time {
                    max_points += p;
                    heap.pop();
                } else {
                    break;
                }
            }
            heap.push((time + 1, points));
        }

        max_points
    }
}
}