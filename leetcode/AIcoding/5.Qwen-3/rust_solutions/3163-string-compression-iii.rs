struct Solution;

impl Solution {
    pub fn compress_string(s: String) -> String {
        if s.is_empty() {
            return String::new();
        }

        let mut result = String::new();
        let chars: Vec<char> = s.chars().collect();
        let mut count = 1;

        for i in 1..chars.len() {
            if chars[i] == chars[i - 1] {
                count += 1;
            } else {
                result.push(chars[i - 1]);
                result.push_str(&count.to_string());
                count = 1;
            }
        }

        result.push(chars.last().unwrap());
        result.push_str(&count.to_string());

        result
    }
}