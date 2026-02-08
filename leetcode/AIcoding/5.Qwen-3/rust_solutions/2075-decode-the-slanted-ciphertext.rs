impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn decode_ciphertext(key: String, rows: i32) -> String {
        let rows = rows as usize;
        let mut map = HashMap::new();
        let key_chars: Vec<char> = key.chars().collect();
        let mut idx = 0;
        for i in 0..rows {
            for j in 0..key.len() {
                if i + j >= key.len() {
                    break;
                }
                let key_idx = i + j;
                let row = i;
                let col = j;
                let key_char = key_chars[key_idx];
                map.entry((row, col)).or_insert_with(Vec::new).push(key_char);
                idx += 1;
            }
        }

        let mut result = String::new();
        for (row, col) in map.keys() {
            let key_idx = *row + *col;
            if key_idx < key.len() {
                let chars = map.get(&(row, col)).unwrap();
                for c in chars {
                    result.push(*c);
                }
            }
        }

        result
    }
}
}