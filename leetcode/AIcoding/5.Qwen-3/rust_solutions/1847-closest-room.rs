impl Solution {

use std::collections::{BinaryHeap, HashMap};

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Room {
    id: i32,
    size: i32,
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Request {
    id: i32,
    x: i32,
    y: i32,
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Candidate {
    room_id: i32,
    distance: i32,
}

impl Ord for Candidate {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        match other.distance.cmp(&self.distance) {
            std::cmp::Ordering::Equal => other.room_id.cmp(&self.room_id),
            ord => ord,
        }
    }
}

impl PartialOrd for Candidate {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn closest_room(rooms: Vec<Vec<i32>>, requests: Vec<Vec<i32>>) -> Vec<i32> {
        let mut rooms = rooms
            .into_iter()
            .map(|room| Room {
                id: room[0],
                size: room[1],
            })
            .collect::<Vec<_>>();
        rooms.sort_by_key(|r| r.size);
        let mut requests = requests
            .into_iter()
            .enumerate()
            .map(|(i, req)| Request {
                id: i as i32,
                x: req[0],
                y: req[1],
            })
            .collect::<Vec<_>>();
        requests.sort_by_key(|r| r.id);
        let mut result = vec![0; requests.len()];
        let mut heap = BinaryHeap::new();
        let mut room_idx = 0;
        for request in requests {
            while room_idx < rooms.len() && rooms[room_idx].size >= request.x {
                let room = rooms[room_idx];
                let distance = (room.x - request.x).abs() + (room.y - request.y).abs();
                heap.push(Candidate {
                    room_id: room.id,
                    distance,
                });
                room_idx += 1;
            }
            if let Some(candidate) = heap.pop() {
                result[request.id as usize] = candidate.room_id;
            } else {
                result[request.id as usize] = -1;
            }
        }
        result
    }
}
}