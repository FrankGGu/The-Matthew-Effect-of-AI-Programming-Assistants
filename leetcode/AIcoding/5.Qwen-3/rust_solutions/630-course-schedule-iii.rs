impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn schedule_course(mut courses: Vec<Vec<i32>>) -> i32 {
        courses.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut heap = BinaryHeap::new();
        let mut time = 0;

        for course in courses {
            let duration = course[0];
            let end_time = course[1];

            if time + duration <= end_time {
                heap.push(duration);
                time += duration;
            } else if let Some(&max_duration) = heap.peek() {
                if duration < max_duration {
                    time = time - max_duration + duration;
                    heap.pop();
                    heap.push(duration);
                }
            }
        }

        heap.len() as i32
    }
}
}