impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn subarrays_div_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_mod = 0;
        let mut mod_count = HashMap::new();
        mod_count.insert(0, 1);

        for num in nums {
            prefix_mod = (prefix_mod + num % k + k) % k;
            count += *mod_count.entry(prefix_mod).or_insert(0);
            *mod_count.entry(prefix_mod).or_insert(0) += 1;
        }

        count
    }
}
}