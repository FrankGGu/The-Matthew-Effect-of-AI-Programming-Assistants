impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn average_value(grid: Vec<Vec<i32>>) -> i32 {
        let mut sum = 0;
        let mut count = 0;
        for row in grid {
            for num in row {
                if num % 6 == 0 {
                    sum += num;
                    count += 1;
                }
            }
        }
        if count == 0 {
            0
        } else {
            sum / count
        }
    }
}
}