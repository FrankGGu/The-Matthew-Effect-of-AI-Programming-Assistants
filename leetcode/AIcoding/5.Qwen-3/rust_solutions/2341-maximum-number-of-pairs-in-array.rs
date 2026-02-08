impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_number_of_pairs(nums: Vec<i32>) -> Vec<i32> {
        let mut count = HashMap::new();
        for num in nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut pairs = 0;
        let mut remaining = 0;

        for &v in count.values() {
            pairs += v / 2;
            if v % 2 == 1 {
                remaining += 1;
            }
        }

        vec![pairs, remaining]
    }
}
}