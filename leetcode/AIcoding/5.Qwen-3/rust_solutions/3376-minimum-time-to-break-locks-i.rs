impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_time_to_break_locks(locks: Vec<Vec<char>>, key: char) -> i32 {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        let rows = locks.len();
        let cols = locks[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if locks[i][j] == key {
                    visited.insert((i, j));
                    queue.push_back((i, j, 0));
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j, time)) = queue.pop_front() {
            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited.contains(&(ni, nj)) && locks[ni][nj] != '#' {
                        if locks[ni][nj] == key {
                            return time + 1;
                        }
                        visited.insert((ni, nj));
                        queue.push_back((ni, nj, time + 1));
                    }
                }
            }
        }

        -1
    }
}
}