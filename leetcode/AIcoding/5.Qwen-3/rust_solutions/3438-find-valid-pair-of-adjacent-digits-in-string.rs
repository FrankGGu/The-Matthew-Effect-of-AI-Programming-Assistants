struct Solution;

impl Solution {
    pub fn has_valid_pair(s: String) -> bool {
        for i in 0..s.len() - 1 {
            let c1 = s.as_bytes()[i];
            let c2 = s.as_bytes()[i + 1];
            if (c1 == b'0' && c2 == b'1') || (c1 == b'1' && c2 == b'0') {
                return true;
            }
        }
        false
    }
}