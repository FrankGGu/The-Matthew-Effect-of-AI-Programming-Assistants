struct Solution;

impl Solution {
    pub fn min_cut(s: String) -> i32 {
        let n = s.len();
        if n <= 1 {
            return 0;
        }

        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![0; n];
        let mut is_pal = vec![vec![false; n]; n];

        for i in 0..n {
            is_pal[i][i] = true;
        }

        for i in 1..n {
            for j in 0..i {
                if s[j] == s[i] && (i - j <= 2 || is_pal[j + 1][i - 1]) {
                    is_pal[j][i] = true;
                }
            }
        }

        for i in 0..n {
            dp[i] = i as i32;
            for j in 0..=i {
                if is_pal[j][i] {
                    if j == 0 {
                        dp[i] = 0;
                    } else {
                        dp[i] = dp[i].min(dp[j - 1] + 1);
                    }
                }
            }
        }

        dp[n - 1]
    }
}