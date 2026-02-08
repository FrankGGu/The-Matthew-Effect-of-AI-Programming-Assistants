impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_robot_bounded(instructions: String) -> bool {
        let mut x = 0;
        let mut y = 0;
        let mut dir = 0; // 0: north, 1: east, 2: south, 3: west
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for c in instructions.chars() {
            match c {
                'L' => dir = (dir + 3) % 4,
                'R' => dir = (dir + 1) % 4,
                'G' => {
                    x += directions[dir].0;
                    y += directions[dir].1;
                },
                _ => {}
            }
        }

        if (x == 0 && y == 0) || dir != 0 {
            true
        } else {
            false
        }
    }
}
}