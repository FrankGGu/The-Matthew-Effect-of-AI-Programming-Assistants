impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_k_difference(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for num in nums {
            let target1 = num - k;
            let target2 = num + k;

            count += *map.get(&target1).unwrap_or(&0);
            count += *map.get(&target2).unwrap_or(&0);

            *map.entry(num).or_insert(0) += 1;
        }

        count
    }
}
}