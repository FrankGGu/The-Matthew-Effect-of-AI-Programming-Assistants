impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn contains_cycle(grid: Vec<Vec<char>>) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                if !visited[i][j] && dfs(&grid, &mut visited, i, j, -1, -1) {
                    return true;
                }
            }
        }

        false
    }

    fn dfs(grid: &Vec<Vec<char>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, pi: isize, pj: isize) -> bool {
        if visited[i][j] {
            return true;
        }

        visited[i][j] = true;

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        for &(dx, dy) in &directions {
            let ni = i as isize + dx;
            let nj = j as isize + dy;
            if ni >= 0 && ni < grid.len() as isize && nj >= 0 && nj < grid[0].len() as isize {
                let ni = ni as usize;
                let nj = nj as usize;
                if ni != pi as usize || nj != pj as usize {
                    if grid[i][j] == grid[ni][nj] && dfs(grid, visited, ni, nj, i as isize, j as isize) {
                        return true;
                    }
                }
            }
        }

        false
    }
}
}