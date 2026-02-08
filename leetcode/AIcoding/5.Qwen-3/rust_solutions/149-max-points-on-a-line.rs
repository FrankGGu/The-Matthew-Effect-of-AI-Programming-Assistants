impl Solution {

use std::collections::HashMap;

#[derive(PartialEq, Eq, Hash, Clone, Copy)]
pub struct Point {
    pub x: i32,
    pub y: i32,
}

impl Solution {
    pub fn max_points(points: Vec<Point>) -> i32 {
        if points.is_empty() {
            return 0;
        }
        if points.len() == 1 {
            return 1;
        }

        let mut max_points = 0;

        for (i, &p1) in points.iter().enumerate() {
            let mut slope_count = HashMap::new();
            let mut same_point = 0;
            let mut current_max = 0;

            for j in i + 1..points.len() {
                let p2 = points[j];

                if p1 == p2 {
                    same_point += 1;
                    continue;
                }

                let dx = p2.x - p1.x;
                let dy = p2.y - p1.y;

                let gcd = Self::gcd(dx, dy);
                let slope = (dx / gcd, dy / gcd);

                *slope_count.entry(slope).or_insert(0) += 1;
                current_max = current_max.max(*slope_count.get(&slope).unwrap());
            }

            max_points = max_points.max(current_max + same_point + 1);
        }

        max_points
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a.abs()
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}