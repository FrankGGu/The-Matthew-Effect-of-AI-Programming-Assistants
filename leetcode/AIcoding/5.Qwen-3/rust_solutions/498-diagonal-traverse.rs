struct Solution;

impl Solution {
    pub fn find_diagonal_order(mat: Vec<Vec<i32>>) -> Vec<i32> {
        if mat.is_empty() || mat[0].is_empty() {
            return vec![];
        }

        let rows = mat.len();
        let cols = mat[0].len();
        let mut result = Vec::with_capacity(rows * cols);
        let mut row = 0;
        let mut col = 0;
        let mut direction = 1; // 1 for up, -1 for down

        while row < rows && col < cols {
            result.push(mat[row][col]);

            if direction == 1 {
                if row == 0 && col == cols - 1 {
                    row += 1;
                    direction = -1;
                } else if col == cols - 1 {
                    row += 1;
                    direction = -1;
                } else if row == 0 {
                    col += 1;
                    direction = -1;
                } else {
                    row -= 1;
                    col += 1;
                }
            } else {
                if col == 0 && row == rows - 1 {
                    col += 1;
                    direction = 1;
                } else if row == rows - 1 {
                    col += 1;
                    direction = 1;
                } else if col == 0 {
                    row += 1;
                    direction = 1;
                } else {
                    row += 1;
                    col -= 1;
                }
            }
        }

        result
    }
}