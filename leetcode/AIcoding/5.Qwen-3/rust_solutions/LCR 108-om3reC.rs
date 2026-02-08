impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn ladder_length(
        begin_word: String,
        end_word: String,
        word_list: Vec<String>,
    ) -> i32 {
        let word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return 0;
        }

        let mut queue = VecDeque::new();
        queue.push_back((begin_word, 1));

        let mut visited = HashSet::new();
        visited.insert(begin_word);

        while let Some((current, steps)) = queue.pop_front() {
            for i in 0..current.len() {
                for c in b'a'..=b'z' {
                    let mut next_word = current.clone();
                    next_word.as_bytes_mut()[i] = c;
                    let next_word_str = next_word.clone();

                    if next_word_str == end_word {
                        return steps + 1;
                    }

                    if word_set.contains(&next_word_str) && !visited.contains(&next_word_str) {
                        visited.insert(next_word_str.clone());
                        queue.push_back((next_word_str, steps + 1));
                    }
                }
            }
        }

        0
    }
}
}