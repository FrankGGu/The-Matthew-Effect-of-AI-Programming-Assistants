struct Solution;

impl Solution {
    pub fn num_water_bottles(mut full: i32, mut empty: i32) -> i32 {
        let mut total = 0;
        while full > 0 {
            total += full;
            empty += full;
            full = empty / 3;
            empty = empty % 3;
        }
        total
    }
}