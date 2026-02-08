struct Solution;

impl Solution {
    pub fn remove_outer_parentheses(s: String) -> String {
        let mut result = String::new();
        let mut balance = 0;
        for c in s.chars() {
            if c == '(' {
                balance += 1;
            } else {
                balance -= 1;
            }
            if balance != 0 {
                result.push(c);
            }
        }
        result
    }
}