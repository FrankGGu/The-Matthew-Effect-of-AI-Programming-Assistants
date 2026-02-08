impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn chalk_replacement(chalk: Vec<i32>, k: i32) -> i32 {
        let mut total = 0;
        for &c in &chalk {
            total += c;
        }
        let k = k % total as i32;
        let mut queue = VecDeque::new();
        for (i, &c) in chalk.iter().enumerate() {
            if k < c {
                return i as i32;
            }
            k -= c;
        }
        -1
    }
}
}