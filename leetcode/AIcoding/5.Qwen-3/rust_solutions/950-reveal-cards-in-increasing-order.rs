impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn reveal_cards_in_increasing_order(deck: Vec<i32>) -> Vec<i32> {
        let n = deck.len();
        let mut indices = VecDeque::new();
        for i in 0..n {
            indices.push_back(i);
        }

        let mut result = vec![0; n];
        let mut sorted_deck = deck.clone();
        sorted_deck.sort();

        while !indices.is_empty() {
            let idx = indices.pop_front().unwrap();
            result[idx] = sorted_deck[0];
            sorted_deck.remove(0);
            if !indices.is_empty() {
                let front = indices.pop_front().unwrap();
                indices.push_back(front);
            }
        }

        result
    }
}
}