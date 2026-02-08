impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut pairs = nums.into_iter().enumerate().map(|(i, x)| (x, i as i32)).collect::<Vec<_>>();
        pairs.sort_by(|a, b| match a.0.cmp(&b.0) {
            Ordering::Equal => a.1.cmp(&b.1),
            other => other,
        });

        let mut res = 0;
        let mut count = 0;
        let mut i = 0;
        while count < k {
            res += pairs[i].0;
            count += 1;
            i += 1;
        }

        res
    }
}
}