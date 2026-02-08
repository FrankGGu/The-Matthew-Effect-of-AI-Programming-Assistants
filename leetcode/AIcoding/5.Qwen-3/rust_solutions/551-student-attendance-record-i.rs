struct Solution;

impl Solution {
    pub fn check_record(s: String) -> bool {
        let mut count_a = 0;
        let mut count_l = 0;

        for c in s.chars() {
            if c == 'A' {
                count_a += 1;
                count_l = 0;
                if count_a >= 2 {
                    return false;
                }
            } else if c == 'L' {
                count_l += 1;
                if count_l >= 3 {
                    return false;
                }
            } else {
                count_l = 0;
            }
        }

        true
    }
}