struct Solution {}

impl Solution {
    pub fn spiral_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return vec![];
        }

        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut result = Vec::with_capacity(rows * cols);
        let mut top = 0;
        let mut bottom = rows - 1;
        let mut left = 0;
        let mut right = cols - 1;

        while top <= bottom && left <= right {
            for i in left..=right {
                result.push(matrix[top][i]);
            }
            top += 1;

            for i in top..=bottom {
                result.push(matrix[i][right]);
            }
            right -= 1;

            if top > bottom || left > right {
                break;
            }

            for i in (left..=right).rev() {
                result.push(matrix[bottom][i]);
            }
            bottom -= 1;

            if top > bottom || left > right {
                break;
            }

            for i in (top..=bottom).rev() {
                result.push(matrix[i][left]);
            }
            left += 1;
        }

        result
    }
}