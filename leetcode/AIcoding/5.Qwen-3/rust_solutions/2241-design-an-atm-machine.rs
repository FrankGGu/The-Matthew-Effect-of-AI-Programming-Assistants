struct ATM {
    denominations: Vec<i32>,
    balances: Vec<i64>,
}

impl ATM {
    fn new(banknotes_count: Vec<i32>) -> Self {
        let denominations = vec![20, 50, 100, 200, 500];
        let mut balances = vec![0; 5];
        for i in 0..banknotes_count.len() {
            balances[i] = banknotes_count[i] as i64;
        }
        ATM {
            denominations,
            balances,
        }
    }

    fn withdraw_money(&mut self, amount: i32) -> Vec<i32> {
        let mut result = vec![0; 5];
        let mut remaining = amount;
        for i in (0..5).rev() {
            let count = (remaining / self.denominations[i]) as i32;
            if count > 0 && self.balances[i] >= count as i64 {
                result[i] = count;
                remaining -= count * self.denominations[i];
                self.balances[i] -= count as i64;
            }
        }
        if remaining == 0 {
            result
        } else {
            vec![0; 5]
        }
    }

    fn deposit_money(&mut self, banknotes_count: Vec<i32>) {
        for i in 0..banknotes_count.len() {
            self.balances[i] += banknotes_count[i] as i64;
        }
    }
}

use std::collections::HashMap;

fn main() {
    let mut atm = ATM::new(vec![0, 0, 0, 0, 0]);
    atm.deposit_money(vec![0, 0, 1, 0, 0]);
    let result = atm.withdraw_money(500);
}