struct Solution;

impl Solution {
    pub fn min_operations(n: i32) -> i32 {
        let mut operations = 0;
        let mut left = 1;
        let mut right = n - 1;

        while left < right {
            operations += (right - left) / 2;
            left += 2;
            right -= 2;
        }

        operations
    }
}