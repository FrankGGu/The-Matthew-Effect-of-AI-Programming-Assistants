struct Solution {}

impl Solution {
    pub fn furthest_distance_from_origin(move_str: String) -> i32 {
        let mut x = 0;
        let mut y = 0;
        let mut unknown = 0;

        for c in move_str.chars() {
            match c {
                'L' => x -= 1,
                'R' => x += 1,
                'U' => y += 1,
                'D' => y -= 1,
                _ => unknown += 1,
            }
        }

        (x.abs() + y.abs() + unknown).max(x.abs() + y.abs())
    }
}