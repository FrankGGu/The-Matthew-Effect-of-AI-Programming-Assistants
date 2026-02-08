impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_duplicate_files(files: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut map = HashMap::new();

        for file in files {
            let mut path = String::new();
            let mut content = String::new();
            let mut is_path = true;

            for part in file {
                if part == "(" {
                    is_path = false;
                } else if part == ")" {
                    map.entry(content.clone()).or_insert_with(Vec::new).push(path);
                    path.clear();
                    content.clear();
                    is_path = true;
                } else {
                    if is_path {
                        path.push_str(&part);
                        path.push('/');
                    } else {
                        content.push_str(&part);
                    }
                }
            }
        }

        let mut result = Vec::new();
        for (_, paths) in map {
            if paths.len() > 1 {
                result.push(paths);
            }
        }

        result
    }
}
}