struct Solution;

impl Solution {
    pub fn mirror_score(s: String) -> i32 {
        let mut score = 0;
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n / 2 {
            if chars[i] == chars[n - 1 - i] {
                score += 1;
            }
        }

        score
    }
}