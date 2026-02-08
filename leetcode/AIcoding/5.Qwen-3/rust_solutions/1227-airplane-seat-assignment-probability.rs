struct Solution;

impl Solution {
    pub fn airplane_seat_assignment_probability(n: i32) -> f64 {
        if n == 1 {
            1.0
        } else {
            1.0 / (n as f64 - 1.0)
        }
    }
}