impl Solution {

use std::collections::{BinaryHeap, HashMap};
use std::cmp::Reverse;

struct Task {
    id: i32,
    priority: i32,
    timestamp: i32,
}

impl PartialEq for Task {
    fn eq(&self, other: &Self) -> bool {
        self.id == other.id
    }
}

impl Eq for Task {}

impl PartialOrd for Task {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Task {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.priority.cmp(&self.priority).then_with(|| self.timestamp.cmp(&other.timestamp))
    }
}

struct TaskManager {
    tasks: HashMap<i32, Task>,
    available_tasks: BinaryHeap<Reverse<Task>>,
    next_id: i32,
}

impl TaskManager {
    fn new() -> Self {
        TaskManager {
            tasks: HashMap::new(),
            available_tasks: BinaryHeap::new(),
            next_id: 0,
        }
    }

    fn add_task(&mut self, priority: i32) {
        let task = Task {
            id: self.next_id,
            priority,
            timestamp: self.next_id,
        };
        self.tasks.insert(task.id, task.clone());
        self.available_tasks.push(Reverse(task));
        self.next_id += 1;
    }

    fn get_next(&mut self) -> i32 {
        if let Some(Reverse(task)) = self.available_tasks.pop() {
            self.tasks.remove(&task.id);
            task.id
        } else {
            -1
        }
    }

    fn finish_task(&mut self, task_id: i32) {
        self.tasks.remove(&task_id);
    }
}
}