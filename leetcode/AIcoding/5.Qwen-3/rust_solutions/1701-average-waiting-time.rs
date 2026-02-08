impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn average_waiting_time(orders: Vec<Vec<i32>>) -> f64 {
        let mut queue = VecDeque::new();
        for order in orders {
            queue.push_back(order);
        }

        let mut current_time = 0;
        let mut total_wait = 0;

        while let Some(order) = queue.pop_front() {
            let (delivery_time, cook_time) = (order[0], order[1]);
            if delivery_time > current_time {
                current_time = delivery_time;
            }
            current_time += cook_time;
            total_wait += current_time - delivery_time;
        }

        total_wait as f64 / orders.len() as f64
    }
}
}