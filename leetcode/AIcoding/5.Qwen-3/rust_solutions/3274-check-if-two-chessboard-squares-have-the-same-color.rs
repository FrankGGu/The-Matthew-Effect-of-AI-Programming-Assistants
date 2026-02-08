struct Solution;

impl Solution {
    pub fn to_square_coordinates(square: &str) -> (i32, i32) {
        let col = square.chars().next().unwrap() as i32 - 'a' as i32;
        let row = square.chars().nth(1).unwrap() as i32 - '1' as i32;
        (col, row)
    }

    pub fn square_is_white(col: i32, row: i32) -> bool {
        (col + row) % 2 == 1
    }

    pub fn is_same_color(have: &str, need: &str) -> bool {
        let (col1, row1) = Self::to_square_coordinates(have);
        let (col2, row2) = Self::to_square_coordinates(need);
        Self::square_is_white(col1, row1) == Self::square_is_white(col2, row2)
    }
}