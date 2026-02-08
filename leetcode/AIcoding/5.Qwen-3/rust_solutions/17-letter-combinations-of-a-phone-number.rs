impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn letter_combinations(digits: String) -> Vec<String> {
        if digits.is_empty() {
            return vec![];
        }

        let mut map = HashMap::new();
        map.insert('2', "abc");
        map.insert('3', "def");
        map.insert('4', "ghi");
        map.insert('5', "jkl");
        map.insert('6', "mno");
        map.insert('7', "pqrs");
        map.insert('8', "tuv");
        map.insert('9', "wxyz");

        let mut result = vec![String::new()];
        for c in digits.chars() {
            let letters = map.get(&c).unwrap();
            let mut temp = vec![];
            for s in &result {
                for ch in letters.chars() {
                    let mut new_s = s.clone();
                    new_s.push(ch);
                    temp.push(new_s);
                }
            }
            result = temp;
        }

        result
    }
}

pub struct Solution;
}