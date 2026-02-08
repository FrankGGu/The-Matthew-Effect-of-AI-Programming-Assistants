impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn most_frequent_vowel_and_consonant(s: String) -> (char, char) {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut vowel_counts = HashMap::new();
        let mut consonant_counts = HashMap::new();

        for c in s.chars() {
            if c.is_ascii_lowercase() {
                if vowels.contains(&c) {
                    *vowel_counts.entry(c).or_insert(0) += 1;
                } else {
                    *consonant_counts.entry(c).or_insert(0) += 1;
                }
            }
        }

        let mut max_vowel_count = 0;
        let mut most_vowel = 'a';
        for (c, &count) in &vowel_counts {
            if count > max_vowel_count {
                max_vowel_count = count;
                most_vowel = *c;
            }
        }

        let mut max_consonant_count = 0;
        let mut most_consonant = 'b';
        for (c, &count) in &consonant_counts {
            if count > max_consonant_count {
                max_consonant_count = count;
                most_consonant = *c;
            }
        }

        (most_vowel, most_consonant)
    }
}
}