impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn to_goat_latin(sentence: String) -> String {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut map = HashMap::new();
        for &v in &vowels {
            map.insert(v, true);
        }

        let words: Vec<&str> = sentence.split_whitespace().collect();
        let mut result = String::new();

        for (i, &word) in words.iter().enumerate() {
            let first_char = word.chars().next().unwrap();
            let is_vowel = map.get(&first_char.to_ascii_lowercase()).unwrap_or(&false);

            if *is_vowel {
                result.push_str(word);
            } else {
                result.push_str(&word[1..]);
                result.push(first_char);
            }

            result.push_str("ma");

            for _ in 0..(i + 1) {
                result.push('a');
            }

            if i != words.len() - 1 {
                result.push(' ');
            }
        }

        result
    }
}
}