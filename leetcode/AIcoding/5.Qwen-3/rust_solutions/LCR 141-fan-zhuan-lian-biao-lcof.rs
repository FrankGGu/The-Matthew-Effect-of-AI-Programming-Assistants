impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn trainning_plan(target: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut count = 0;
        let mut sum = 0;
        for i in 1..=target {
            sum += i;
            if sum > target {
                break;
            }
            if seen.contains(&sum) {
                continue;
            }
            seen.insert(sum);
            count += 1;
        }
        count
    }
}
}