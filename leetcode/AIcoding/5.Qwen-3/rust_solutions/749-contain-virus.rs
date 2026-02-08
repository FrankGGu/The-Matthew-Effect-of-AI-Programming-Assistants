impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn contain_virus(mut grid: Vec<Vec<char>>) -> i32 {
        let mut result = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        while true {
            let mut max_area = 0;
            let mut target = vec![vec![false; cols]; rows];
            let mut visited = vec![vec![false; cols]; rows];
            let mut queue = VecDeque::new();
            let mut areas = Vec::new();

            for r in 0..rows {
                for c in 0..cols {
                    if grid[r][c] == 'I' && !visited[r][c] {
                        let mut area = HashSet::new();
                        let mut q = VecDeque::new();
                        q.push_back((r, c));
                        visited[r][c] = true;
                        area.insert((r, c));

                        while let Some((x, y)) = q.pop_front() {
                            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                                let nx = x as i32 + dx;
                                let ny = y as i32 + dy;
                                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                                    let nx = nx as usize;
                                    let ny = ny as usize;
                                    if grid[nx][ny] == 'I' && !visited[nx][ny] {
                                        visited[nx][ny] = true;
                                        q.push_back((nx, ny));
                                        area.insert((nx, ny));
                                    }
                                }
                            }
                        }

                        let mut boundary = HashSet::new();
                        for &(x, y) in &area {
                            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                                let nx = x as i32 + dx;
                                let ny = y as i32 + dy;
                                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                                    let nx = nx as usize;
                                    let ny = ny as usize;
                                    if grid[nx][ny] == '0' {
                                        boundary.insert((nx, ny));
                                    }
                                }
                            }
                        }

                        areas.push((area, boundary));
                    }
                }
            }

            if areas.is_empty() {
                break;
            }

            let mut best_idx = 0;
            for i in 0..areas.len() {
                if areas[i].1.len() > areas[best_idx].1.len() {
                    best_idx = i;
                }
            }

            let (area, boundary) = &areas[best_idx];
            for &(x, y) in area {
                grid[x][y] = 'X';
            }

            for &(x, y) in boundary {
                grid[x][y] = 'I';
            }

            result += area.len() as i32;
        }

        result
    }
}
}