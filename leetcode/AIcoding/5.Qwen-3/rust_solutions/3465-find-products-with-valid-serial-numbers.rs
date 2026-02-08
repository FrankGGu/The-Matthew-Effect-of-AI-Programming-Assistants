impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn valid_serial_numbers(serial_numbers: Vec<String>, pattern: String) -> Vec<String> {
        let pattern_chars: Vec<char> = pattern.chars().collect();
        let mut result = Vec::new();

        for serial in serial_numbers {
            let mut valid = true;
            let mut i = 0;
            let mut j = 0;

            while i < serial.len() && j < pattern.len() {
                let s_char = serial.chars().nth(i).unwrap();
                let p_char = pattern_chars[j];

                if p_char == 'd' {
                    if !s_char.is_ascii_digit() {
                        valid = false;
                        break;
                    }
                } else if p_char == 'l' {
                    if !s_char.is_ascii_lowercase() {
                        valid = false;
                        break;
                    }
                } else if p_char == 'u' {
                    if !s_char.is_ascii_uppercase() {
                        valid = false;
                        break;
                    }
                } else {
                    if s_char != p_char {
                        valid = false;
                        break;
                    }
                }

                i += 1;
                j += 1;
            }

            if valid && i == serial.len() && j == pattern.len() {
                result.push(serial);
            }
        }

        result
    }
}
}