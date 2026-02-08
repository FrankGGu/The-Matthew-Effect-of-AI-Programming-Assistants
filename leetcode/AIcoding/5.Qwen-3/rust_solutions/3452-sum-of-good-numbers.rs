struct Solution;

impl Solution {
    pub fn sum_good_numbers(n: i32) -> i32 {
        let mut result = 0;
        for a in 1..=n {
            for b in 1..=n {
                for c in 1..=n {
                    if a * a + b * b == c * c {
                        result += a + b + c;
                    }
                }
            }
        }
        result
    }
}