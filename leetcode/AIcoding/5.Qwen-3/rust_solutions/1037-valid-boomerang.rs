struct Solution;

impl Solution {
    pub fn is_boomerang(points: Vec<Vec<i32>>) -> bool {
        let p1 = &points[0];
        let p2 = &points[1];
        let p3 = &points[2];

        let area = (p2[1] - p1[1]) * (p3[0] - p1[0]) - (p2[0] - p1[0]) * (p3[1] - p1[1]);
        area != 0
    }
}