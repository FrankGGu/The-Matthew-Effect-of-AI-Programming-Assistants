impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn maximum_safeness_factor(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }
        let mut dist = vec![vec![0; n]; n];
        let mut q = VecDeque::new();

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    q.push_back((i, j));
                }
            }
        }

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        while let Some((i, j)) = q.pop_front() {
            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if dist[ni][nj] == 0 && grid[ni][nj] == 0 {
                        dist[ni][nj] = dist[i][j] + 1;
                        q.push_back((ni, nj));
                    }
                }
            }
        }

        let mut left = 0;
        let mut right = n as i32;
        let mut answer = 0;

        while left <= right {
            let mid = (left + right) / 2;
            if Self::is_possible(&dist, mid) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }

    fn is_possible(dist: &Vec<Vec<i32>>, k: i32) -> bool {
        let n = dist.len();
        if dist[0][0] < k || dist[n-1][n-1] < k {
            return false;
        }

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut visited = HashSet::new();
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        visited.insert((0, 0));

        while let Some((i, j)) = q.pop_front() {
            if i == n - 1 && j == n - 1 {
                return true;
            }
            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited.contains(&(ni, nj)) && dist[ni][nj] >= k {
                        visited.insert((ni, nj));
                        q.push_back((ni, nj));
                    }
                }
            }
        }

        false
    }
}
}