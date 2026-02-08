struct Solution;

impl Solution {
    pub fn count_valid_words(s: String) -> i32 {
        let words: Vec<&str> = s.split_whitespace().collect();
        let mut count = 0;

        for word in words {
            if is_valid(word) {
                count += 1;
            }
        }

        count
    }

    fn is_valid(word: &str) -> bool {
        let mut has_hyphen = false;
        let mut hyphen_index = -1;

        for (i, c) in word.chars().enumerate() {
            match c {
                'a'..='z' => continue,
                '-' => {
                    if has_hyphen || i == 0 || i == word.len() - 1 {
                        return false;
                    }
                    has_hyphen = true;
                    hyphen_index = i as i32;
                },
                _ => return false,
            }
        }

        if has_hyphen {
            let before = word[..hyphen_index as usize].chars().last();
            let after = word[(hyphen_index + 1) as usize..].chars().next();

            if before.is_none() || after.is_none() {
                return false;
            }

            match (before.unwrap(), after.unwrap()) {
                ('a'..='z', 'a'..='z') => true,
                _ => false,
            }
        } else {
            true
        }
    }
}