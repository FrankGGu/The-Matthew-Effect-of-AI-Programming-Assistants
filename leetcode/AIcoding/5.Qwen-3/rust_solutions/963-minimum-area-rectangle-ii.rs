impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_area_rect(mut points: Vec<Vec<i32>>, _n: i32) -> i32 {
        let mut point_map = HashMap::new();
        for p in &points {
            point_map.entry((p[0], p[1])).or_insert(vec![]);
        }

        for p in &points {
            point_map.get_mut(&(p[0], p[1])).unwrap().push(p);
        }

        let mut min_area = i32::MAX;
        let mut seen = HashMap::new();

        for p in &points {
            let (x1, y1) = (p[0], p[1]);
            for q in &points {
                let (x2, y2) = (q[0], q[1]);
                if x1 == x2 || y1 == y2 {
                    continue;
                }
                let key = (x1, y1, x2, y2);
                if let Some(&other) = seen.get(&(x2, y1)) {
                    let area = (x2 - x1).abs() * (y2 - y1).abs();
                    min_area = min_area.min(area);
                }
                if let Some(&other) = seen.get(&(x1, y2)) {
                    let area = (x2 - x1).abs() * (y2 - y1).abs();
                    min_area = min_area.min(area);
                }
                seen.insert((x1, y2), (x2, y1));
                seen.insert((x2, y1), (x1, y2));
            }
        }

        if min_area == i32::MAX {
            0
        } else {
            min_area
        }
    }
}
}