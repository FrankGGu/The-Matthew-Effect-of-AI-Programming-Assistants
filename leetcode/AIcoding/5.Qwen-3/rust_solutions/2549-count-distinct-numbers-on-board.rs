impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn istringstream(n: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut current = 1;
        let mut count = 0;

        while count < n {
            if !seen.contains(&current) {
                seen.insert(current);
                count += 1;
            }
            current += 1;
        }

        current - 1
    }
}
}