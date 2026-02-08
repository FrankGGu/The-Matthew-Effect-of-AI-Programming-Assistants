impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn shortest_cycle(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut result = i32::MAX;

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 1 {
                    let mut dist = vec![vec![-1; m]; n];
                    let mut queue = VecDeque::new();
                    queue.push_back((i, j));
                    dist[i][j] = 0;

                    while let Some((x, y)) = queue.pop_front() {
                        for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                            let nx = x as i32 + dx;
                            let ny = y as i32 + dy;
                            if nx >= 0 && ny >= 0 && nx < n as i32 && ny < m as i32 {
                                let nx = nx as usize;
                                let ny = ny as usize;
                                if grid[nx][ny] == 1 && dist[nx][ny] == -1 {
                                    dist[nx][ny] = dist[x][y] + 1;
                                    queue.push_back((nx, ny));
                                } else if grid[nx][ny] == 1 && dist[nx][ny] != -1 && dist[nx][ny] < dist[x][y] {
                                    result = std::cmp::min(result, dist[x][y] + dist[nx][ny] + 1);
                                }
                            }
                        }
                    }
                }
            }
        }

        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}
}