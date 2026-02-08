struct Solution;

impl Solution {
    pub fn largest_altitude(operations: Vec<char>) -> i32 {
        let mut max_altitude = 0;
        let mut current_altitude = 0;

        for op in operations {
            match op {
                'i' => current_altitude += 1,
                'd' => current_altitude -= 1,
                _ => {}
            }
            if current_altitude > max_altitude {
                max_altitude = current_altitude;
            }
        }

        max_altitude
    }
}