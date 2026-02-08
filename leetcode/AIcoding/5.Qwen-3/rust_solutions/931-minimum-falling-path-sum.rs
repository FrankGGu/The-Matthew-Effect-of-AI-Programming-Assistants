impl Solution {
    pub fn min_falling_path_sum(mut matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        for i in 1..n {
            for j in 0..n {
                let mut min_val = matrix[i - 1][j];
                if j > 0 {
                    min_val = min_val.min(matrix[i - 1][j - 1]);
                }
                if j < n - 1 {
                    min_val = min_val.min(matrix[i - 1][j + 1]);
                }
                matrix[i][j] += min_val;
            }
        }
        *matrix[n - 1].iter().min().unwrap()
    }
}