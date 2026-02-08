impl Solution {
    pub fn maximum_odd_binary_number(s: String) -> String {
        let mut count_1 = 0;
        for c in s.chars() {
            if c == '1' {
                count_1 += 1;
            }
        }
        let mut result = String::with_capacity(s.len());
        for _ in 0..count_1 - 1 {
            result.push('1');
        }
        for _ in 0..(s.len() - count_1) {
            result.push('0');
        }
        result.push('1');
        result
    }
}