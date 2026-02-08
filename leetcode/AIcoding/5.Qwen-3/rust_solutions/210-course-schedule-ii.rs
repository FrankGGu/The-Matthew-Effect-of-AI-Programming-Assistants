impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
        let num_courses = num_courses as usize;
        let mut graph: Vec<Vec<usize>> = vec![vec![]; num_courses];
        let mut in_degree: Vec<i32> = vec![0; num_courses];

        for prereq in prerequisites {
            let course = prereq[0] as usize;
            let prerequisite = prereq[1] as usize;
            graph[prerequisite].push(course);
            in_degree[course] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut result = Vec::new();

        while let Some(course) = queue.pop_front() {
            result.push(course as i32);
            for &next in &graph[course] {
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