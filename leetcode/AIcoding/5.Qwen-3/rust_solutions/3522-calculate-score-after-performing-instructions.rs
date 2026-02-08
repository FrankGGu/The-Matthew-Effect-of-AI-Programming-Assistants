struct Solution;

impl Solution {
    pub fn calculate_score(instructions: String) -> i32 {
        let mut score = 0;
        let mut power = 1;
        for c in instructions.chars() {
            match c {
                'A' => score += 1,
                'B' => score += 2 * power,
                'C' => power *= 2,
                _ => {}
            }
        }
        score
    }
}