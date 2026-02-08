impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn get_number_of_beads(grid: Vec<Vec<char>>, r: i32, c: i32) -> i32 {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        let rows = grid.len() as i32;
        let cols = grid[0].len() as i32;
        let target = grid[r as usize][c as usize];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        if grid[r as usize][c as usize] == '.' {
            return 0;
        }

        queue.push_back((r, c));
        visited.insert((r, c));
        let mut count = 0;

        while let Some((x, y)) = queue.pop_front() {
            count += 1;
            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < rows && ny >= 0 && ny < cols {
                    let pos = (nx, ny);
                    if !visited.contains(&pos) && grid[nx as usize][ny as usize] == target {
                        visited.insert(pos);
                        queue.push_back(pos);
                    }
                }
            }
        }

        count
    }
}
}