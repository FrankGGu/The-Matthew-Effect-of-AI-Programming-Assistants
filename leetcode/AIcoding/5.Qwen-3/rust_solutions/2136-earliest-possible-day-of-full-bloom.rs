impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn earliest_day(bloom_days: Vec<i32>, grow_days: Vec<i32>) -> i32 {
        let n = bloom_days.len();
        let mut flowers = Vec::with_capacity(n);

        for i in 0..n {
            flowers.push((grow_days[i], bloom_days[i]));
        }

        flowers.sort_by(|a, b| a.0.cmp(&b.0));

        let mut max_day = 0;
        let mut heap = BinaryHeap::new();

        for i in 0..n {
            let (grow, bloom) = flowers[i];
            heap.push(Reverse(grow));

            if heap.len() > i + 1 {
                heap.pop();
            }

            if heap.len() == i + 1 {
                let (grow_time) = heap.peek().unwrap();
                max_day = std::cmp::max(max_day, *grow_time + bloom);
            }
        }

        max_day
    }
}
}