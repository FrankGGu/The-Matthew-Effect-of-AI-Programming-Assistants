impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn sequential_digits(n: i32) -> Vec<i32> {
        let mut result = HashSet::new();
        for start in 1..=9 {
            let mut num = start;
            let mut next = start + 1;
            while next <= 9 {
                num = num * 10 + next;
                result.insert(num);
                next += 1;
            }
        }
        let mut result: Vec<i32> = result.into_iter().collect();
        result.sort();
        result.into_iter().filter(|&x| x >= n).collect()
    }
}
}