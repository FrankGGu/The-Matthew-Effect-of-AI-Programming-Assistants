impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_total_beauty(mut gardens: Vec<Vec<i32>>, new_flowers: i32, new_flower_cost: i32) -> i32 {
        let n = gardens.len();
        for i in 0..n {
            gardens[i].sort_unstable();
        }

        let mut max_heap = BinaryHeap::new();
        for i in 0..n {
            if gardens[i].len() > 0 {
                max_heap.push((gardens[i][gardens[i].len() - 1], i));
            }
        }

        let mut total_beauty = 0;
        let mut remaining_flowers = new_flowers;

        while !max_heap.is_empty() && remaining_flowers > 0 {
            let (current_max, i) = max_heap.pop().unwrap();
            let next_max = if gardens[i].len() > 1 { gardens[i][gardens[i].len() - 2] } else { 0 };

            let needed = current_max - next_max;
            if needed <= remaining_flowers {
                total_beauty += current_max;
                remaining_flowers -= needed;
                gardens[i].pop();
                if gardens[i].len() > 0 {
                    max_heap.push((gardens[i][gardens[i].len() - 1], i));
                }
            } else {
                let cost_per_flower = new_flower_cost;
                let flowers_to_use = remaining_flowers;
                total_beauty += flowers_to_use * cost_per_flower;
                remaining_flowers = 0;
            }
        }

        total_beauty
    }
}
}