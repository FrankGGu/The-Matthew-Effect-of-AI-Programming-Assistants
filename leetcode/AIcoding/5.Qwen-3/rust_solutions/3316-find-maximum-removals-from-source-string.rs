impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_removals(source: String, target: String, original: String, changed: String) -> i32 {
        let mut adj = vec![vec![]; 26];
        for (i, c) in original.chars().enumerate() {
            let from = c as usize - 'a' as usize;
            let to = changed.chars().nth(i).unwrap() as usize - 'a' as usize;
            adj[from].push(to);
        }

        let mut dp = vec![vec![0; 26]; source.len()];
        for i in 0..source.len() {
            for j in 0..26 {
                if i > 0 {
                    dp[i][j] = dp[i - 1][j];
                }
                if source.as_bytes()[i] as char as usize - 'a' as usize == j {
                    dp[i][j] += 1;
                }
            }
        }

        let mut res = 0;
        let mut t = 0;
        for i in 0..source.len() {
            if t >= target.len() {
                break;
            }
            let c = target.as_bytes()[t] as char as usize - 'a' as usize;
            let mut found = false;
            for &neighbor in &adj[c] {
                if dp[i][neighbor] > 0 {
                    res += 1;
                    t += 1;
                    found = true;
                    break;
                }
            }
            if !found {
                return -1;
            }
        }

        res
    }
}
}