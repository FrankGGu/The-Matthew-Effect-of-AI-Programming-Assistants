impl Solution {

use std::collections::VecDeque;

struct Cashier {
    n: i32,
    discount: i32,
    customers: VecDeque<i32>,
    count: i32,
}

impl Cashier {
    fn new(n: i32, discount: i32) -> Self {
        Cashier {
            n,
            discount,
            customers: VecDeque::new(),
            count: 0,
        }
    }

    fn get_end_user_price(&self, price: i32) -> i32 {
        price
    }

    fn get_queue_size(&self) -> i32 {
        self.customers.len() as i32
    }

    fn add_customer(&mut self, customer: i32) {
        self.customers.push_back(customer);
    }

    fn apply_discount(&mut self) {
        if self.count % self.n == 0 {
            for c in &mut self.customers {
                *c = (*c * (100 - self.discount)) / 100;
            }
        }
        self.count += 1;
    }

    fn get_next_customer(&mut self) -> Option<i32> {
        self.customers.pop_front()
    }
}
}