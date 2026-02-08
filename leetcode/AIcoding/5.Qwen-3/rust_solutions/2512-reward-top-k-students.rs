impl Solution {

use std::collections::{HashMap, BinaryHeap};

#[derive(Eq, PartialEq, Ord, PartialOrd, Clone, Copy)]
struct Student {
    score: i32,
    index: usize,
}

impl Solution {
    pub fn top_students(questions: Vec<&str>, students: Vec<&str>, rewards: i32) -> Vec<i32> {
        let mut scores = HashMap::new();
        for (i, &question) in questions.iter().enumerate() {
            let mut correct = 0;
            for (j, &student) in students.iter().enumerate() {
                if question.chars().nth(j) == Some(student.chars().nth(j)) {
                    correct += 1;
                }
            }
            scores.insert(i, correct);
        }

        let mut heap = BinaryHeap::new();
        for (&index, &score) in scores.iter() {
            heap.push(Student { score, index });
        }

        let mut result = Vec::new();
        for _ in 0..rewards {
            if let Some(Student { index, .. }) = heap.pop() {
                result.push(index as i32);
            }
        }

        result.sort();
        result
    }
}
}