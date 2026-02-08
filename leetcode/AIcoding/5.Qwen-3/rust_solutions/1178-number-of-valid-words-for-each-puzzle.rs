impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_num_of_valid_words(mut words: Vec<String>, puzzles: Vec<String>) -> Vec<i32> {
        let mut freq = HashMap::new();
        for word in words {
            let mask = get_mask(&word);
            *freq.entry(mask).or_insert(0) += 1;
        }

        let mut result = vec![];
        for puzzle in puzzles {
            let mut count = 0;
            let p_mask = get_mask(&puzzle);
            let first_char = puzzle.chars().nth(0).unwrap() as u8;
            let mut sub_mask = p_mask;

            while sub_mask != 0 {
                let c = (sub_mask & -sub_mask) as u8;
                if c == first_char {
                    count += freq.get(&sub_mask).unwrap_or(&0);
                }
                sub_mask = sub_mask & (sub_mask - 1);
            }

            result.push(count);
        }

        result
    }
}

fn get_mask(word: &str) -> u64 {
    let mut mask = 0;
    for c in word.chars() {
        let bit = 1 << (c as u8 - b'a');
        mask |= bit;
    }
    mask
}
}