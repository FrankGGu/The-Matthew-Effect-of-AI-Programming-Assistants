impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_ladders(
        begin_word: String,
        end_word: String,
        word_list: Vec<String>,
    ) -> Vec<Vec<String>> {
        let word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return vec![];
        }

        let mut result = vec![];
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((begin_word.clone(), vec![begin_word]));

        let mut found = false;

        while let Some((current, path)) = queue.pop_front() {
            if current == end_word {
                result.push(path);
                found = true;
                continue;
            }

            if found && path.len() > 1 {
                continue;
            }

            for i in 0..current.len() {
                for c in 'a' as u8..='z' as u8 {
                    let mut next_word = current.clone();
                    next_word.as_bytes_mut()[i] = c;
                    let next_word_str = String::from_utf8(next_word).unwrap();

                    if word_set.contains(&next_word_str) && !visited.contains(&next_word_str) {
                        let mut new_path = path.clone();
                        new_path.push(next_word_str.clone());
                        queue.push_back((next_word_str, new_path));
                    }
                }
            }

            visited.insert(current);
        }

        result
    }
}
}