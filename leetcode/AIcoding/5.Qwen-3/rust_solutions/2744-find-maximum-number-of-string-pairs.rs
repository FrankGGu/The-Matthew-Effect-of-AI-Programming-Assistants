impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_number_of_pairs(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut pairs = 0;

        for num in nums {
            let c = count.entry(num).or_insert(0);
            if *c > 0 {
                pairs += 1;
                *c -= 1;
            } else {
                *c += 1;
            }
        }

        pairs
    }
}
}