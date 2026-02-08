impl Solution {
    pub fn replace_digits(s: String) -> String {
        let mut result = String::with_capacity(s.len());
        let bytes = s.as_bytes();

        for i in 0..s.len() {
            if i % 2 == 0 {
                result.push(bytes[i] as char);
            } else {
                let prev_char = bytes[i - 1] as char;
                let shift = (bytes[i] - b'0') as u8;
                let new_char = (prev_char as u8 + shift) as char;
                result.push(new_char);
            }
        }

        result
    }
}