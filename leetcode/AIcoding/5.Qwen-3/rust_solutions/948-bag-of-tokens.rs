impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn bag_of_tokens(score: i32, token: Vec<i32>) -> i32 {
        let mut tokens = token;
        tokens.sort();
        let mut token_deque = VecDeque::new();
        for t in tokens {
            token_deque.push_back(t);
        }

        let mut max_score = 0;
        let mut current_score = score;
        let mut total = 0;

        while let (Some(front), Some(back)) = (token_deque.front(), token_deque.back()) {
            if current_score >= *front {
                current_score -= *front;
                token_deque.pop_front();
                total += 1;
                max_score = max_score.max(total);
            } else if total > 0 && current_score < *back {
                current_score += *back;
                token_deque.pop_back();
                total -= 1;
            } else {
                break;
            }
        }

        max_score
    }
}
}