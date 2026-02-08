impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_xor(nums: Vec<i32>) -> i32 {
        let mut mask = 0;
        let mut max_xor = 0;
        for i in 0..31 {
            mask |= 1 << (31 - i);
            let mut prefixes = HashSet::new();
            for &num in &nums {
                prefixes.insert(num & mask);
            }
            let tmp = max_xor | (1 << (31 - i));
            for &prefix in &prefixes {
                if prefixes.contains(&(prefix ^ tmp)) {
                    max_xor = tmp;
                    break;
                }
            }
        }
        max_xor
    }
}
}