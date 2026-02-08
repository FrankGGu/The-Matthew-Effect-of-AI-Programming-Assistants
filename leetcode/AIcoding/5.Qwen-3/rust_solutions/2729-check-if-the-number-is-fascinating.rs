impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_fascinating(n: i32) -> bool {
        if n < 100 || n > 999 {
            return false;
        }

        let mut seen = HashSet::new();
        let mut num = n;

        for _ in 0..2 {
            let mut temp = num;
            while temp > 0 {
                let digit = temp % 10;
                if digit == 0 || seen.contains(&digit) {
                    return false;
                }
                seen.insert(digit);
                temp /= 10;
            }
            num *= 10;
        }

        true
    }
}
}