impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn sum_distances_king(n: i32, k: i32) -> i32 {
        let mut visited = HashSet::new();
        let mut result = 0;
        let mut grid = vec![vec![0; n as usize]; n as usize];
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];

        fn dfs(
            grid: &mut Vec<Vec<i32>>,
            visited: &mut HashSet<(i32, i32)>,
            directions: &[(i32, i32)],
            n: i32,
            k: i32,
            x: i32,
            y: i32,
            depth: i32,
            result: &mut i32,
        ) {
            if depth == k {
                *result += (x.abs() + y.abs()) as i32;
                return;
            }

            for &(dx, dy) in directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited.contains(&(nx, ny)) {
                    visited.insert((nx, ny));
                    grid[nx as usize][ny as usize] = depth + 1;
                    dfs(grid, visited, directions, n, k, nx, ny, depth + 1, result);
                    grid[nx as usize][ny as usize] = 0;
                    visited.remove(&(nx, ny));
                }
            }
        }

        for i in 0..n {
            for j in 0..n {
                visited.insert((i, j));
                grid[i as usize][j as usize] = 1;
                dfs(&mut grid, &mut visited, &directions, n, k, i, j, 1, &mut result);
                grid[i as usize][j as usize] = 0;
                visited.remove(&(i, j));
            }
        }

        result
    }
}
}