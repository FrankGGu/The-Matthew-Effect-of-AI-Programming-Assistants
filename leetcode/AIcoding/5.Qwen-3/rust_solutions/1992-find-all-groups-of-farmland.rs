impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_farmland(mut land: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = land.len();
        let n = land[0].len();
        let mut result = Vec::new();
        let mut visited = vec![vec![false; n]; m];

        for i in 0..m {
            for j in 0..n {
                if land[i][j] == 1 && !visited[i][j] {
                    let mut queue = VecDeque::new();
                    queue.push_back((i, j));
                    visited[i][j] = true;
                    let mut end_i = i;
                    let mut end_j = j;

                    while let Some((x, y)) = queue.pop_front() {
                        end_i = end_i.max(x);
                        end_j = end_j.max(y);

                        for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                            let nx = x as i32 + dx;
                            let ny = y as i32 + dy;
                            if nx >= 0 && ny >= 0 && nx < m as i32 && ny < n as i32 {
                                let nx = nx as usize;
                                let ny = ny as usize;
                                if land[nx][ny] == 1 && !visited[nx][ny] {
                                    visited[nx][ny] = true;
                                    queue.push_back((nx, ny));
                                }
                            }
                        }
                    }

                    result.push(vec![i as i32, j as i32, end_i as i32, end_j as i32]);
                }
            }
        }

        result
    }
}
}