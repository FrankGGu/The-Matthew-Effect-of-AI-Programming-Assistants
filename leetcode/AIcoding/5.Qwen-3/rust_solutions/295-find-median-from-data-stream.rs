impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    lower: BinaryHeap<Reverse<i32>>,   // max heap
    higher: BinaryHeap<i32>,           // min heap
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            lower: BinaryHeap::new(),
            higher: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        if self.lower.is_empty() || num <= *self.lower.peek().unwrap().0 {
            self.lower.push(Reverse(num));
        } else {
            self.higher.push(num);
        }

        // Balance the heaps
        if self.lower.len() > self.higher.len() + 1 {
            let val = self.lower.pop().unwrap();
            self.higher.push(val.0);
        } else if self.higher.len() > self.lower.len() {
            let val = self.higher.pop().unwrap();
            self.lower.push(Reverse(val));
        }
    }

    fn find_median(&self) -> f64 {
        if self.lower.len() == self.higher.len() {
            let lower = *self.lower.peek().unwrap().0;
            let higher = *self.higher.peek().unwrap();
            (lower as f64 + higher as f64) / 2.0
        } else {
            *self.lower.peek().unwrap().0 as f64
        }
    }
}

fn main() {
    let mut mf = MedianFinder::new();
    mf.add_num(1);
    mf.add_num(2);
    println!("{}", mf.find_median()); // 1.5
    mf.add_num(3);
    println!("{}", mf.find_median()); // 2
}
}