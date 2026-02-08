pub struct Solution {}

impl Solution {
    pub fn max_subarray_with_equal_products(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut prefix_product = 1;
        let mut map = HashMap::new();
        map.insert(1, -1);
        let mut max_len = 0;

        for (i, &num) in nums.iter().enumerate() {
            prefix_product *= num;
            if prefix_product == 0 {
                prefix_product = 1;
                map.clear();
                map.insert(1, i as i32);
                continue;
            }

            if let Some(&prev_index) = map.get(&prefix_product) {
                max_len = std::cmp::max(max_len, i as i32 - prev_index);
            } else {
                map.insert(prefix_product, i as i32);
            }
        }

        max_len
    }
}