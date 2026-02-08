struct Solution;

impl Solution {
    pub fn temperature_trend(temperature_a: Vec<i32>, temperature_b: Vec<i32>) -> i32 {
        let mut result = 0;
        for i in 1..temperature_a.len() {
            let diff_a = temperature_a[i] - temperature_a[i - 1];
            let diff_b = temperature_b[i] - temperature_b[i - 1];
            if (diff_a > 0 && diff_b > 0) || (diff_a < 0 && diff_b < 0) {
                result += 1;
            }
        }
        result
    }
}