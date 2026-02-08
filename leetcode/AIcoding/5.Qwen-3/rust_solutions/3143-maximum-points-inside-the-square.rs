struct Solution;

impl Solution {
    pub fn max_points_inside_square(mut points: Vec<Vec<i32>>, mut queries: Vec<i32>) -> Vec<i32> {
        use std::collections::BTreeSet;
        use std::cmp::Ordering;

        let mut point_set = BTreeSet::new();
        for p in &points {
            let x = p[0];
            let y = p[1];
            let dist = x.abs().max(y.abs());
            point_set.insert((dist, x, y));
        }

        let mut result = vec![0; queries.len()];
        for (i, &q) in queries.iter().enumerate() {
            let count = point_set.range((q, i32::MIN, i32::MIN)..=(q, i32::MAX, i32::MAX)).count();
            result[i] = count as i32;
        }

        result
    }
}