impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_cost(n: i32, prices: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for price in prices {
            heap.push(Reverse(price));
        }

        let mut total = 0;
        let mut count = 0;

        while let Some(Reverse(price)) = heap.pop() {
            count += 1;
            if count % 3 != 0 {
                total += price;
            }
        }

        total
    }
}

pub struct Solution;
}