impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn is_valid_word(word: String, puzzle: String) -> bool {
        let word_chars: HashSet<char> = word.chars().collect();
        let puzzle_chars: HashSet<char> = puzzle.chars().collect();

        for c in word_chars {
            if !puzzle_chars.contains(&c) {
                return false;
            }
        }

        true
    }
}
}