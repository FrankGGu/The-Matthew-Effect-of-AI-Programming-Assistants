impl Solution {

use std::cmp;

impl Solution {
    pub fn most_weeks_you_can_work(mut capacity: Vec<i32>) -> i32 {
        capacity.sort();
        let mut total = 0;
        for c in capacity {
            if total >= c {
                total += c;
            } else {
                return total + 1;
            }
        }
        total
    }
}
}