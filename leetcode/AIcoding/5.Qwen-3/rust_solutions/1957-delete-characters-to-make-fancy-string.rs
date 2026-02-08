struct Solution;

impl Solution {
    pub fn make_fancy_string(s: String) -> String {
        let mut result = String::with_capacity(s.len());
        let mut prev_char = '\0';
        let mut count = 0;

        for c in s.chars() {
            if c == prev_char {
                count += 1;
                if count < 2 {
                    result.push(c);
                }
            } else {
                prev_char = c;
                count = 1;
                result.push(c);
            }
        }

        result
    }
}