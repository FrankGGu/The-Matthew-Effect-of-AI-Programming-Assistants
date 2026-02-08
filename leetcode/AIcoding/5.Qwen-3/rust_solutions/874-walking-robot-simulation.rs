impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn robot_sim(mut commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> Vec<i32> {
        let mut x = 0;
        let mut y = 0;
        let mut max_distance = 0;
        let mut direction = 0; // 0: north, 1: east, 2: south, 3: west
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        let obstacle_set: HashSet<(i32, i32)> = obstacles.into_iter().map(|o| (o[0], o[1])).collect();

        for command in commands {
            if command == -1 {
                direction = (direction + 1) % 4;
            } else if command == -2 {
                direction = (direction + 3) % 4;
            } else {
                let (dx, dy) = directions[direction];
                for _ in 0..command {
                    let next_x = x + dx;
                    let next_y = y + dy;
                    if obstacle_set.contains(&(next_x, next_y)) {
                        break;
                    }
                    x = next_x;
                    y = next_y;
                    max_distance = max_distance.max(x * x + y * y);
                }
            }
        }

        vec![x, y]
    }
}
}