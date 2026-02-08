impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_total_cost(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut cost = 0;
        let mut i = 0;
        let mut j = 0;

        while i < arr1.len() && j < arr2.len() {
            if arr1[i] == arr2[j] {
                i += 1;
                j += 1;
            } else if arr1[i] < arr2[j] {
                heap.push(arr1[i]);
                i += 1;
            } else {
                heap.push(arr2[j]);
                j += 1;
            }
        }

        while i < arr1.len() {
            heap.push(arr1[i]);
            i += 1;
        }

        while j < arr2.len() {
            heap.push(arr2[j]);
            j += 1;
        }

        while let Some(val) = heap.pop() {
            cost += val;
        }

        cost
    }
}
}