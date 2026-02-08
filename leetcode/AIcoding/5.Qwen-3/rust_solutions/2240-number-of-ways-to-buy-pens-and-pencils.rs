impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn ways_to_buy_pens_pencils(cost_pen: i32, cost_pencil: i32, money: i32) -> i64 {
        let mut count = 0;
        let mut remaining = money;

        while remaining >= 0 {
            count += 1;
            remaining -= cost_pen;
        }

        let mut remaining = money;
        while remaining >= 0 {
            count += 1;
            remaining -= cost_pencil;
        }

        count
    }
}
}