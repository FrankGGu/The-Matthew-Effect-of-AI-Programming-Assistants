struct Solution;

impl Solution {
    pub fn min_cost_climbing_stairs(cost: Vec<i32>) -> i32 {
        let n = cost.len();
        let mut dp0 = 0;
        let mut dp1 = 0;

        for i in 2..=n {
            let temp = dp1;
            dp1 = std::cmp::min(dp0 + cost[i - 2], dp1 + cost[i - 1]);
            dp0 = temp;
        }

        dp1
    }
}