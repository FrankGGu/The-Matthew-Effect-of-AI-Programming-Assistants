impl Solution {

use std::cmp::Ordering;
use std::collections::HashSet;

impl Solution {
    pub fn visible_points(points: Vec<Vec<i32>>, angle: i32) -> i32 {
        let mut angles = Vec::new();
        let mut base = 0;
        for point in &points {
            let dx = point[0];
            let dy = point[1];
            if dx == 0 && dy == 0 {
                base += 1;
            } else {
                let rad = (dy as f64).atan2(dx as f64);
                let deg = rad * 180.0 / std::f64::consts::PI;
                angles.push(deg);
            }
        }

        angles.sort_by(|a, b| a.partial_cmp(b).unwrap_or(Ordering::Equal));
        let mut max = 0;
        let len = angles.len();
        for i in 0..len {
            let mut j = i;
            while j < len && angles[j] - angles[i] <= angle as f64 + 1e-8 {
                j += 1;
            }
            max = max.max(j - i);
        }

        for i in 0..len {
            let mut j = i;
            while j < len && angles[j] - angles[i] + 360.0 <= angle as f64 + 1e-8 {
                j += 1;
            }
            max = max.max(j - i);
        }

        max as i32 + base
    }
}
}