struct Solution {}

impl Solution {
    pub fn kth_character(n: i32, k: i32) -> char {
        let mut k = k as u64;
        let mut n = n as u64;
        let mut result = 'a' as u8;

        while n > 1 {
            n -= 1;
            if k % 2 == 1 {
                result += 1;
            }
            k = (k + 1) / 2;
        }

        (result as char)
    }
}