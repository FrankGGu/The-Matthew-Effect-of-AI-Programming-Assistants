struct Solution;

impl Solution {
    pub fn min_hours_to_win(energy: i32, experience: i32) -> i32 {
        let mut hours = 0;
        let mut current_exp = 0;

        for e in energy {
            if current_exp >= e {
                current_exp -= e;
            } else {
                hours += e - current_exp;
                current_exp = 0;
            }
        }

        if experience > current_exp {
            hours += experience - current_exp;
        }

        hours
    }
}