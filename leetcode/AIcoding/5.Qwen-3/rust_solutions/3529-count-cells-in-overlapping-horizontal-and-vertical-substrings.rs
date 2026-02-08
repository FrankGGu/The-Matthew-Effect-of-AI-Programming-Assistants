struct Solution;

impl Solution {
    pub fn count_cells(s: String) -> i32 {
        let mut count = 0;
        let mut i = 0;
        while i < s.len() {
            if s.as_bytes()[i] == b'H' || s.as_bytes()[i] == b'V' {
                count += 1;
                i += 1;
            } else {
                i += 1;
            }
        }
        count
    }
}