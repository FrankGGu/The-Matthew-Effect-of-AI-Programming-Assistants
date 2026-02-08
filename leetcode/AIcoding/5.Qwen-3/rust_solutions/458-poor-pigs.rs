struct Solution;

impl Solution {
    pub fn poor_pigs(mut total_floors: i32, mut time_limit: i32) -> i32 {
        if total_floors == 1 {
            return 0;
        }
        let mut pigs = 0;
        while true {
            pigs += 1;
            let mut tests = 1;
            for _ in 0..pigs {
                tests *= (time_limit + 1);
                if tests > total_floors {
                    break;
                }
            }
            if tests >= total_floors {
                return pigs;
            }
        }
    }
}