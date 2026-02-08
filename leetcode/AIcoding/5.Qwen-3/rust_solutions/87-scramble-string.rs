impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_scramble(s1: String, s2: String) -> bool {
        if s1.len() != s2.len() {
            return false;
        }
        if s1 == s2 {
            return true;
        }
        let n = s1.len();
        let mut memo = HashMap::new();
        Self::dfs(&s1, &s2, &mut memo)
    }

    fn dfs(s1: &str, s2: &str, memo: &mut HashMap<(String, String), bool>) -> bool {
        if let Some(&result) = memo.get(&(s1.to_string(), s2.to_string())) {
            return result;
        }
        if s1 == s2 {
            memo.insert((s1.to_string(), s2.to_string()), true);
            return true;
        }
        if s1.len() != s2.len() {
            memo.insert((s1.to_string(), s2.to_string()), false);
            return false;
        }
        let mut chars1: Vec<char> = s1.chars().collect();
        let mut chars2: Vec<char> = s2.chars().collect();
        chars1.sort_unstable();
        chars2.sort_unstable();
        if chars1 != chars2 {
            memo.insert((s1.to_string(), s2.to_string()), false);
            return false;
        }
        for i in 1..s1.len() {
            if Self::dfs(&s1[..i], &s2[..i], memo) && Self::dfs(&s1[i..], &s2[i..], memo) {
                memo.insert((s1.to_string(), s2.to_string()), true);
                return true;
            }
            if Self::dfs(&s1[..i], &s2[s2.len() - i..], memo) && Self::dfs(&s1[i..], &s2[..s2.len() - i], memo) {
                memo.insert((s1.to_string(), s2.to_string()), true);
                return true;
            }
        }
        memo.insert((s1.to_string(), s2.to_string()), false);
        false
    }
}
}