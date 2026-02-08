struct Solution;

impl Solution {
    pub fn remove_comments(source: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        let mut in_comment = false;
        let mut current_line = String::new();

        for line in source {
            let mut i = 0;
            while i < line.len() {
                if in_comment {
                    if i + 1 < line.len() && line.as_bytes()[i] == b'/' && line.as_bytes()[i + 1] == b'*' {
                        in_comment = false;
                        i += 2;
                    } else {
                        i += 1;
                    }
                } else {
                    if i + 1 < line.len() && line.as_bytes()[i] == b'/' && line.as_bytes()[i + 1] == b'*' {
                        in_comment = true;
                        i += 2;
                    } else if i + 1 < line.len() && line.as_bytes()[i] == b'/' && line.as_bytes()[i + 1] == b'/' {
                        break;
                    } else {
                        current_line.push(line.chars().nth(i).unwrap());
                        i += 1;
                    }
                }
            }
            if !in_comment {
                result.push(current_line);
                current_line = String::new();
            }
        }

        result
    }
}