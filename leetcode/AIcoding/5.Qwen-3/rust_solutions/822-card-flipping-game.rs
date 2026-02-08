impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn most_points(queries: Vec<Vec<i32>>, limited: i32) -> i32 {
        let mut points = 0;
        let mut remaining = limited;
        let mut queries = queries;

        queries.sort_by(|a, b| (b[1] - b[0]).cmp(&(a[1] - a[0])));

        for q in queries {
            let cost = q[0];
            let reward = q[1];

            if remaining >= cost {
                points += reward;
                remaining -= cost;
            }
        }

        points
    }
}
}