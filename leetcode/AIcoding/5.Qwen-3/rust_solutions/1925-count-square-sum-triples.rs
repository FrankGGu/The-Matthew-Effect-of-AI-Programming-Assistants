impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_triplets(n: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut count = 0;

        for a in 1..=n {
            for b in a..=n {
                let c_sq = a * a + b * b;
                if c_sq > n * n {
                    continue;
                }
                let c = (c_sq as f64).sqrt() as i32;
                if c * c == c_sq && c <= n {
                    count += 1;
                }
            }
        }

        count
    }
}
}