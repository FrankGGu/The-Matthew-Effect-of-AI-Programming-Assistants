impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_visit_all_rooms(rooms: Vec<Vec<i32>>) -> bool {
        let mut visited = HashSet::new();
        let mut stack = vec![0];

        while let Some(room) = stack.pop() {
            if visited.contains(&room) {
                continue;
            }
            visited.insert(room);
            for &key in &rooms[room] {
                stack.push(key as usize);
            }
        }

        visited.len() == rooms.len()
    }
}
}