impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_ways(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut map = HashMap::new();

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let dx = points[i][0] - points[j][0];
                    let dy = points[i][1] - points[j][1];
                    let key = (dx, dy);
                    *map.entry(key).or_insert(0) += 1;
                }
            }
        }

        let mut result = 0;
        for (_, &count) in &map {
            result += count * (count - 1) / 2;
        }

        result
    }
}
}