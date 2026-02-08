impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_duplicate(paths: Vec<String>) -> Vec<Vec<String>> {
        let mut map = HashMap::new();

        for path in paths {
            let parts: Vec<&str> = path.split_whitespace().collect();
            let file_name = parts[0];
            for i in 1..parts.len() {
                let file_info: Vec<&str> = parts[i].split("(").collect();
                let file_content = file_info[1].strip_suffix(")").unwrap();
                let file_path = format!("{}/{}", file_name, file_info[0]);
                map.entry(file_content)
                   .or_insert_with(Vec::new)
                   .push(file_path);
            }
        }

        let mut result = Vec::new();
        for v in map.values() {
            if v.len() > 1 {
                result.push(v.clone());
            }
        }

        result
    }
}
}