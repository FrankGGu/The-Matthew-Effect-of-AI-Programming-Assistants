impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn detect_capital_use(word: String) -> bool {
        let capitals = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        let capital_set: HashSet<char> = capitals.iter().cloned().collect();

        let mut all_capital = true;
        let mut all_lower = true;

        for c in word.chars() {
            if !capital_set.contains(&c) {
                all_capital = false;
            } else {
                all_lower = false;
            }
        }

        if all_capital {
            return true;
        }

        if all_lower {
            return true;
        }

        let first_char = word.chars().next().unwrap();
        if capital_set.contains(&first_char) {
            let rest: String = word.chars().skip(1).collect();
            for c in rest.chars() {
                if !capital_set.contains(&c) {
                    return false;
                }
            }
            return true;
        }

        false
    }
}
}