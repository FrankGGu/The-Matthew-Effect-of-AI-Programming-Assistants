struct Solution;

impl Solution {
    pub fn count_tested_devices(arr: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut current = 0;
        for &val in &arr {
            if val > current {
                count += 1;
                current = val;
            }
        }
        count
    }
}