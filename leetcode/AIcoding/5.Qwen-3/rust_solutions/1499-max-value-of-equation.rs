impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_max_value_of_equation(mut nums: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut max_val = i32::MIN;
        let mut deque = Vec::new();

        for num in nums {
            let x = num[0];
            let y = num[1];

            while !deque.is_empty() && x - deque[0][0] > k {
                deque.remove(0);
            }

            if !deque.is_empty() {
                let best = deque[0][1] + x + y;
                max_val = max_val.max(best);
            }

            while !deque.is_empty() && y >= deque.last().unwrap()[1] {
                deque.pop_last();
            }

            deque.push(vec![x, y]);
        }

        max_val
    }
}
}