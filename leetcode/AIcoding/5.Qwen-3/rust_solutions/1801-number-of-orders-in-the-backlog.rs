impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution {}

impl Solution {
    pub fn number_of_orders_in_the_backlog(orders: Vec<Vec<i32>>) -> i32 {
        let mut buy_heap = BinaryHeap::new();
        let mut sell_heap = BinaryHeap::new();

        for order in orders {
            let price = order[0];
            let amount = order[1];
            let side = order[2];

            if side == 0 {
                // Buy order
                while amount > 0 && !sell_heap.is_empty() && sell_heap.peek().unwrap().0 <= price {
                    let mut sell = sell_heap.pop().unwrap();
                    if sell.1 > amount {
                        sell.1 -= amount;
                        amount = 0;
                        sell_heap.push(sell);
                        break;
                    } else {
                        amount -= sell.1;
                    }
                }
                if amount > 0 {
                    buy_heap.push(Reverse((price, amount)));
                }
            } else {
                // Sell order
                while amount > 0 && !buy_heap.is_empty() && buy_heap.peek().unwrap().0 >= price {
                    let mut buy = buy_heap.pop().unwrap();
                    if buy.1 > amount {
                        buy.1 -= amount;
                        amount = 0;
                        buy_heap.push(buy);
                        break;
                    } else {
                        amount -= buy.1;
                    }
                }
                if amount > 0 {
                    sell_heap.push(Reverse((price, amount)));
                }
            }
        }

        let mut total = 0;
        while let Some(Reverse((_, amount))) = buy_heap.pop() {
            total += amount;
        }
        while let Some(Reverse((_, amount))) = sell_heap.pop() {
            total += amount;
        }

        total
    }
}
}