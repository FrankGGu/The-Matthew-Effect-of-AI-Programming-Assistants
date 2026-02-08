struct Solution;

impl Solution {
    pub fn is_vowel(c: char) -> bool {
        matches!(c.to_ascii_lowercase(), 'a' | 'e' | 'i' | 'o' | 'u')
    }

    pub fn does_player_a_win(s: String) -> bool {
        let mut a_count = 0;
        let mut b_count = 0;

        for c in s.chars() {
            if Self::is_vowel(c) {
                a_count += 1;
            } else {
                b_count += 1;
            }
        }

        a_count > b_count
    }
}