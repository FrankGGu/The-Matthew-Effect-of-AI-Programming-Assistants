impl Solution {
    pub fn grid_game(grid: Vec<Vec<i64>>) -> i64 {
        let n = grid.len();
        let mut top = 0;
        let mut bottom = 0;
        let mut result = i64::MIN;

        for i in 0..n {
            top += grid[0][i];
        }

        for i in 0..n {
            bottom += grid[1][i];
        }

        for i in 0..n {
            let current_top = top - grid[0][i];
            let current_bottom = bottom - grid[1][i];
            let max_current = current_top.max(current_bottom);
            result = result.max(max_current);
        }

        result
    }
}