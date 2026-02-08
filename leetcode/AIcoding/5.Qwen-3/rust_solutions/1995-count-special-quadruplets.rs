impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_special_quadruplets(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut map = HashMap::new();

        for j in 0..n {
            for k in j + 1..n {
                let sum = nums[j] + nums[k];
                *map.entry(sum).or_insert(0) += 1;
            }
        }

        for i in 0..n {
            for l in i + 1..n {
                let diff = nums[i] - nums[l];
                if let Some(&val) = map.get(&diff) {
                    count += val;
                }
            }
        }

        count
    }
}
}