impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn knight_dialer(n: i32) -> i32 {
        let mut dp = vec![vec![0; 10]; n as usize];
        let mut map = HashMap::new();
        map.insert(0, vec![4, 6]);
        map.insert(1, vec![6, 8]);
        map.insert(2, vec![7, 9]);
        map.insert(3, vec![4, 8]);
        map.insert(4, vec![0, 3, 9]);
        map.insert(5, vec![]);
        map.insert(6, vec![0, 1, 7]);
        map.insert(7, vec![2, 6]);
        map.insert(8, vec![1, 3]);
        map.insert(9, vec![2, 4]);

        for i in 0..10 {
            dp[0][i] = 1;
        }

        for i in 1..n as usize {
            for j in 0..10 {
                for &k in map.get(&j).unwrap() {
                    dp[i][j] += dp[i - 1][k];
                    dp[i][j] %= 1000000007;
                }
            }
        }

        let mut result = 0;
        for i in 0..10 {
            result += dp[n as usize - 1][i];
            result %= 1000000007;
        }

        result
    }
}
}