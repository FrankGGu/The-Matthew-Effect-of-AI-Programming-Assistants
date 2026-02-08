impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn largest_values_from_labels(nums: Vec<i32>, labels: Vec<i32>, num_to_pick: i32) -> Vec<i32> {
        let mut max_heap = BinaryHeap::new();
        for (i, &num) in nums.iter().enumerate() {
            max_heap.push((num, labels[i]));
        }

        let mut result = Vec::new();
        let mut label_count = std::collections::HashMap::new();
        let mut picked = 0;

        while let Some((val, label)) = max_heap.pop() {
            if picked >= num_to_pick {
                break;
            }
            let count = label_count.entry(label).or_insert(0);
            if *count < 1 {
                *count += 1;
                result.push(val);
                picked += 1;
            }
        }

        result
    }
}
}