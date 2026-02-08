impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn color_border(grid: &mut Vec<Vec<i32>>, row: i32, col: i32, color: i32) -> Vec<Vec<i32>> {
        let original_color = grid[row as usize][col as usize];
        if original_color == color {
            return grid.clone();
        }

        let rows = grid.len();
        let cols = grid[0].len();

        let mut visited = vec![vec![false; cols]; rows];
        let mut queue = VecDeque::new();
        queue.push_back((row as usize, col as usize));
        visited[row as usize][col as usize] = true;

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((r, c)) = queue.pop_front() {
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    if !visited[nr][nc] && grid[nr][nc] == original_color {
                        visited[nr][nc] = true;
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        for r in 0..rows {
            for c in 0..cols {
                if visited[r][c] {
                    let mut is_border = false;
                    for &(dr, dc) in &directions {
                        let nr = r as i32 + dr;
                        let nc = c as i32 + dc;
                        if nr < 0 || nr >= rows as i32 || nc < 0 || nc >= cols as i32 {
                            is_border = true;
                            break;
                        }
                        if grid[nr as usize][nc as usize] != original_color {
                            is_border = true;
                            break;
                        }
                    }
                    if is_border {
                        grid[r][c] = color;
                    }
                }
            }
        }

        grid.clone()
    }
}
}