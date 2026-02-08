struct Solution;

impl Solution {
    pub fn fill_grid(n: i32) -> Vec<Vec<char>> {
        let mut grid = vec![vec!['.'; n as usize]; n as usize];
        let mut row = 0;
        let mut col = 0;
        let mut direction = 0;
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for i in 1..=n * n {
            grid[row][col] = (b'A' + (i - 1) % 26) as char;

            let (dr, dc) = directions[direction];
            let nr = row as i32 + dr;
            let nc = col as i32 + dc;

            if nr < 0 || nr >= n || nc < 0 || nc >= n || grid[nr as usize][nc as usize] != '.' {
                direction = (direction + 1) % 4;
                let (dr, dc) = directions[direction];
                row = row as i32 + dr;
                col = col as i32 + dc;
            } else {
                row = nr as usize;
                col = nc as usize;
            }
        }

        grid
    }
}