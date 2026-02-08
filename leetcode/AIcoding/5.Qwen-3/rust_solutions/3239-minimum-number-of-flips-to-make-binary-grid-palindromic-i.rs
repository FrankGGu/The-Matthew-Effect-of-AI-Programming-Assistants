impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut flips = 0;

        for i in 0..n {
            for j in 0..m / 2 {
                if grid[i][j] != grid[i][m - 1 - j] {
                    flips += 1;
                }
            }
        }

        for j in 0..m {
            for i in 0..n / 2 {
                if grid[i][j] != grid[n - 1 - i][j] {
                    flips += 1;
                }
            }
        }

        flips
    }
}