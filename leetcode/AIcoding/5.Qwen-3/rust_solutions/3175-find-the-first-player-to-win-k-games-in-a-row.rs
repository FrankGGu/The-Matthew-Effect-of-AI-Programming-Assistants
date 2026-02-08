impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn k_consecutive_games(nums: Vec<i32>, k: i32) -> i32 {
        let mut queue = VecDeque::new();
        let mut count = 0;

        for num in nums {
            if num == 1 {
                count += 1;
                queue.push_back(num);
                if count >= k {
                    return 1;
                }
            } else {
                count = 0;
                queue.clear();
            }
        }

        0
    }
}
}