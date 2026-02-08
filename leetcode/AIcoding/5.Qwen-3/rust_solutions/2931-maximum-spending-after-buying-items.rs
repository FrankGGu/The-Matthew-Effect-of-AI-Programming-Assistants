impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn maximum_spending(mut cost: Vec<Vec<i32>>) -> i32 {
        let m = cost.len();
        let n = cost[0].len();

        let mut flat = Vec::with_capacity(m * n);
        for i in 0..m {
            for j in 0..n {
                flat.push(cost[i][j]);
            }
        }

        flat.sort_by_key(|&x| Reverse(x));

        let mut total = 0;
        for i in 0..m * n {
            total += flat[i] * (i as i32 + 1);
        }

        total
    }
}

pub struct Solution;
}