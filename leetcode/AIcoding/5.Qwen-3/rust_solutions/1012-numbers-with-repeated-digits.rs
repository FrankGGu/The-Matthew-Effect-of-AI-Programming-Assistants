impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn num_bounded_nine(n: i32) -> i32 {
        let mut result = 0;
        let digits: Vec<char> = n.to_string().chars().collect();
        let len = digits.len();

        for i in 1..len {
            result += 9 * factorial(9) / factorial(9 - i);
        }

        let mut used = vec![false; 10];
        let mut current = vec![];
        Self::backtrack(&digits, 0, &mut used, &mut current, &mut result);

        result
    }

    fn backtrack(digits: &[char], pos: usize, used: &mut Vec<bool>, current: &mut Vec<char>, result: &mut i32) {
        if pos == digits.len() {
            *result += 1;
            return;
        }

        let max_digit = digits[pos].to_digit(10).unwrap();

        for d in 0..=max_digit {
            if used[d as usize] {
                continue;
            }

            if d == 0 && current.is_empty() {
                continue;
            }

            used[d as usize] = true;
            current.push(d.to_string().chars().next().unwrap());
            Self::backtrack(digits, pos + 1, used, current, result);
            current.pop();
            used[d as usize] = false;
        }
    }

    fn factorial(n: i32) -> i32 {
        (1..=n).product()
    }
}
}