impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_seconds(mountain: Vec<Vec<i32>>) -> i32 {
        let rows = mountain.len();
        let cols = mountain[0].len();
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        for i in 0..rows {
            for j in 0..cols {
                if mountain[i][j] == 0 {
                    queue.push_back((i, j));
                    visited.insert((i, j));
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut time = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (i, j) = queue.pop_front().unwrap();
                for &(di, dj) in &directions {
                    let ni = i as i32 + di;
                    let nj = j as i32 + dj;
                    if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                        let ni = ni as usize;
                        let nj = nj as usize;
                        if !visited.contains(&(ni, nj)) && mountain[ni][nj] > 0 {
                            visited.insert((ni, nj));
                            queue.push_back((ni, nj));
                        }
                    }
                }
            }
            if !queue.is_empty() {
                time += 1;
            }
        }

        time
    }
}
}