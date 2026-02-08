impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn cars_in_intersection(roads: Vec<Vec<i32>>) -> i32 {
        let mut points = HashSet::new();
        for road in roads {
            let (x1, y1, x2, y2) = (road[0], road[1], road[2], road[3]);
            if x1 == x2 {
                let (min_y, max_y) = if y1 < y2 { (y1, y2) } else { (y2, y1) };
                for y in min_y..=max_y {
                    points.insert((x1, y));
                }
            } else if y1 == y2 {
                let (min_x, max_x) = if x1 < x2 { (x1, x2) } else { (x2, x1) };
                for x in min_x..=max_x {
                    points.insert((x, y1));
                }
            }
        }
        points.len() as i32
    }
}
}