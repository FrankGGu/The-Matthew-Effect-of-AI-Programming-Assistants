impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_subarray(nums: Vec<i32>, p: i32) -> i32 {
        let mut prefix_mod = 0;
        let mut map = HashMap::new();
        map.insert(0, -1);
        let target = (nums.iter().sum::<i32>() % p + p) % p;
        let mut result = nums.len() as i32;

        for (i, &num) in nums.iter().enumerate() {
            prefix_mod = (prefix_mod + num) % p;
            let need = (prefix_mod - target + p) % p;
            if let Some(&j) = map.get(&need) {
                result = std::cmp::min(result, (i as i32 - j));
            }
            map.insert(prefix_mod, i as i32);
        }

        if result == nums.len() as i32 {
            -1
        } else {
            result
        }
    }
}
}