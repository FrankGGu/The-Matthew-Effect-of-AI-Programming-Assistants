impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn snakes_and_ladders(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((1, 0));
        visited.insert(1);

        while let Some((current, steps)) = queue.pop_front() {
            if current == n * n {
                return steps;
            }

            for i in 1..=6 {
                let next = current + i;
                if next > n * n {
                    break;
                }

                let (r, c) = get_position(next, n);
                let value = board[r][c];

                let next_pos = if value != -1 { value } else { next as i32 };

                if !visited.contains(&next_pos as &i32) {
                    visited.insert(next_pos as i32);
                    queue.push_back((next_pos as i32, steps + 1));
                }
            }
        }

        -1
    }
}

fn get_position(num: i32, n: usize) -> (usize, usize) {
    let num = num - 1;
    let r = n - 1 - (num / n as i32) as usize;
    let c = if (num / n as i32) % 2 == 0 {
        num % n as i32
    } else {
        n as i32 - 1 - num % n as i32
    };
    (r, c as usize)
}
}