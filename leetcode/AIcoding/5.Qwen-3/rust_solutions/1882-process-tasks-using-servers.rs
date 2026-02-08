impl Solution {

use std::collections::{BinaryHeap, VecDeque};

#[derive(Eq, PartialEq, Clone, Copy, Debug)]
struct Server {
    id: i32,
    available_time: i32,
}

impl Ord for Server {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        match self.available_time.cmp(&other.available_time) {
            std::cmp::Ordering::Equal => self.id.cmp(&other.id),
            other => other,
        }
    }
}

impl PartialOrd for Server {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Server {
    fn new(id: i32, available_time: i32) -> Self {
        Server { id, available_time }
    }
}

fn main() {}

pub fn assign_tasks(servers: Vec<Vec<i32>>, tasks: Vec<i32>) -> Vec<i32> {
    let mut available_servers = BinaryHeap::new();
    for (i, server) in servers.iter().enumerate() {
        available_servers.push(Server::new(i as i32, 0));
    }

    let mut busy_servers = BinaryHeap::new();
    let mut result = Vec::with_capacity(tasks.len());
    let mut task_index = 0;

    while task_index < tasks.len() {
        while !busy_servers.is_empty() && busy_servers.peek().unwrap().available_time <= task_index as i32 {
            let server = busy_servers.pop().unwrap();
            available_servers.push(server);
        }

        while !available_servers.is_empty() && task_index < tasks.len() {
            let server = available_servers.pop().unwrap();
            result.push(server.id);
            let task_duration = tasks[task_index];
            let available_time = task_index as i32 + task_duration;
            busy_servers.push(Server::new(server.id, available_time));
            task_index += 1;
        }

        if task_index < tasks.len() && !available_servers.is_empty() {
            continue;
        }

        let next_available_time = busy_servers.peek().unwrap().available_time;
        while !available_servers.is_empty() && task_index < tasks.len() && task_index as i32 < next_available_time {
            let server = available_servers.pop().unwrap();
            result.push(server.id);
            let task_duration = tasks[task_index];
            let available_time = next_available_time + task_duration;
            busy_servers.push(Server::new(server.id, available_time));
            task_index += 1;
        }
    }

    result
}
}