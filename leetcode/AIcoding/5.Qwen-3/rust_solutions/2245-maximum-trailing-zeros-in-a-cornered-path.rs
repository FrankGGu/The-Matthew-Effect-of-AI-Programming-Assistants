impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_trailing_zeros(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut row_counts = vec![vec![0; n]; m];
        let mut col_counts = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let val = grid[i][j];
                let (mut a, mut b) = (0, 0);
                while val % 5 == 0 {
                    a += 1;
                    val /= 5;
                }
                while val % 2 == 0 {
                    b += 1;
                    val /= 2;
                }
                row_counts[i][j] = [a, b];
                col_counts[i][j] = [a, b];
            }
        }

        for i in 0..m {
            for j in 1..n {
                row_counts[i][j][0] += row_counts[i][j-1][0];
                row_counts[i][j][1] += row_counts[i][j-1][1];
            }
        }

        for j in 0..n {
            for i in 1..m {
                col_counts[i][j][0] += col_counts[i-1][j][0];
                col_counts[i][j][1] += col_counts[i-1][j][1];
            }
        }

        let mut max_trail = 0;

        for i in 0..m {
            for j in 0..n {
                let (mut a, mut b) = (row_counts[i][j][0], row_counts[i][j][1]);

                if i > 0 {
                    a += col_counts[i-1][j][0];
                    b += col_counts[i-1][j][1];
                }
                if j > 0 {
                    a += row_counts[i][j-1][0];
                    b += row_counts[i][j-1][1];
                }

                max_trail = max_trail.max(a.min(b));

                let (mut a2, mut b2) = (row_counts[i][j][0], row_counts[i][j][1]);

                if i > 0 {
                    a2 += col_counts[i-1][j][0];
                    b2 += col_counts[i-1][j][1];
                }
                if j < n - 1 {
                    a2 += row_counts[i][j+1][0];
                    b2 += row_counts[i][j+1][1];
                }

                max_trail = max_trail.max(a2.min(b2));

                let (mut a3, mut b3) = (row_counts[i][j][0], row_counts[i][j][1]);

                if i < m - 1 {
                    a3 += col_counts[i+1][j][0];
                    b3 += col_counts[i+1][j][1];
                }
                if j > 0 {
                    a3 += row_counts[i][j-1][0];
                    b3 += row_counts[i][j-1][1];
                }

                max_trail = max_trail.max(a3.min(b3));

                let (mut a4, mut b4) = (row_counts[i][j][0], row_counts[i][j][1]);

                if i < m - 1 {
                    a4 += col_counts[i+1][j][0];
                    b4 += col_counts[i+1][j][1];
                }
                if j < n - 1 {
                    a4 += row_counts[i][j+1][0];
                    b4 += row_counts[i][j+1][1];
                }

                max_trail = max_trail.max(a4.min(b4));
            }
        }

        max_trail
    }
}
}