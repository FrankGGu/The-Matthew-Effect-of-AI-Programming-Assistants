impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn max_average_pass_ratio(employees: Vec<Vec<i32>>, k: i32) -> f64 {
        let mut heap = BinaryHeap::new();

        for emp in &employees {
            let pass = emp[0];
            let total = emp[1];
            let diff = (pass as f64 / total as f64) - ((pass + 1) as f64 / (total + 1) as f64);
            heap.push(Reverse((diff, pass, total)));
        }

        for _ in 0..k {
            if let Some(Reverse((diff, pass, total))) = heap.pop() {
                let new_pass = pass + 1;
                let new_total = total + 1;
                let new_diff = (new_pass as f64 / new_total as f64) - ((new_pass + 1) as f64 / (new_total + 1) as f64);
                heap.push(Reverse((new_diff, new_pass, new_total)));
            }
        }

        let mut total_ratio = 0.0;
        for Reverse((_, pass, total)) in heap {
            total_ratio += pass as f64 / total as f64;
        }

        total_ratio / heap.len() as f64
    }
}
}