impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn can_travel(maze: Vec<Vec<char>>, start: Vec<i32>, destination: Vec<i32>) -> bool {
        let rows = maze.len();
        let cols = maze[0].len();
        let start_row = start[0] as usize;
        let start_col = start[1] as usize;
        let dest_row = destination[0] as usize;
        let dest_col = destination[1] as usize;

        if maze[start_row][start_col] != 'S' || maze[dest_row][dest_col] != 'D' {
            return false;
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        queue.push_back((start_row, start_col));
        visited.insert((start_row, start_col));

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((r, c)) = queue.pop_front() {
            if r == dest_row && c == dest_col {
                return true;
            }

            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;

                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    if !visited.contains(&(nr, nc)) && maze[nr][nc] != 'X' {
                        visited.insert((nr, nc));
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        false
    }
}
}