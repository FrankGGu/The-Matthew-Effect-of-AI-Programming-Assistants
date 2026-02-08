impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
        let num_courses = num_courses as usize;
        let mut adj = vec![vec![]; num_courses];
        let mut in_degree = vec![0; num_courses];

        for pre in prerequisites {
            let course = pre[0] as usize;
            let prerequisite = pre[1] as usize;
            adj[prerequisite].push(course);
            in_degree[course] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut result = Vec::with_capacity(num_courses);

        while let Some(course) = queue.pop_front() {
            result.push(course as i32);
            for &next in &adj[course] {
                in_degree[next] -= 1;
                if in_degree[next] == 0 {
                    queue.push_back(next);
                }
            }
        }

        if result.len() == num_courses {
            result
        } else {
            vec![]
        }
    }
}
}