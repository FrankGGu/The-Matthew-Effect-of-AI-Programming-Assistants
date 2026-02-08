impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimize_expression(s: String) -> String {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut min_val = i64::MAX;
        let mut result = String::new();

        for i in 1..n {
            if chars[i] == '+' {
                let left = &chars[0..i];
                let right = &chars[i + 1..n];

                let left_val = evaluate(left);
                let right_val = evaluate(right);

                let val = left_val + right_val;

                if val < min_val {
                    min_val = val;
                    result = format!("({}{})", s[..i].to_string(), s[i..].to_string());
                } else if val == min_val {
                    let current = format!("({}{})", s[..i].to_string(), s[i..].to_string());
                    if current < result {
                        result = current;
                    }
                }
            }
        }

        result
    }
}

fn evaluate(expr: &[char]) -> i64 {
    let mut stack = vec![];
    let mut num = 0;
    let mut sign = '+';

    for &c in expr {
        if c.is_digit(10) {
            num = num * 10 + (c as i64 - '0' as i64);
        } else {
            match sign {
                '+' => stack.push(num),
                '-' => stack.push(-num),
                '*' => stack.push(*stack.last().unwrap() * num),
                '/' => stack.push(*stack.last().unwrap() / num),
                _ => {}
            }
            sign = c;
            num = 0;
        }
    }

    match sign {
        '+' => stack.push(num),
        '-' => stack.push(-num),
        '*' => stack.push(*stack.last().unwrap() * num),
        '/' => stack.push(*stack.last().unwrap() / num),
        _ => {}
    }

    stack.iter().sum()
}
}