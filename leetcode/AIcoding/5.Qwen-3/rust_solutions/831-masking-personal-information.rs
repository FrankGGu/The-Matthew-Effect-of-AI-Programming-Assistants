impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn mask_pii(email: String) -> String {
        let mut parts = email.split('@');
        let local = parts.next().unwrap();
        let domain = parts.next().unwrap();

        let mut result = String::new();
        result.push_str(&local[..1]);
        result.push_str("*****");
        result.push_str(&local[local.len() - 1..]);
        result.push('@');
        result.push_str(domain);

        result
    }

    pub fn mask_pii_phone(phone: String) -> String {
        let digits: Vec<char> = phone.chars().filter(|c| c.is_digit()).collect();
        let len = digits.len();
        let country_code = if len > 10 { Some(digits[0]) } else { None };

        let mut result = String::new();
        if let Some(c) = country_code {
            result.push(c);
            result.push(' ');
        }

        result.push('(');
        for i in 0..3 {
            result.push(digits[i]);
        }
        result.push(')');
        result.push(' ');

        for i in 3..6 {
            result.push(digits[i]);
        }
        result.push('-');

        for i in 6..len {
            result.push(digits[i]);
        }

        result
    }
}

pub struct Solution;
}