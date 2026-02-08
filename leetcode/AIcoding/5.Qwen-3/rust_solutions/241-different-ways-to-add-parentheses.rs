impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn diff_ways_to_add_parentheses(expression: String) -> Vec<i32> {
        let mut memo = HashMap::new();
        Self::helper(&expression, &mut memo)
    }

    fn helper(expr: &str, memo: &mut HashMap<String, Vec<i32>>) -> Vec<i32> {
        if let Ok(num) = expr.parse::<i32>() {
            return vec![num];
        }

        if let Some(result) = memo.get(expr) {
            return result.clone();
        }

        let mut result = Vec::new();

        for i in 0..expr.len() {
            let c = expr.chars().nth(i).unwrap();
            if c == '+' || c == '-' || c == '*' {
                let left = &expr[..i];
                let right = &expr[i + 1..];

                let left_results = Self::helper(left, memo);
                let right_results = Self::helper(right, memo);

                for l in left_results {
                    for r in right_results {
                        match c {
                            '+' => result.push(l + r),
                            '-' => result.push(l - r),
                            '*' => result.push(l * r),
                            _ => {}
                        }
                    }
                }
            }
        }

        memo.insert(expr.to_string(), result.clone());
        result
    }
}
}