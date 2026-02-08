impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn ambiguous_coordinates(s: String) -> Vec<String> {
        let s = &s[1..s.len() - 1];
        let mut result = HashSet::new();

        for i in 1..s.len() {
            let left = &s[..i];
            let right = &s[i..];

            let left_numbers = generate_numbers(left);
            let right_numbers = generate_numbers(right);

            for l in left_numbers {
                for r in right_numbers {
                    result.insert(format!("({}, {})", l, r));
                }
            }
        }

        result.into_iter().collect()
    }
}

fn generate_numbers(s: &str) -> Vec<String> {
    let mut result = Vec::new();

    if s.len() == 1 {
        result.push(s.to_string());
        return result;
    }

    if s.chars().next() != Some('0') {
        result.push(s.to_string());
    }

    for i in 1..s.len() {
        let part = &s[..i];
        let decimal = &s[i..];
        if decimal.chars().next() != Some('0') {
            result.push(format!("{}.{}", part, decimal));
        }
    }

    result
}
}