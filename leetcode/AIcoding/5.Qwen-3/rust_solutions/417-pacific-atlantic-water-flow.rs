impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn pacific_atlantic(mut matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return vec![];
        }

        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut pacific = HashSet::new();
        let mut atlantic = HashSet::new();

        for i in 0..rows {
            dfs(&mut matrix, &mut pacific, i, 0);
            dfs(&mut matrix, &mut atlantic, i, cols - 1);
        }

        for j in 0..cols {
            dfs(&mut matrix, &mut pacific, 0, j);
            dfs(&mut matrix, &mut atlantic, rows - 1, j);
        }

        let mut result = vec![];
        for i in 0..rows {
            for j in 0..cols {
                if pacific.contains(&(i, j)) && atlantic.contains(&(i, j)) {
                    result.push(vec![i as i32, j as i32]);
                }
            }
        }

        result
    }
}

fn dfs(matrix: &mut Vec<Vec<i32>>, visited: &mut HashSet<(usize, usize)>, i: usize, j: usize) {
    if visited.contains(&(i, j)) {
        return;
    }

    visited.insert((i, j));

    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
    for &(dx, dy) in &directions {
        let ni = i as isize + dx;
        let nj = j as isize + dy;
        if ni >= 0 && ni < matrix.len() as isize && nj >= 0 && nj < matrix[0].len() as isize {
            let ni = ni as usize;
            let nj = nj as usize;
            if matrix[ni][nj] >= matrix[i][j] {
                dfs(matrix, visited, ni, nj);
            }
        }
    }
}
}