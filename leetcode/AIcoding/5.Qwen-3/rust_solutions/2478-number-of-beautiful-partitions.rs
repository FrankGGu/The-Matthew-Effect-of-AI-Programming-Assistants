impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn num_beautiful_partitions(s: String, k: i32) -> i32 {
        let n = s.len();
        if k == 1 {
            return 1;
        }
        let mut is_vowel = vec![false; n];
        for (i, c) in s.chars().enumerate() {
            if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
                is_vowel[i] = true;
            }
        }
        let mut valid = vec![false; n];
        for i in 0..n {
            if is_vowel[i] {
                valid[i] = true;
            }
        }
        for i in 1..n {
            if valid[i - 1] && is_vowel[i] {
                valid[i] = true;
            }
        }
        for i in 0..n {
            if valid[i] {
                let mut j = i + 1;
                while j < n {
                    if is_vowel[j] {
                        break;
                    }
                    j += 1;
                }
                if j < n {
                    valid[j] = true;
                }
            }
        }
        let mut dp = vec![vec![0; n]; k as usize];
        for i in 0..n {
            if valid[i] {
                dp[0][i] = 1;
            }
        }
        for t in 1..k as usize {
            for i in 0..n {
                if !valid[i] {
                    continue;
                }
                for j in 0..i {
                    if valid[j] {
                        dp[t][i] += dp[t - 1][j];
                    }
                }
            }
        }
        let mut result = 0;
        for i in 0..n {
            if valid[i] {
                result += dp[k as usize - 1][i];
            }
        }
        result
    }
}
}