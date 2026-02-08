struct Solution;

impl Solution {
    pub fn count_unguarded(m: i32, n: i32, guards: Vec<Vec<i32>>, walls: Vec<Vec<i32>>) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let mut grid = vec![vec![0; n]; m];

        for guard in &guards {
            let x = guard[0] as usize;
            let y = guard[1] as usize;
            grid[x][y] = 2; // 2 represents a guard
        }

        for wall in &walls {
            let x = wall[0] as usize;
            let y = wall[1] as usize;
            grid[x][y] = 3; // 3 represents a wall
        }

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for guard in &guards {
            let gx = guard[0] as usize;
            let gy = guard[1] as usize;
            for &(dx, dy) in &directions {
                let mut x = gx as i32 + dx;
                let mut y = gy as i32 + dy;
                while x >= 0 && x < m as i32 && y >= 0 && y < n as i32 {
                    let x_idx = x as usize;
                    let y_idx = y as usize;
                    if grid[x_idx][y_idx] == 0 {
                        grid[x_idx][y_idx] = 1; // 1 represents a cell that is guarded
                    } else if grid[x_idx][y_idx] == 3 {
                        break;
                    }
                    x += dx;
                    y += dy;
                }
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    count += 1;
                }
            }
        }

        count as i32
    }
}