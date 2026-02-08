struct Solution {}

impl Solution {
    pub fn count_points(points: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for query in queries {
            let (cx, cy, cr) = (query[0], query[1], query[2]);
            let mut count = 0;
            for point in &points {
                let dx = point[0] - cx;
                let dy = point[1] - cy;
                if dx * dx + dy * dy <= cr * cr {
                    count += 1;
                }
            }
            result.push(count);
        }
        result
    }
}