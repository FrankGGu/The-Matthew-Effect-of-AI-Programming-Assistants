impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_text_messages(s: String) -> i64 {
        let mut dp = vec![0; s.len() + 1];
        dp[0] = 1;
        let key_map = vec![
            vec!['a', 'b', 'c'],
            vec!['d', 'e', 'f'],
            vec!['g', 'h', 'i'],
            vec!['j', 'k', 'l'],
            vec!['m', 'n', 'o'],
            vec!['p', 'q', 'r', 's'],
            vec!['t', 'u', 'v'],
            vec!['w', 'x', 'y', 'z'],
        ];
        let key_map_len = key_map.iter().map(|v| v.len()).collect::<Vec<_>>();

        for i in 1..=s.len() {
            let c = s.chars().nth(i - 1).unwrap();
            for j in 0..8 {
                if key_map[j].contains(&c) {
                    let k = key_map_len[j];
                    for l in 1..=k {
                        if i >= l {
                            dp[i] += dp[i - l];
                        }
                    }
                }
            }
        }

        dp[s.len()]
    }
}
}