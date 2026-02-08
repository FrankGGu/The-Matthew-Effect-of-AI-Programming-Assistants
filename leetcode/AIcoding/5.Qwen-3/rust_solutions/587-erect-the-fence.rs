impl Solution {

use std::collections::HashSet;

#[derive(PartialEq, Eq, Hash, Clone, Copy, Debug)]
struct Point {
    x: i32,
    y: i32,
}

impl Solution {
    pub fn outer_trees(mut points: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if points.len() <= 1 {
            return points;
        }

        points.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut result = HashSet::new();
        let n = points.len();

        for (i, &p) in points.iter().enumerate() {
            let mut j = i + 1;
            let mut k = i + 1;
            for l in i + 1..n {
                let cross = (points[l][1] - p[1]) * (points[j][0] - p[0])
                    - (points[l][0] - p[0]) * (points[j][1] - p[1]);
                if cross > 0 {
                    j = l;
                } else if cross < 0 {
                    k = l;
                }
            }

            for l in i + 1..n {
                let cross = (points[l][1] - p[1]) * (points[j][0] - p[0])
                    - (points[l][0] - p[0]) * (points[j][1] - p[1]);
                if cross == 0 {
                    result.insert(points[l]);
                }
            }

            for l in i + 1..n {
                let cross = (points[l][1] - p[1]) * (points[k][0] - p[0])
                    - (points[l][0] - p[0]) * (points[k][1] - p[1]);
                if cross == 0 {
                    result.insert(points[l]);
                }
            }
        }

        let mut res: Vec<Vec<i32>> = result.into_iter().collect();
        res.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        res
    }
}
}