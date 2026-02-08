impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn snake_simulation(n: i32, m: i32, k: i32, arr: Vec<Vec<i32>>) -> i32 {
        let mut matrix = vec![vec![0; m as usize]; n as usize];
        let mut directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut dir_idx = 0;
        let mut x = 0;
        let mut y = 0;
        let mut visited = HashSet::new();
        let mut steps = 0;
        let mut snake = Vec::new();

        for i in 0..n as usize {
            for j in 0..m as usize {
                matrix[i][j] = 0;
            }
        }

        for i in 0..arr.len() {
            let (r, c) = (arr[i][0] as usize, arr[i][1] as usize);
            matrix[r][c] = 1;
        }

        while steps < k {
            if visited.contains(&(x, y)) {
                break;
            }
            visited.insert((x, y));
            snake.push((x, y));
            if snake.len() > 1 {
                let (x1, y1) = snake[snake.len() - 2];
                let (x2, y2) = snake[snake.len() - 1];
                if (x2 - x1).abs() + (y2 - y1).abs() != 1 {
                    break;
                }
            }
            steps += 1;

            let (dx, dy) = directions[dir_idx];
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;

            if nx >= 0 && nx < n && ny >= 0 && ny < m && matrix[nx as usize][ny as usize] == 0 {
                x = nx as usize;
                y = ny as usize;
            } else {
                dir_idx = (dir_idx + 1) % 4;
                let (dx, dy) = directions[dir_idx];
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < n && ny >= 0 && ny < m && matrix[nx as usize][ny as usize] == 0 {
                    x = nx as usize;
                    y = ny as usize;
                } else {
                    break;
                }
            }
        }

        let (x, y) = snake.last().unwrap();
        return *x as i32 * m + *y as i32;
    }
}
}