impl Solution {

use std::collections::{BinaryHeap, HashMap};
use std::cmp::Ordering;

struct MedianFinder {
    max_heap: BinaryHeap<i32>,
    min_heap: BinaryHeap<i32>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            max_heap: BinaryHeap::new(),
            min_heap: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        match self.max_heap.peek() {
            Some(&top) if num <= top => {
                self.max_heap.push(num);
            }
            _ => {
                self.min_heap.push(num);
            }
        }

        // Rebalance heaps
        if self.max_heap.len() > self.min_heap.len() + 1 {
            let val = self.max_heap.pop().unwrap();
            self.min_heap.push(val);
        } else if self.min_heap.len() > self.max_heap.len() {
            let val = self.min_heap.pop().unwrap();
            self.max_heap.push(val);
        }
    }

    fn find_median(&self) -> f64 {
        if self.max_heap.len() == self.min_heap.len() {
            (self.max_heap.peek().unwrap() as f64 + self.min_heap.peek().unwrap() as f64) / 2.0
        } else {
            *self.max_heap.peek().unwrap() as f64
        }
    }
}

fn sliding_window_median(nums: Vec<i32>, k: i32) -> Vec<f64> {
    let k = k as usize;
    let mut result = Vec::new();
    let mut mf = MedianFinder::new();

    for i in 0..nums.len() {
        mf.add_num(nums[i]);

        if i >= k {
            let remove_num = nums[i - k];
            // Remove from heaps (not directly supported by BinaryHeap)
            // We'll use a lazy removal approach with a hash map
            // This is a simplified version and may not be efficient for large k
            // For the purpose of LeetCode submission, it's acceptable

            // To simulate removal, we'll just reinsert the numbers
            // This is a workaround due to lack of efficient deletion in BinaryHeap
            let mut temp = Vec::new();
            while let Some(x) = mf.max_heap.pop() {
                temp.push(x);
            }
            for x in temp.iter().rev() {
                mf.max_heap.push(*x);
            }

            temp.clear();
            while let Some(x) = mf.min_heap.pop() {
                temp.push(x);
            }
            for x in temp.iter().rev() {
                mf.min_heap.push(*x);
            }

            // Now, remove the number
            let mut found = false;
            let mut temp_max = Vec::new();
            while let Some(x) = mf.max_heap.pop() {
                if !found && x == remove_num {
                    found = true;
                    continue;
                }
                temp_max.push(x);
            }
            for x in temp_max.iter().rev() {
                mf.max_heap.push(*x);
            }

            let mut found = false;
            let mut temp_min = Vec::new();
            while let Some(x) = mf.min_heap.pop() {
                if !found && x == remove_num {
                    found = true;
                    continue;
                }
                temp_min.push(x);
            }
            for x in temp_min.iter().rev() {
                mf.min_heap.push(*x);
            }

            mf.add_num(nums[i]);
        }

        if i >= k - 1 {
            result.push(mf.find_median());
        }
    }

    result
}
}