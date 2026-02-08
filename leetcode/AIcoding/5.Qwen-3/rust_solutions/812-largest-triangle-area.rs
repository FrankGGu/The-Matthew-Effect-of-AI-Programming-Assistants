impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn largest_triangle_area(mut points: Vec<Vec<i32>>) -> f64 {
        let mut max_area = 0.0;
        for i in 0..points.len() {
            for j in i+1..points.len() {
                for k in j+1..points.len() {
                    let area = Self::triangle_area(&points[i], &points[j], &points[k]);
                    if area > max_area {
                        max_area = area;
                    }
                }
            }
        }
        max_area
    }

    fn triangle_area(p1: &Vec<i32>, p2: &Vec<i32>, p3: &Vec<i32>) -> f64 {
        let x1 = p1[0];
        let y1 = p1[1];
        let x2 = p2[0];
        let y2 = p2[1];
        let x3 = p3[0];
        let y3 = p3[1];

        0.5 * ((x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)).abs() as f64
    }
}
}