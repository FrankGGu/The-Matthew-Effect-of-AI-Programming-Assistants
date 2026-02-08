impl Solution {

use std::cmp;

impl Solution {
    pub fn largest_altitude(assets: Vec<i32>) -> i32 {
        let mut max_altitude = 0;
        let mut current_altitude = 0;

        for asset in assets {
            current_altitude += asset;
            max_altitude = cmp::max(max_altitude, current_altitude);
        }

        max_altitude
    }
}
}