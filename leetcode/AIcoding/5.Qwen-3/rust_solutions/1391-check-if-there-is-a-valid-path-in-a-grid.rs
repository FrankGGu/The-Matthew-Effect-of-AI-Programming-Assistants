impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_valid_path(grid: Vec<Vec<i32>>) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut visited = HashSet::new();
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        let start = (0, 0);
        let end = (rows - 1, cols - 1);

        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        visited.insert((0, 0));

        while let Some((r, c)) = queue.pop_front() {
            if (r, c) == end {
                return true;
            }

            let cell = grid[r][c];
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if !visited.contains(&(nr, nc)) {
                        let next_cell = grid[nr][nc];
                        match cell {
                            1 => {
                                if next_cell == 1 || next_cell == 4 || next_cell == 6 {
                                    visited.insert((nr, nc));
                                    queue.push_back((nr, nc));
                                }
                            }
                            2 => {
                                if next_cell == 2 || next_cell == 3 || next_cell == 5 {
                                    visited.insert((nr, nc));
                                    queue.push_back((nr, nc));
                                }
                            }
                            3 => {
                                if next_cell == 3 || next_cell == 4 || next_cell == 5 {
                                    visited.insert((nr, nc));
                                    queue.push_back((nr, nc));
                                }
                            }
                            4 => {
                                if next_cell == 1 || next_cell == 3 || next_cell == 6 {
                                    visited.insert((nr, nc));
                                    queue.push_back((nr, nc));
                                }
                            }
                            5 => {
                                if next_cell == 1 || next_cell == 2 || next_cell == 4 {
                                    visited.insert((nr, nc));
                                    queue.push_back((nr, nc));
                                }
                            }
                            6 => {
                                if next_cell == 2 || next_cell == 5 || next_cell == 6 {
                                    visited.insert((nr, nc));
                                    queue.push_back((nr, nc));
                                }
                            }
                            _ => {}
                        }
                    }
                }
            }
        }

        false
    }
}
}