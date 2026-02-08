impl Solution {

use std::cmp;

impl Solution {
    pub fn good_subarray_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut max_sum = 0;
        let mut prefix_mod = std::collections::HashMap::new();
        prefix_mod.insert(0, -1);

        let mut current_sum = 0;
        let mut max_good_sum = 0;

        for (i, &num) in nums.iter().enumerate() {
            current_sum += num;

            let mod_val = (current_sum % k + k) % k;

            if let Some(&prev_index) = prefix_mod.get(&mod_val) {
                let subarray_sum = current_sum - nums[prev_index as usize + 1..i].iter().sum::<i32>();
                max_good_sum = cmp::max(max_good_sum, subarray_sum);
            } else {
                prefix_mod.insert(mod_val, i as i32);
            }
        }

        max_good_sum
    }
}

struct Solution;
}