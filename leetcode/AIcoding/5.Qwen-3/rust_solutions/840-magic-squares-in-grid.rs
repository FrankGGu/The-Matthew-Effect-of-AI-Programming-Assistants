struct Solution;

impl Solution {
    pub fn num_magic_squares_grid(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        if m < 3 || n < 3 {
            return 0;
        }
        let mut count = 0;
        for i in 0..m - 2 {
            for j in 0..n - 2 {
                if is_magic(&grid, i, j) {
                    count += 1;
                }
            }
        }
        count
    }
}

fn is_magic(grid: &Vec<Vec<i32>>, x: usize, y: usize) -> bool {
    let mut seen = std::collections::HashSet::new();
    for i in 0..3 {
        for j in 0..3 {
            let val = grid[x + i][y + j];
            if val < 1 || val > 9 {
                return false;
            }
            if seen.contains(&val) {
                return false;
            }
            seen.insert(val);
        }
    }
    let sum = grid[x][y] + grid[x][y + 1] + grid[x][y + 2];
    for i in 0..3 {
        if grid[x + i][y] + grid[x + i][y + 1] + grid[x + i][y + 2] != sum {
            return false;
        }
    }
    for j in 0..3 {
        if grid[x][y + j] + grid[x + 1][y + j] + grid[x + 2][y + j] != sum {
            return false;
        }
    }
    if grid[x][y] + grid[x + 1][y + 1] + grid[x + 2][y + 2] != sum {
        return false;
    }
    if grid[x][y + 2] + grid[x + 1][y + 1] + grid[x + 2][y] != sum {
        return false;
    }
    true
}