impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn beautiful_pairs(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut seen = HashSet::new();

        for &num in &nums {
            let complement = (k - num % k) % k;
            if seen.contains(&complement) {
                count += 1;
                seen.insert(num % k);
            } else {
                seen.insert(num % k);
            }
        }

        count
    }
}
}