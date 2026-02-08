impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn delete_and_earn(n: i32, mut nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let max_num = *nums.iter().max().unwrap();
        let mut count = vec![0; (max_num + 1) as usize];

        for num in nums {
            count[num as usize] += num;
        }

        let mut prev = 0;
        let mut curr = 0;

        for i in 1..=max_num as usize {
            let temp = curr;
            curr = std::cmp::max(curr, prev + count[i]);
            prev = temp;
        }

        curr
    }
}
}