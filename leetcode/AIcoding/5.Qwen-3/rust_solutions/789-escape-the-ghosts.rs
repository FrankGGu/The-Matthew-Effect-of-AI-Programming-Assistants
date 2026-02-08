impl Solution {

use std::cmp;

impl Solution {
    pub fn escape_ghosts(ghosts: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
        let mut player_steps = (target[0].abs() + target[1].abs()) as i32;
        for ghost in ghosts {
            let steps = (ghost[0].abs() + ghost[1].abs()) as i32;
            if steps < player_steps {
                return false;
            }
        }
        true
    }
}
}