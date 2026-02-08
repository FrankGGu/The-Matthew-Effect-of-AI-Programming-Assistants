impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut count1 = 0;
        let mut count2 = 0;

        for (i, c) in s.chars().enumerate() {
            let expected_char1 = if i % 2 == 0 { '0' } else { '1' };
            let expected_char2 = if i % 2 == 0 { '1' } else { '0' };

            if c != expected_char1 {
                count1 += 1;
            }
            if c != expected_char2 {
                count2 += 1;
            }
        }

        std::cmp::min(count1, count2)
    }
}