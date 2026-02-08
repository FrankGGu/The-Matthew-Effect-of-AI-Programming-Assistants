impl Solution {
    pub fn largest_submatrix(mut matrix: Vec<Vec<char>>) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();

        for j in 0..cols {
            for i in 1..rows {
                if matrix[i][j] == '1' {
                    matrix[i][j] = (matrix[i - 1][j] as u8 + b'0') as char;
                }
            }
        }

        let mut max_area = 0;

        for i in 0..rows {
            let mut heights = vec![0; cols];
            for j in 0..cols {
                if matrix[i][j] == '1' {
                    heights[j] = 1;
                } else {
                    heights[j] = 0;
                }
            }

            let mut sorted_heights = heights.clone();
            sorted_heights.sort_by(|a, b| b.cmp(a));

            for j in 0..cols {
                let area = sorted_heights[j] * (j as i32 + 1);
                max_area = std::cmp::max(max_area, area);
            }
        }

        max_area
    }
}