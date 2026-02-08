impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_rectangles_to_cover_points(points: Vec<Vec<i32>>, w: i32) -> i32 {
        let mut x_coords = HashSet::new();
        for point in &points {
            x_coords.insert(point[0]);
        }

        let mut sorted_x: Vec<_> = x_coords.into_iter().collect();
        sorted_x.sort();

        let mut count = 0;
        let mut i = 0;
        while i < sorted_x.len() {
            let start = sorted_x[i];
            let end = start + w;
            while i < sorted_x.len() && sorted_x[i] <= end {
                i += 1;
            }
            count += 1;
        }

        count
    }
}
}