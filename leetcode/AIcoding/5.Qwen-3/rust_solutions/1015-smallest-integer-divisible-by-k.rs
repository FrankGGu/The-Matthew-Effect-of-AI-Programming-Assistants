struct Solution;

impl Solution {
    pub fn smallest_repunit_divisible_by_k(k: i32) -> i32 {
        if k % 2 == 0 || k % 5 == 0 {
            return -1;
        }

        let mut remainder = 0;
        let mut length = 0;

        for _ in 0..k {
            remainder = (remainder * 10 + 1) % k;
            length += 1;
            if remainder == 0 {
                return length;
            }
        }

        -1
    }
}