struct Solution;

impl Solution {
    pub fn min_time_to_type(word: String) -> i32 {
        let mut time = 0;
        let mut current = 'a' as u8;

        for c in word.chars() {
            let target = c as u8;
            let diff = (target - current).abs();
            time += std::cmp::min(diff, 26 - diff);
            current = target;
        }

        time
    }
}