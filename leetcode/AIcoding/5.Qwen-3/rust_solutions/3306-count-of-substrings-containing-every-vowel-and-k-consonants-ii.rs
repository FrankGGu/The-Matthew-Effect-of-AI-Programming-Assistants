impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_of_substrings(s: String, k: i32) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut count = 0;
        let s: Vec<char> = s.chars().collect();
        let n = s.len();

        for i in 0..n {
            let mut vowel_count = HashMap::new();
            let mut consonant_count = 0;

            for j in i..n {
                if vowels.contains(&s[j]) {
                    *vowel_count.entry(s[j]).or_insert(0) += 1;
                } else {
                    consonant_count += 1;
                }

                if consonant_count == k as usize && vowel_count.len() == 5 {
                    count += 1;
                }
            }
        }

        count as i32
    }
}
}