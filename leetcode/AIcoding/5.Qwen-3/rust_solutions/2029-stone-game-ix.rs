struct Solution;

impl Solution {
    pub fn stone_game_ii(x: i32) -> i32 {
        let mut count = vec![0; 3];
        for i in 0..x {
            count[(i % 3) as usize] += 1;
        }

        if count[0] == 0 {
            return 0;
        }

        let a = count[1];
        let b = count[2];

        if a == b {
            return 0;
        }

        if a > b {
            return if a - b > 1 { 1 } else { 0 };
        } else {
            return if b - a > 1 { 2 } else { 0 };
        }
    }
}