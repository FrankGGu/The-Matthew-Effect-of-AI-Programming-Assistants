struct Solution;

impl Solution {
    pub fn surface_area(grid: Vec<Vec<i32>>) -> i32 {
        let mut area = 0;
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] > 0 {
                    area += 2;
                    for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                        let x = i as i32 + dx;
                        let y = j as i32 + dy;
                        if x < 0 || x >= m as i32 || y < 0 || y >= n as i32 {
                            area += grid[i][j];
                        } else {
                            area += grid[i][j] - grid[x as usize][y as usize];
                        }
                    }
                }
            }
        }

        area
    }
}