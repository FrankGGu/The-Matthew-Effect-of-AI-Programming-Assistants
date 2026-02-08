impl Solution {

use std::cmp;

impl Solution {
    pub fn distribute_money(money: i32, children: i32) -> i32 {
        if money < children {
            return 0;
        }
        if children == 1 {
            return money;
        }
        let mut remaining = money - children;
        let mut result = children;
        while remaining > 0 {
            let give = cmp::min(remaining, 9);
            remaining -= give;
            result -= 1;
            if remaining > 0 {
                result -= 1;
                remaining -= 1;
            }
        }
        result
    }
}
}