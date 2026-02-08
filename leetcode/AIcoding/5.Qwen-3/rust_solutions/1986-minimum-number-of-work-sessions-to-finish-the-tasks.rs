impl Solution {

use std::cmp::Ordering;
use std::collections::HashSet;

impl Solution {
    pub fn min_sessions(tasks: Vec<i32>, session_time: i32) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by(|a, b| b.cmp(a));
        let mut result = i32::MAX;
        let n = tasks.len();

        fn backtrack(
            idx: usize,
            sessions: &mut Vec<i32>,
            tasks: &[i32],
            session_time: i32,
            result: &mut i32,
        ) {
            if idx == tasks.len() {
                *result = result.min(sessions.len() as i32);
                return;
            }

            let mut used = HashSet::new();
            for i in 0..sessions.len() {
                if sessions[i] + tasks[idx] <= session_time && !used.contains(&sessions[i]) {
                    used.insert(sessions[i]);
                    sessions[i] += tasks[idx];
                    backtrack(idx + 1, sessions, tasks, session_time, result);
                    sessions[i] -= tasks[idx];
                }
            }

            if sessions.len() < *result as usize {
                sessions.push(tasks[idx]);
                backtrack(idx + 1, sessions, tasks, session_time, result);
                sessions.pop();
            }
        }

        backtrack(0, &mut vec![], &tasks, session_time, &mut result);
        result
    }
}
}