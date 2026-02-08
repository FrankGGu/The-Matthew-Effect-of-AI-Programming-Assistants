impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn predict_ban_turns(senate: String) -> String {
        let mut radiant = VecDeque::new();
        let mut dire = VecDeque::new();

        for (i, c) in senate.chars().enumerate() {
            if c == 'R' {
                radiant.push_back(i);
            } else {
                dire.push_back(i);
            }
        }

        while !radiant.is_empty() && !dire.is_empty() {
            let r = radiant.front().unwrap();
            let d = dire.front().unwrap();

            if r < d {
                radiant.pop_front();
                radiant.push_back(*r);
            } else {
                dire.pop_front();
                dire.push_back(*d);
            }
        }

        if radiant.is_empty() {
            "Dire".to_string()
        } else {
            "Radiant".to_string()
        }
    }
}
}