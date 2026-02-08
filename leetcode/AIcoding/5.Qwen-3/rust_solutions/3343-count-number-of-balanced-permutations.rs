impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_balanced_permutations(s: String) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts = Vec::new();
        for &count in freq.values() {
            counts.push(count);
        }

        let total = counts.iter().sum::<i32>();
        let half = total / 2;

        let mut dp = vec![vec![0; half as usize + 1]; counts.len()];
        for i in 0..counts.len() {
            dp[i][0] = 1;
        }

        for i in 0..counts.len() {
            for j in 1..=half {
                if j >= counts[i] {
                    dp[i][j] = dp[i - 1][j - counts[i]];
                }
                if i > 0 {
                    dp[i][j] += dp[i - 1][j];
                }
            }
        }

        let result = dp[counts.len() - 1][half as usize];

        let mut factorial = vec![1; (total as usize) + 1];
        for i in 1..=total as usize {
            factorial[i] = factorial[i - 1] * i;
        }

        let mut denominator = 1;
        for &count in &counts {
            denominator *= factorial[count as usize];
        }

        (factorial[total as usize] / denominator) * result
    }
}
}