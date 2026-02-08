struct Solution;

impl Solution {
    pub fn min_cost(row_sum: i32, col_sum: i32, grid: Vec<Vec<i32>>) -> i32 {
        let mut cost = 0;
        let mut row = 0;
        let mut col = 0;

        for i in 0..grid.len() {
            for j in 0..grid[i].len() {
                if grid[i][j] == 1 {
                    cost += (i as i32 - row).abs();
                    cost += (j as i32 - col).abs();
                    row = i as i32;
                    col = j as i32;
                }
            }
        }

        cost
    }
}