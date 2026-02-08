impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn is_possible(grid: Vec<Vec<char>>) -> bool {
        let n = grid.len();
        let m = grid[0].len();

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 'B' {
                    let mut visited = HashSet::new();
                    Self::dfs(&grid, i, j, &mut visited);
                    let mut colors = HashSet::new();
                    for (x, y) in &visited {
                        colors.insert(grid[*x][*y]);
                    }
                    if colors.len() == 1 {
                        return true;
                    }
                }
            }
        }

        false
    }

    fn dfs(grid: &Vec<Vec<char>>, i: usize, j: usize, visited: &mut HashSet<(usize, usize)>) {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] != 'B' {
            return;
        }

        visited.insert((i, j));

        Self::dfs(grid, i + 1, j, visited);
        Self::dfs(grid, i - 1, j, visited);
        Self::dfs(grid, i, j + 1, visited);
        Self::dfs(grid, i, j - 1, visited);
    }
}
}