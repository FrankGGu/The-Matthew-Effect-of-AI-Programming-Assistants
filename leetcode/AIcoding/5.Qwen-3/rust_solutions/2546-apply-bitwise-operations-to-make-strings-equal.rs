struct Solution;

impl Solution {
    pub fn can_make_equal(s: String, target: String) -> bool {
        if s.len() != target.len() {
            return false;
        }
        let mut s_bits = 0;
        let mut target_bits = 0;
        for c in s.chars() {
            s_bits |= (1 << (c as u8 - b'a'));
        }
        for c in target.chars() {
            target_bits |= (1 << (c as u8 - b'a'));
        }
        s_bits == target_bits
    }
}