impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn first_day_visited_all_rooms(rooms: Vec<Vec<i32>>) -> i32 {
        let n = rooms.len();
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited[0] = true;
        let mut days = 0;

        while !queue.is_empty() {
            for _ in 0..queue.len() {
                if let Some(current) = queue.pop_front() {
                    for &next in &rooms[current] {
                        if !visited[next as usize] {
                            visited[next as usize] = true;
                            queue.push_back(next as usize);
                        }
                    }
                }
            }
            days += 1;
        }

        days
    }
}
}