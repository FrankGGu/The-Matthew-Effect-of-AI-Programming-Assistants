impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn total_cost_to_hire_k_workers(costs: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut min_heap1 = BinaryHeap::new();
        let mut min_heap2 = BinaryHeap::new();

        for &cost in &costs {
            min_heap1.push(Reverse(cost));
        }

        let mut total_cost = 0;
        let mut i = 0;

        while i < k {
            let mut cost1 = match min_heap1.pop() {
                Some(Reverse(c)) => c,
                None => 0,
            };

            let mut cost2 = match min_heap2.pop() {
                Some(Reverse(c)) => c,
                None => 0,
            };

            if cost1 <= cost2 {
                total_cost += cost1;
                min_heap2.push(Reverse(cost2));
            } else {
                total_cost += cost2;
                min_heap1.push(Reverse(cost1));
            }

            i += 1;
        }

        total_cost
    }
}
}