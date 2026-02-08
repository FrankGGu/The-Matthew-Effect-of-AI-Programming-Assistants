impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution {}

impl Solution {
    pub fn kth_smallest_trimmed_numbers(nums: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for query in queries {
            let k = query[0] as usize;
            let trim = query[1] as usize;
            let mut heap = BinaryHeap::new();
            for num in &nums {
                let trimmed = &num[num.len() - trim..];
                heap.push((trimmed, num));
                if heap.len() > k {
                    heap.pop();
                }
            }
            let mut kth = String::new();
            while let Some((trimmed, num)) = heap.pop() {
                kth = num.clone();
            }
            result.push(kth.parse::<i32>().unwrap());
        }
        result
    }
}
}