impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();
        map.insert(0, 1);
        let mut sum = 0;

        for &num in &nums {
            sum += num;
            if let Some(&v) = map.get(&(sum - k)) {
                count += v;
            }
            *map.entry(sum).or_insert(0) += 1;
        }

        count
    }
}
}