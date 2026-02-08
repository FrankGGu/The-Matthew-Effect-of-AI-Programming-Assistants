impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut length = 0;
        let mut has_odd = false;

        for &v in count.values() {
            if v % 2 == 0 {
                length += v;
            } else {
                length += v - 1;
                has_odd = true;
            }
        }

        if has_odd {
            length += 1;
        }

        let mut result = String::with_capacity(length);
        for (c, &v) in &count {
            let mut half = v / 2;
            while half > 0 {
                result.push(*c);
                half -= 1;
            }
        }

        if has_odd {
            let middle = count.iter().find(|&(_, &v)| v % 2 == 1).map(|(c, _)| *c).unwrap();
            result.push(middle);
        }

        result
    }
}
}