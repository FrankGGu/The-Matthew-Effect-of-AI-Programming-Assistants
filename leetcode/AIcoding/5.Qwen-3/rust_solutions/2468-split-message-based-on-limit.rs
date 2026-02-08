impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn split_message(message: String, limit: i32) -> Vec<String> {
        let mut result = Vec::new();
        let message_len = message.len();
        let mut index = 0;
        let mut part_number = 1;

        while index < message_len {
            let part_str = format!("<{}/{}>", part_number, part_number);
            let part_len = part_str.len();

            if part_len + (message_len - index) > limit as usize {
                return vec![];
            }

            let mut chunk_size = limit as usize - part_len;
            let mut end = index + chunk_size;

            if end > message_len {
                end = message_len;
            }

            let chunk = message[index..end].to_string();
            let part = format!("<{}/{}>{}", part_number, part_number, chunk);
            result.push(part);

            index = end;
            part_number += 1;
        }

        result
    }
}
}