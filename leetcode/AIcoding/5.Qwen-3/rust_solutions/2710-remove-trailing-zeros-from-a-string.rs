impl Solution {
    pub fn remove_trailing_zeros(mut num: String) -> String {
        let mut i = num.len();
        while i > 0 && num.as_bytes()[i - 1] == b'0' {
            i -= 1;
        }
        num.truncate(i);
        num
    }
}