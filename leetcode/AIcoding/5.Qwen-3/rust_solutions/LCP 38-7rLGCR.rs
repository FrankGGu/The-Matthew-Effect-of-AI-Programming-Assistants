impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn guard_castle(n: i32, m: i32, k: i32, guards: Vec<Vec<i32>>, walls: Vec<Vec<i32>>, p: i32, q: i32) -> i32 {
        let mut grid = vec![vec![0; n as usize]; m as usize];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for g in guards {
            let (x, y) = (g[0] as usize, g[1] as usize);
            grid[x][y] = 2;
        }

        for w in walls {
            let (x, y) = (w[0] as usize, w[1] as usize);
            grid[x][y] = 3;
        }

        let mut queue = VecDeque::new();

        for i in 0..m as usize {
            for j in 0..n as usize {
                if grid[i][j] == 2 {
                    queue.push_back((i, j));
                }
            }
        }

        while let Some((x, y)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < m && ny >= 0 && ny < n {
                    let (nx, ny) = (nx as usize, ny as usize);
                    if grid[nx][ny] == 0 {
                        grid[nx][ny] = 1;
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        let (px, py) = (p as usize, q as usize);
        if grid[px][py] == 1 {
            1
        } else {
            0
        }
    }
}
}