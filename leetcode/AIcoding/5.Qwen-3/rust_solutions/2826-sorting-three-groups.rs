impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn sort_three_groups(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut res = 0;
        for i in 0..n {
            let target = (i / (n / 3)) as i32 + 1;
            while nums[i] != target {
                let j = nums.iter().position(|&x| x == target).unwrap();
                nums.swap(i, j);
                res += 1;
            }
        }
        res
    }
}
}