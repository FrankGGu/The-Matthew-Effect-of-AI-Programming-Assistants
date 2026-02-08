impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn is_solvable(terms: Vec<String>, result: String) -> bool {
        let mut chars = HashSet::new();
        let mut first_chars = HashSet::new();

        for term in &terms {
            if !term.is_empty() {
                first_chars.insert(term.chars().next().unwrap());
            }
            for c in term.chars() {
                chars.insert(c);
            }
        }

        if !result.is_empty() {
            first_chars.insert(result.chars().next().unwrap());
        }

        for c in result.chars() {
            chars.insert(c);
        }

        let chars: Vec<char> = chars.into_iter().collect();
        let mut mapping = HashMap::new();
        let mut used_digits = vec![false; 10];

        fn backtrack(
            terms: &[String],
            result: &str,
            chars: &[char],
            index: usize,
            mapping: &mut HashMap<char, u8>,
            used_digits: &mut Vec<bool>,
            first_chars: &HashSet<char>,
            carry: i32,
        ) -> bool {
            if index == chars.len() {
                return check_solution(terms, result, mapping);
            }

            let c = chars[index];
            let is_first = first_chars.contains(&c);

            for d in 0..10 {
                if used_digits[d] {
                    continue;
                }

                if d == 0 && is_first {
                    continue;
                }

                mapping.insert(c, d as u8);
                used_digits[d] = true;

                if backtrack(terms, result, chars, index + 1, mapping, used_digits, first_chars, carry) {
                    return true;
                }

                mapping.remove(&c);
                used_digits[d] = false;
            }

            false
        }

        fn check_solution(
            terms: &[String],
            result: &str,
            mapping: &HashMap<char, u8>,
        ) -> bool {
            let mut total = 0;
            for term in terms {
                let mut val = 0;
                for c in term.chars() {
                    val = val * 10 + *mapping.get(&c).unwrap() as i32;
                }
                total += val;
            }

            let mut res_val = 0;
            for c in result.chars() {
                res_val = res_val * 10 + *mapping.get(&c).unwrap() as i32;
            }

            total == res_val
        }

        backtrack(&terms, &result, &chars, 0, &mut mapping, &mut used_digits, &first_chars, 0)
    }
}
}