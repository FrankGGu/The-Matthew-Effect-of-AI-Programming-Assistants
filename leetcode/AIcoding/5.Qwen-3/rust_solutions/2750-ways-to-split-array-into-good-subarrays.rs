impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_subarrays_with_good_split(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prefix_sum = 0;
        let mut map = HashMap::new();
        map.insert(0, 1);

        for &num in &nums {
            prefix_sum += num;
            if let Some(&v) = map.get(&(prefix_sum - 1)) {
                count += v;
            }
            *map.entry(prefix_sum).or_insert(0) += 1;
        }

        count
    }
}
}