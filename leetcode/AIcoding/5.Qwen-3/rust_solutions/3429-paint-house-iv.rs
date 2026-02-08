struct Solution;

impl Solution {
    pub fn min_cost(mut costs: Vec<Vec<i32>>, k: i32, n: i32) -> i32 {
        let k = k as usize;
        let n = n as usize;
        for i in 1..n {
            for j in 0..k {
                let mut min_cost = i32::MAX;
                for l in 0..k {
                    if l != j {
                        min_cost = min_cost.min(costs[i - 1][l]);
                    }
                }
                costs[i][j] += min_cost;
            }
        }
        *costs[n - 1].iter().min().unwrap()
    }
}