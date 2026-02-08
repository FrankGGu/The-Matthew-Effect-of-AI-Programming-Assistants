impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, Clone, PartialEq, Eq)]
struct Employee {
    id: i32,
    importance: i32,
    subordinates: Vec<i32>,
}

impl Employee {
    fn new(id: i32, importance: i32, subordinates: Vec<i32>) -> Self {
        Employee {
            id,
            importance,
            subordinates,
        }
    }
}

fn main() {}

fn get_importance(employees: Vec<Employee>, id: i32) -> i32 {
    let mut employee_map = HashMap::new();
    for emp in &employees {
        employee_map.insert(emp.id, emp);
    }

    let mut total = 0;
    let mut queue = VecDeque::new();
    queue.push_back(id);

    while let Some(current_id) = queue.pop_front() {
        if let Some(emp) = employee_map.get(&current_id) {
            total += emp.importance;
            for &sub_id in &emp.subordinates {
                queue.push_back(sub_id);
            }
        }
    }

    total
}
}