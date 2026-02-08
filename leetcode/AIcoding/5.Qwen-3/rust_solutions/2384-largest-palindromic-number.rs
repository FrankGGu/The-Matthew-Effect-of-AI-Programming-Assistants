impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn largest_palindromic_number(num: String) -> String {
        let mut count = HashMap::new();
        for c in num.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut res = String::new();
        let mut middle = None;

        for c in '9'..='0' {
            if let Some(&mut cnt) = count.get_mut(&c) {
                if cnt >= 2 {
                    let pairs = cnt / 2;
                    if pairs > 0 {
                        res.push(c);
                        res.push(c);
                        *count.get_mut(&c).unwrap() -= pairs * 2;
                    }
                }
            }
        }

        for c in '0'..='9' {
            if let Some(&mut cnt) = count.get_mut(&c) {
                if cnt > 0 {
                    middle = Some(c);
                    break;
                }
            }
        }

        if res.is_empty() && middle.is_none() {
            return "0".to_string();
        }

        if res.is_empty() {
            return middle.unwrap().to_string();
        }

        let mut result = res.clone();
        if let Some(m) = middle {
            result.push(m);
        }
        result.push_str(&res.chars().rev().collect::<String>());

        if result == "00" {
            "0".to_string()
        } else {
            result
        }
    }
}
}