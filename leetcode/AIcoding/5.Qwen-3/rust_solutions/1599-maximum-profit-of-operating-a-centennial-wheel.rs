struct Solution;

impl Solution {
    pub fn max_profit(ride_cost: i32, money: i32, passengers: i32, tickets: i32) -> i32 {
        let mut total_money = money;
        let mut profit = 0;
        let mut passengers_left = passengers;
        let mut tickets_left = tickets;

        while passengers_left > 0 && tickets_left > 0 {
            if total_money >= ride_cost {
                total_money -= ride_cost;
                profit += ride_cost;
                passengers_left -= 1;
                tickets_left -= 1;
            } else {
                break;
            }
        }

        profit
    }
}