impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn has_groups_size_full deck: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        for &card in &deck {
            *count.entry(card).or_insert(0) += 1;
        }

        let mut gcd = 0;
        for &v in count.values() {
            gcd = Self::gcd(gcd, v);
        }

        gcd >= 2
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}