struct Solution;

impl Solution {
    pub fn image_smoother(img: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = img.len();
        let cols = img[0].len();
        let mut result = vec![vec![0; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                let mut sum = 0;
                let mut count = 0;

                for x in (i as i32 - 1)..=(i as i32 + 1) {
                    for y in (j as i32 - 1)..=(j as i32 + 1) {
                        if x >= 0 && x < rows as i32 && y >= 0 && y < cols as i32 {
                            sum += img[x as usize][y as usize];
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