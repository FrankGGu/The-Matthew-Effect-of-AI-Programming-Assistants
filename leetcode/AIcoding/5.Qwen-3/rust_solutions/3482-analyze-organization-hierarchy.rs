impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct Employee {
    pub id: i32,
    pub name: String,
    pub reports: Vec<i32>,
}

pub fn get_organization_hierarchy(employees: Vec<Employee>) -> Vec<Vec<String>> {
    let mut employee_map = HashMap::new();
    for emp in &employees {
        employee_map.insert(emp.id, emp);
    }

    let mut result = Vec::new();
    let mut queue = VecDeque::new();

    for emp in &employees {
        if emp.reports.is_empty() {
            queue.push_back(emp.id);
        }
    }

    while let Some(id) = queue.pop_front() {
        let mut level = Vec::new();
        let mut stack = vec![id];

        while let Some(current_id) = stack.pop() {
            if let Some(emp) = employee_map.get(&current_id) {
                level.push(emp.name.clone());
                for &report in &emp.reports {
                    stack.push(report);
                }
            }
        }

        if !level.is_empty() {
            result.push(level);
        }
    }

    result
}
}