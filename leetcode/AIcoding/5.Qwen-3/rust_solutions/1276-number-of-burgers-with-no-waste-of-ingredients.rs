struct Solution {}

impl Solution {
    pub fn number_of_burgers(mut main: i32, mut tomato: i32) -> Vec<i32> {
        let mut result = vec![];
        let mut x = 0;
        let mut y = 0;
        while x <= main {
            if (tomato - 2 * x) % 1 == 0 && (main - x) >= 0 {
                y = (tomato - 2 * x) / 1;
                if y == main - x {
                    result.push(x);
                    result.push(y);
                    return result;
                }
            }
            x += 1;
        }
        result
    }
}