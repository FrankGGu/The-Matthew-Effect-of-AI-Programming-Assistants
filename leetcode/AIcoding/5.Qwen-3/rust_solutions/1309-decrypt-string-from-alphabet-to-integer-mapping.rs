impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn freq_alphabets(s: String) -> String {
        let mut map = HashMap::new();
        for i in 1..=26 {
            let c = (b'a' + i as u8) as char;
            map.insert(format!("{}", i), c);
        }

        let mut result = String::new();
        let mut i = 0;
        while i < s.len() {
            if i + 2 < s.len() && s.as_bytes()[i + 2] == b'#' {
                let num = &s[i..i + 2];
                result.push(*map.get(num).unwrap());
                i += 3;
            } else {
                let num = &s[i..i + 1];
                result.push(*map.get(num).unwrap());
                i += 1;
            }
        }
        result
    }
}
}