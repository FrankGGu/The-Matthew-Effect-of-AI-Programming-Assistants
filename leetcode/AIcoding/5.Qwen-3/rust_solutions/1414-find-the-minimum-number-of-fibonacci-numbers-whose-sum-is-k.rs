impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_min_fibonacci_numbers(k: i32) -> i32 {
        let mut fibs = vec![1, 1];
        while *fibs.last().unwrap() < k {
            fibs.push(fibs[fibs.len() - 1] + fibs[fibs.len() - 2]);
        }

        let mut count = 0;
        let mut remaining = k;
        for &f in fibs.iter().rev() {
            if f <= remaining {
                count += 1;
                remaining -= f;
            }
            if remaining == 0 {
                break;
            }
        }

        count
    }
}
}