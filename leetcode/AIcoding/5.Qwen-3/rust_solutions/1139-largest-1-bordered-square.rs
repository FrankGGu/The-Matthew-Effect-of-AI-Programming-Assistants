struct Solution;

impl Solution {
    pub fn largest_one_bordered_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_len = 0;

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    let mut len = 1;
                    while i + len < m && j + len < n && grid[i + len][j] == 1 && grid[i][j + len] == 1 {
                        len += 1;
                    }
                    if len > max_len {
                        max_len = len;
                    }
                }
            }
        }

        max_len as i32
    }
}