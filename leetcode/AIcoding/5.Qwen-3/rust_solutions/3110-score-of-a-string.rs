struct Solution;

impl Solution {
    pub fn score_string(s: String) -> i32 {
        let mut score = 0;
        for i in 0..s.len() - 1 {
            let c1 = s.as_bytes()[i] as i32;
            let c2 = s.as_bytes()[i + 1] as i32;
            score += (c1 - c2).abs();
        }
        score
    }
}