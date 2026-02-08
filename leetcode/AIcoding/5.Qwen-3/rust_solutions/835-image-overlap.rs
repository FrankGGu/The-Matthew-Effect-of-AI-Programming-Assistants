impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_overlap(img1: Vec<Vec<i32>>, img2: Vec<Vec<i32>>) -> i32 {
        let n = img1.len();
        let mut coords1 = Vec::new();
        let mut coords2 = Vec::new();

        for i in 0..n {
            for j in 0..n {
                if img1[i][j] == 1 {
                    coords1.push((i, j));
                }
                if img2[i][j] == 1 {
                    coords2.push((i, j));
                }
            }
        }

        let mut map = HashMap::new();
        let mut max = 0;

        for (x1, y1) in &coords1 {
            for (x2, y2) in &coords2 {
                let dx = x1 - x2;
                let dy = y1 - y2;
                *map.entry((dx, dy)).or_insert(0) += 1;
                max = std::cmp::max(max, map[&(dx, dy)]);
            }
        }

        max as i32
    }
}
}