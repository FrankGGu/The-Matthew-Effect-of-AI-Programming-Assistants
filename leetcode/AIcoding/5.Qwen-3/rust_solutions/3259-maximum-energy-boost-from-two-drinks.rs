struct Solution;

impl Solution {
    pub fn max_energy_drink1(energy: Vec<i32>) -> i32 {
        let n = energy.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return energy[0];
        }
        let mut dp = vec![0; n];
        dp[0] = energy[0];
        dp[1] = energy[0] + energy[1];
        for i in 2..n {
            dp[i] = std::cmp::max(dp[i - 1], dp[i - 2] + energy[i]);
        }
        dp[n - 1]
    }

    pub fn max_energy_drink2(energy: Vec<i32>) -> i32 {
        let n = energy.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return energy[0];
        }
        let mut prev_prev = energy[0];
        let mut prev = energy[0] + energy[1];
        for i in 2..n {
            let current = std::cmp::max(prev, prev_prev + energy[i]);
            prev_prev = prev;
            prev = current;
        }
        prev
    }
}