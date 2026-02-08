impl Solution {
    pub fn get_maximum_consecutive(mut coins: Vec<i32>) -> i32 {
        coins.sort();
        let mut max = 0;
        for coin in coins {
            if coin > max + 1 {
                break;
            }
            max += coin;
        }
        max + 1
    }
}