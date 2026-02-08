struct Solution;

impl Solution {
    pub fn min_rectangle_area(points: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashSet;

        let mut point_set = HashSet::new();
        for p in &points {
            point_set.insert((p[0], p[1]));
        }

        let mut min_area = i32::MAX;

        for i in 0..points.len() {
            for j in i + 1..points.len() {
                let (x1, y1) = (points[i][0], points[i][1]);
                let (x2, y2) = (points[j][0], points[j][1]);

                if x1 == x2 || y1 == y2 {
                    continue;
                }

                let x3 = x1;
                let y3 = y2;
                let x4 = x2;
                let y4 = y1;

                if point_set.contains(&(x3, y3)) && point_set.contains(&(x4, y4)) {
                    let area = (x2 - x1).abs() * (y2 - y1).abs();
                    min_area = min_area.min(area);
                }
            }
        }

        if min_area == i32::MAX {
            0
        } else {
            min_area
        }
    }
}