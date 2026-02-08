impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn cat_mouse_game(grid: Vec<String>, cat_jump: i32, mouse_jump: i32) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut dp = vec![vec![vec![0; 2]; m]; n];
        let mut queue = VecDeque::new();

        for i in 0..n {
            for j in 0..m {
                for k in 0..2 {
                    if grid[i][j] == '#' {
                        dp[i][j][k] = 2;
                        queue.push_back((i, j, k));
                    }
                }
            }
        }

        for i in 0..n {
            for j in 0..m {
                for k in 0..2 {
                    if grid[i][j] == '#' {
                        continue;
                    }
                    if i == j {
                        dp[i][j][k] = 1;
                        queue.push_back((i, j, k));
                    }
                }
            }
        }

        while let Some((x, y, turn)) = queue.pop_front() {
            for (nx, ny) in Self::get_neighbors(&grid, x, y, if turn == 0 { mouse_jump } else { cat_jump }) {
                if dp[nx][ny][1 - turn] == 0 {
                    if turn == 0 {
                        if dp[x][y][turn] == 1 {
                            dp[nx][ny][1 - turn] = 1;
                            queue.push_back((nx, ny, 1 - turn));
                        } else {
                            dp[nx][ny][1 - turn] = 2;
                            queue.push_back((nx, ny, 1 - turn));
                        }
                    } else {
                        if dp[x][y][turn] == 1 {
                            dp[nx][ny][1 - turn] = 2;
                            queue.push_back((nx, ny, 1 - turn));
                        } else {
                            dp[nx][ny][1 - turn] = 1;
                            queue.push_back((nx, ny, 1 - turn));
                        }
                    }
                }
            }
        }

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == '#' {
                    continue;
                }
                if i == j {
                    continue;
                }
                if dp[i][j][0] == 0 {
                    return 0;
                }
            }
        }

        0
    }

    fn get_neighbors(grid: &Vec<String>, x: usize, y: usize, jump: i32) -> Vec<(usize, usize)> {
        let mut neighbors = Vec::new();
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for &(dx, dy) in &directions {
            for step in 1..=jump as usize {
                let nx = x as i32 + dx * step as i32;
                let ny = y as i32 + dy * step as i32;
                if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if grid[nx][ny] == '#' {
                        break;
                    }
                    neighbors.push((nx, ny));
                } else {
                    break;
                }
            }
        }

        neighbors
    }
}

struct Solution {}
}