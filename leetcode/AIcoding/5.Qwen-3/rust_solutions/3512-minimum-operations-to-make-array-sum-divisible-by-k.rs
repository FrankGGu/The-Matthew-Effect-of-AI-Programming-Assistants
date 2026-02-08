impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_ops(nums: Vec<i32>, k: i32) -> i32 {
        let mut prefix_mod = 0;
        let mut count = HashMap::new();
        count.insert(0, 1);
        let mut result = 0;

        for num in nums {
            prefix_mod = (prefix_mod + num) % k;
            if prefix_mod < 0 {
                prefix_mod += k;
            }
            let need = (k - prefix_mod) % k;
            result += *count.get(&need).unwrap_or(&0);
            *count.entry(prefix_mod).or_insert(0) += 1;
        }

        result
    }
}
}