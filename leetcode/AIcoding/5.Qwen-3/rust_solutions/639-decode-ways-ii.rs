impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let mod_val = 10_i32.pow(9) + 7;
        let mut memo = HashMap::new();
        Self::dfs(&s, 0, &mut memo, mod_val)
    }

    fn dfs(s: &str, index: usize, memo: &mut HashMap<usize, i32>, mod_val: i32) -> i32 {
        if let Some(&val) = memo.get(&index) {
            return val;
        }

        if index == s.len() {
            return 1;
        }

        if s.chars().nth(index).unwrap() == '0' {
            return 0;
        }

        let mut res = 0;

        // Single digit
        res += Self::dfs(s, index + 1, memo, mod_val);

        // Two digits
        if index + 1 < s.len() {
            let two_digit = &s[index..index + 2];
            if two_digit.starts_with('1') || (two_digit.starts_with('2') && two_digit.chars().nth(1).unwrap() <= '6') {
                res += Self::dfs(s, index + 2, memo, mod_val);
            }
        }

        res %= mod_val;
        memo.insert(index, res);
        res
    }
}
}