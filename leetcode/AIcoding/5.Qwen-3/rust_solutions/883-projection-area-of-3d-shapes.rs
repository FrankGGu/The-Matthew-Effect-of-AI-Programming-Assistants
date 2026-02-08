struct Solution;

impl Solution {
    pub fn projection_area(grid: Vec<Vec<i32>>) -> i32 {
        let mut xy = 0;
        let mut xz = 0;
        let mut yz = 0;

        for i in 0..grid.len() {
            for j in 0..grid[i].len() {
                if grid[i][j] > 0 {
                    xy += 1;
                }
                xz = xz.max(grid[i][j]);
                yz = yz.max(grid[i][j]);
            }
        }

        xy + xz + yz
    }
}