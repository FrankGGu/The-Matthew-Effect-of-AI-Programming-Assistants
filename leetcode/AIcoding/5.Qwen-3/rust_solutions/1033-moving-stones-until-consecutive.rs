struct Solution;

impl Solution {
    pub fn num_moves_stones(a: i32, b: i32, c: i32) -> Vec<i32> {
        let mut stones = [a, b, c];
        stones.sort();
        let (x, y, z) = (stones[0], stones[1], stones[2]);

        let mut min = 0;
        if y - x > 1 && z - y > 1 {
            min = 2;
        } else if y - x == 1 && z - y == 1 {
            min = 0;
        } else {
            min = 1;
        }

        let max = (z - x - 2).max(0);

        vec![min, max]
    }
}