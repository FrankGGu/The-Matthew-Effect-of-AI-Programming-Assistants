struct Solution;

impl Solution {
    pub fn check_valid_matrix(matrix: Vec<Vec<i32>>) -> bool {
        let n = matrix.len();
        for i in 0..n {
            let mut row = std::collections::HashSet::new();
            let mut col = std::collections::HashSet::new();
            for j in 0..n {
                if matrix[i][j] < 1 || matrix[i][j] > (n as i32) {
                    return false;
                }
                row.insert(matrix[i][j]);
                col.insert(matrix[j][i]);
            }
            if row.len() != n || col.len() != n {
                return false;
            }
        }
        true
    }
}