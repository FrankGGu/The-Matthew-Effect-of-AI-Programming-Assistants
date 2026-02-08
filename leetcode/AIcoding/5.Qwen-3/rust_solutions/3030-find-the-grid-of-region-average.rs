impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn image_smoother(img: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = img.len();
        let cols = img[0].len();
        let mut result = vec![vec![0; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                let mut sum = 0;
                let mut count = 0;
                for x in [i - 1, i, i + 1].iter() {
                    for y in [j - 1, j, j + 1].iter() {
                        if *x < rows && *y < cols {
                            sum += img[*x][*y];
                            count += 1;
                        }
                    }
                }
                result[i][j] = sum / count;
            }
        }

        result
    }
}
}