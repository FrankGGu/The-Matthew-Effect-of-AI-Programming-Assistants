struct Solution;

impl Solution {
    pub fn minimum_distance(word: String) -> i32 {
        let mut dp = [0; 26];
        for c in word.chars() {
            let idx = (c as u8 - b'A') as usize;
            let mut new_dp = [i32::MAX; 26];
            for i in 0..26 {
                if dp[i] != i32::MAX {
                    new_dp[i] = new_dp[i].min(dp[i] + 1);
                    new_dp[idx] = new_dp[idx].min(dp[i] + (if i == idx { 0 } else { 1 }));
                }
            }
            dp = new_dp;
        }
        *dp.iter().min().unwrap()
    }
}