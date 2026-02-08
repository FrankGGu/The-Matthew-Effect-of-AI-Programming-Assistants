impl Solution {

use std::cmp::max;

impl Solution {
    pub fn grid_illumination(n: i32, queries: Vec<Vec<i32>>) -> Vec<bool> {
        use std::collections::HashMap;

        let mut row = HashMap::new();
        let mut col = HashMap::new();
        let mut diag1 = HashMap::new();
        let mut diag2 = HashMap::new();
        let mut seen = HashMap::new();

        for i in 0..n {
            for j in 0..n {
                *row.entry(i).or_insert(0) += 1;
                *col.entry(j).or_insert(0) += 1;
                *diag1.entry(i - j).or_insert(0) += 1;
                *diag2.entry(i + j).or_insert(0) += 1;
                seen.insert((i, j), true);
            }
        }

        let mut res = Vec::new();

        for q in queries {
            let x = q[0];
            let y = q[1];

            let has_light = row.get(&x).unwrap_or(&0) > &0
                || col.get(&y).unwrap_or(&0) > &0
                || diag1.get(&(x - y)).unwrap_or(&0) > &0
                || diag2.get(&(x + y)).unwrap_or(&0) > &0;

            res.push(has_light);

            if has_light {
                for dx in [-1, 0, 1] {
                    for dy in [-1, 0, 1] {
                        let nx = x + dx;
                        let ny = y + dy;
                        if nx >= 0 && nx < n && ny >= 0 && ny < n {
                            if let Some(_) = seen.remove(&(nx, ny)) {
                                *row.get_mut(&nx).unwrap() -= 1;
                                *col.get_mut(&ny).unwrap() -= 1;
                                *diag1.get_mut(&(nx - ny)).unwrap() -= 1;
                                *diag2.get_mut(&(nx + ny)).unwrap() -= 1;
                                if *row.get(&nx).unwrap() == 0 {
                                    row.remove(&nx);
                                }
                                if *col.get(&ny).unwrap() == 0 {
                                    col.remove(&ny);
                                }
                                if *diag1.get(&(nx - ny)).unwrap() == 0 {
                                    diag1.remove(&(nx - ny));
                                }
                                if *diag2.get(&(nx + ny)).unwrap() == 0 {
                                    diag2.remove(&(nx + ny));
                                }
                            }
                        }
                    }
                }
            }
        }

        res
    }
}
}