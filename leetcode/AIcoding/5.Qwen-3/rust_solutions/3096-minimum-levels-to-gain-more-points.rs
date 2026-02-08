impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_levels_to_gain_more_points(s: String) -> i32 {
        let mut points = 0;
        let mut levels = 0;
        let mut queue = VecDeque::new();

        for c in s.chars() {
            match c {
                'L' => {
                    points -= 1;
                    levels += 1;
                    queue.push_back(1);
                },
                'R' => {
                    points += 1;
                    levels += 1;
                    queue.push_back(-1);
                },
                _ => {}
            }

            while points < 0 {
                if let Some(val) = queue.pop_front() {
                    points -= val;
                    levels -= 1;
                } else {
                    break;
                }
            }
        }

        levels
    }
}
}