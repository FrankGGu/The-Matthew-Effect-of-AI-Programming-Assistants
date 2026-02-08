impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_lexicographically_largest_string(box_: Vec<Vec<char>>) -> String {
        let mut queue = VecDeque::new();
        for i in 0..box_.len() {
            queue.push_back((i, 0, String::new()));
        }

        let mut result = String::new();

        while let Some((row, col, mut current)) = queue.pop_front() {
            if row >= box_.len() || col >= box_[row].len() {
                continue;
            }

            current.push(box_[row][col]);

            if row == box_.len() - 1 && col == box_[row].len() - 1 {
                if current > result {
                    result = current;
                }
                continue;
            }

            queue.push_back((row + 1, col, current.clone()));
            queue.push_back((row, col + 1, current));
        }

        result
    }
}
}