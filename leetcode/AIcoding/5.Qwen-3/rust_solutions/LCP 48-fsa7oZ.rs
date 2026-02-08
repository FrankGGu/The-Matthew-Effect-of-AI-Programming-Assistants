impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn number_of_reachable_nodes(grid: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut result = vec![];
        let n = grid.len();
        let m = grid[0].len();

        let mut visited = vec![vec![false; m]; n];
        let mut nodes = vec![];

        for i in 0..n {
            for j in 0..m {
                if !visited[i][j] {
                    let size = Self::bfs(&grid, &mut visited, i, j);
                    nodes.push(size);
                }
            }
        }

        nodes.sort();

        for q in queries {
            let count = Self::count_reachable(&nodes, q);
            result.push(count);
        }

        result
    }

    fn bfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((i, j));
        visited[i][j] = true;
        let mut size = 0;

        while let Some((x, y)) = queue.pop_front() {
            size += 1;
            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if !visited[nx][ny] && grid[nx][ny] == grid[i][j] {
                        visited[nx][ny] = true;
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        size
    }

    fn count_reachable(nodes: &Vec<i32>, q: i32) -> i32 {
        let mut count = 0;
        for &size in nodes {
            if size <= q {
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}
}