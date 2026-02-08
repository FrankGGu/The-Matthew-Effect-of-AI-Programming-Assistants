impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_word_length_product(words: Vec<String>) -> i32 {
        let mut word_map = HashMap::new();
        for (i, word) in words.iter().enumerate() {
            let mask = get_bitmask(word);
            word_map.insert(i, mask);
        }

        let mut max_prod = 0;
        for i in 0..words.len() {
            for j in i + 1..words.len() {
                if word_map[&i] & word_map[&j] == 0 {
                    let prod = words[i].len() as i32 * words[j].len() as i32;
                    if prod > max_prod {
                        max_prod = prod;
                    }
                }
            }
        }

        max_prod
    }
}

fn get_bitmask(word: &str) -> u32 {
    let mut mask = 0;
    for c in word.chars() {
        let bit = 1 << (c as u8 - b'a');
        mask |= bit;
    }
    mask
}
}