struct Solution;

impl Solution {
    pub fn get_guessed_numbers(secret: String, guess: String) -> String {
        let mut bulls = 0;
        let mut cows = 0;
        let mut secret_counts = std::collections::HashMap::new();
        let mut guess_counts = std::collections::HashMap::new();

        for (s, g) in secret.chars().zip(guess.chars()) {
            if s == g {
                bulls += 1;
            } else {
                *secret_counts.entry(s).or_insert(0) += 1;
                *guess_counts.entry(g).or_insert(0) += 1;
            }
        }

        for (c, count) in &guess_counts {
            if let Some(&s_count) = secret_counts.get(c) {
                cows += std::cmp::min(*count, s_count);
            }
        }

        format!("{}A{}B", bulls, cows)
    }
}