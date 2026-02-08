struct Solution;

impl Solution {
    pub fn compress(mut chars: Vec<char>) -> i32 {
        let mut write_idx = 0;
        let mut read_idx = 0;

        while read_idx < chars.len() {
            let mut count = 1;
            let current_char = chars[read_idx];

            while read_idx + 1 < chars.len() && chars[read_idx + 1] == current_char {
                read_idx += 1;
                count += 1;
            }

            chars[write_idx] = current_char;
            write_idx += 1;

            if count > 1 {
                for c in count.to_string().chars() {
                    chars[write_idx] = c;
                    write_idx += 1;
                }
            }

            read_idx += 1;
        }

        chars.truncate(write_idx);
        write_idx as i32
    }
}