impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn count_sub_islands(grid1: &Vec<Vec<i32>>, grid2: &Vec<Vec<i32>>) -> i32 {
    let rows = grid2.len();
    let cols = grid2[0].len();
    let mut count = 0;

    for i in 0..rows {
        for j in 0..cols {
            if grid2[i][j] == 1 {
                let is_sub = dfs(grid1, grid2, i, j);
                if is_sub {
                    count += 1;
                }
            }
        }
    }

    count
}

fn dfs(grid1: &Vec<Vec<i32>>, grid2: &Vec<Vec<i32>>, i: usize, j: usize) -> bool {
    let rows = grid2.len();
    let cols = grid2[0].len();
    let mut queue = VecDeque::new();
    queue.push_back((i, j));
    grid2[i][j] = 0;

    let mut is_sub = true;

    while let Some((x, y)) = queue.pop_front() {
        if grid1[x][y] != 1 {
            is_sub = false;
        }

        for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;
            if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                let nx = nx as usize;
                let ny = ny as usize;
                if grid2[nx][ny] == 1 {
                    grid2[nx][ny] = 0;
                    queue.push_back((nx, ny));
                }
            }
        }
    }

    is_sub
}
}