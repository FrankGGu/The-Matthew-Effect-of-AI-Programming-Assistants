impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn _max_sum_subarray(arr: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        let mut left = 0;
        let mut max_sum = 0;
        let mut current_sum = 0;

        for right in 0..arr.len() {
            let num = arr[right];
            current_sum += num;

            if let Some(&count) = map.get(&num) {
                if count >= 1 {
                    while left <= right && map[&num] >= 1 {
                        current_sum -= arr[left];
                        map.entry(arr[left]).and_modify(|e| *e -= 1);
                        left += 1;
                    }
                }
            }

            map.entry(num).and_modify(|e| *e += 1).or_insert(1);
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}

struct Solution;
}