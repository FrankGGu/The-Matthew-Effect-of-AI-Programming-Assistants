impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_time_to_make_array_sum_at_most_x(mut nums: Vec<i32>, x: i32) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for num in &nums {
            max_heap.push(Reverse(*num));
        }

        let mut time = 0;
        while nums.iter().sum::<i32>() > x {
            if max_heap.is_empty() {
                return -1;
            }
            let Reverse(max_val) = max_heap.pop().unwrap();
            let index = nums.iter().position(|&v| v == max_val).unwrap();
            nums[index] = (nums[index] as f64 / 2.0).floor() as i32;
            max_heap.push(Reverse(nums[index]));
            time += 1;
        }

        time
    }
}
}