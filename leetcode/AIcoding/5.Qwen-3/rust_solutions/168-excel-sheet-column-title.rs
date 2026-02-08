impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn convert_to_title(mut column_number: i32) -> String {
        let mut map = HashMap::new();
        for i in 0..26 {
            map.insert(i + 1, (b'A' + i) as char);
        }

        let mut result = String::new();
        while column_number > 0 {
            let remainder = (column_number - 1) % 26;
            result = format!("{}{}", map.get(&remainder).unwrap(), result);
            column_number = (column_number - 1) / 26;
        }
        result
    }
}
}