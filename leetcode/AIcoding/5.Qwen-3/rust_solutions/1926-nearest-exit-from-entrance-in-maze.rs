impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn nearest_exit(maze: Vec<Vec<char>>, entrance: Vec<i32>) -> i32 {
        let (rows, cols) = (maze.len(), maze[0].len());
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let (start_row, start_col) = (entrance[0] as usize, entrance[1] as usize);

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        visited.insert((start_row, start_col));
        queue.push_back((start_row, start_col, 0));

        while let Some((row, col, steps)) = queue.pop_front() {
            for &(dr, dc) in &directions {
                let (r, c) = (row as i32 + dr, col as i32 + dc);
                if r >= 0 && r < rows as i32 && c >= 0 && c < cols as i32 {
                    let (r, c) = (r as usize, c as usize);
                    if !visited.contains(&(r, c)) && maze[r][c] == '.' {
                        if r == 0 || r == rows - 1 || c == 0 || c == cols - 1 {
                            return steps + 1;
                        }
                        visited.insert((r, c));
                        queue.push_back((r, c, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}