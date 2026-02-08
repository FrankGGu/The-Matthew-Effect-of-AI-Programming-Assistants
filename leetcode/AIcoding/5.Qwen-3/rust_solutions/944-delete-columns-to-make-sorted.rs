impl Solution {
    pub fn min_deletion_rows(mut grid: Vec<Vec<char>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut count = 0;

        for j in 0..n {
            for i in 1..m {
                if grid[i][j] < grid[i-1][j] {
                    count += 1;
                    break;
                }
            }
        }

        count
    }
}