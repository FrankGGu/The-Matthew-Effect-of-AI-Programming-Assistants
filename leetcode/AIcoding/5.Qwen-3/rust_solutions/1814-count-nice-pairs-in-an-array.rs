impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_nice_pairs(mut nums: Vec<i32>) -> i32 {
        fn reverse(x: i32) -> i32 {
            let mut num = x;
            let mut rev = 0;
            while num > 0 {
                rev = rev * 10 + num % 10;
                num /= 10;
            }
            rev
        }

        let mut count = HashMap::new();
        let mut result = 0;

        for num in &mut nums {
            let rev = reverse(*num);
            *count.entry(rev).or_insert(0) += 1;
        }

        for v in count.values() {
            result += v * (v - 1) / 2;
        }

        result
    }
}
}