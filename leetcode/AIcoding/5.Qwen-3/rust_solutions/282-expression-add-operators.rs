impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn add_operators(num: String, target: i32) -> Vec<String> {
        let mut result = Vec::new();
        Self::backtrack(&num, 0, &mut String::new(), &mut result, 0, 0, target);
        result
    }

    fn backtrack(
        num: &str,
        index: usize,
        path: &mut String,
        result: &mut Vec<String>,
        prev: i64,
        curr: i64,
        target: i32,
    ) {
        if index == num.len() {
            if curr == target as i64 {
                result.push(path.clone());
            }
            return;
        }

        let mut current = 0;
        for i in index..num.len() {
            if i > index && num.as_bytes()[index] == b'0' {
                break;
            }
            current = current * 10 + (num.as_bytes()[i] - b'0') as i64;
            let s = &num[index..i + 1];
            if index == 0 {
                path.push_str(s);
                Self::backtrack(num, i + 1, path, result, current, current, target);
                path.truncate(path.len() - s.len());
            } else {
                path.push('+');
                path.push_str(s);
                Self::backtrack(num, i + 1, path, result, current, curr + current, target);
                path.truncate(path.len() - s.len() - 1);

                path.push('-');
                path.push_str(s);
                Self::backtrack(num, i + 1, path, result, -current, curr - current, target);
                path.truncate(path.len() - s.len() - 1);

                path.push('*');
                path.push_str(s);
                Self::backtrack(num, i + 1, path, result, current * prev, curr - prev + current * prev, target);
                path.truncate(path.len() - s.len() - 1);
            }
        }
    }
}
}