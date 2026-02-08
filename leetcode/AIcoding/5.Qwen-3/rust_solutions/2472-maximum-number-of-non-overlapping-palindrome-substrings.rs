impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_num_non_overlapping_palindromes(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![0; n + 1];
        let mut palindromes = HashSet::new();

        for i in 0..n {
            for j in i..n {
                if is_palindrome(&s[i..j + 1]) {
                    palindromes.insert((i, j));
                }
            }
        }

        for i in 1..=n {
            dp[i] = dp[i - 1];
            for (start, end) in &palindromes {
                if *end + 1 == i {
                    dp[i] = dp[i].max(dp[*start] + 1);
                }
            }
        }

        dp[n]
    }
}

fn is_palindrome(s: &str) -> bool {
    let chars: Vec<char> = s.chars().collect();
    let mut left = 0;
    let mut right = chars.len() - 1;
    while left < right {
        if chars[left] != chars[right] {
            return false;
        }
        left += 1;
        right -= 1;
    }
    true
}
}