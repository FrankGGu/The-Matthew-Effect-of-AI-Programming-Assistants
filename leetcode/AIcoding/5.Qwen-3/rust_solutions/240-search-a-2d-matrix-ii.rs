impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        let (mut row, mut col) = (0, matrix[0].len() as isize - 1);
        while row < matrix.len() && col >= 0 {
            let current = matrix[row][col as usize];
            if current == target {
                return true;
            } else if current > target {
                col -= 1;
            } else {
                row += 1;
            }
        }
        false
    }
}