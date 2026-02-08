impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn divide_players_into_teams(mut skill: Vec<i32>) -> i64 {
        skill.sort();
        let n = skill.len();
        let target = skill[0] + skill[n - 1];
        let mut total = 0;
        for i in 0..n / 2 {
            if skill[i] + skill[n - 1 - i] != target {
                return -1;
            }
            total += (skill[i] as i64) * (skill[n - 1 - i] as i64);
        }
        total
    }
}
}