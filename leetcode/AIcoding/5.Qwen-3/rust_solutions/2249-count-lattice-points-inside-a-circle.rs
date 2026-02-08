impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_lattice_points_inside_a_circle(r: i32, circles: Vec<Vec<i32>>) -> i32 {
        let mut points = HashSet::new();
        for circle in circles {
            let (x, y, r) = (circle[0], circle[1], circle[2]);
            for dx in 0..=r {
                for dy in 0..=r {
                    if dx * dx + dy * dy <= r * r {
                        points.insert((x + dx, y + dy));
                        points.insert((x - dx, y + dy));
                        points.insert((x + dx, y - dy));
                        points.insert((x - dx, y - dy));
                    }
                }
            }
        }
        points.len() as i32
    }
}
}