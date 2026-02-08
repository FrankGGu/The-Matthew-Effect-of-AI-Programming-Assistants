struct Solution {}

impl Solution {
    pub fn angle_clock(hour: i32, minutes: i32) -> f64 {
        let hour_angle = (hour % 12) as f64 * 30.0 + minutes as f64 * 0.5;
        let minute_angle = minutes as f64 * 6.0;
        let diff = (hour_angle - minute_angle).abs();
        if diff > 180.0 {
            360.0 - diff
        } else {
            diff
        }
    }
}