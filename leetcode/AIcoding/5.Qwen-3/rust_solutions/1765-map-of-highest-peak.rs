impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn highest_peak(queries: Vec<Vec<i32>>, grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![-1; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    dist[i][j] = 0;
                    queue.push_back((i, j));
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let ni = i as i32 + dx;
                let nj = j as i32 + dy;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 && dist[ni as usize][nj as usize] == -1 {
                    dist[ni as usize][nj as usize] = dist[i][j] + 1;
                    queue.push_back((ni as usize, nj as usize));
                }
            }
        }

        let mut result = Vec::new();
        for q in queries {
            let x = q[0] as usize;
            let y = q[1] as usize;
            result.push(dist[x][y]);
        }

        result
    }
}
}