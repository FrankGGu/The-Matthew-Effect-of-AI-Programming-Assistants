impl Solution {

use std::str::FromStr;

impl Solution {
    pub fn is_additive_number(num: String) -> bool {
        let num = num.as_str();
        let len = num.len();
        if len < 3 {
            return false;
        }

        for i in 1..len {
            if num[0..i].len() > 1 && num[0] == '0' {
                break;
            }
            let first = match i32::from_str(&num[0..i]) {
                Ok(v) => v,
                Err(_) => continue,
            };

            for j in 1..(len - i) {
                if num[i..i + j].len() > 1 && num[i] == '0' {
                    break;
                }
                let second = match i32::from_str(&num[i..i + j]) {
                    Ok(v) => v,
                    Err(_) => continue,
                };

                let mut prev_prev = first;
                let mut prev = second;
                let mut k = i + j;

                while k < len {
                    let current = prev_prev + prev;
                    let current_str = current.to_string();
                    let current_len = current_str.len();

                    if k + current_len > len {
                        break;
                    }

                    if &num[k..k + current_len] != &current_str[..] {
                        break;
                    }

                    prev_prev = prev;
                    prev = current;
                    k += current_len;
                }

                if k == len {
                    return true;
                }
            }
        }

        false
    }
}
}