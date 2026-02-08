impl Solution {
    pub fn super_washing_machines(machines: Vec<i32>) -> i32 {
        let total = machines.iter().sum::<i32>();
        let n = machines.len() as i32;
        if total % n != 0 {
            return -1;
        }
        let avg = total / n;
        let mut result = 0;
        let mut balance = 0;
        for &machine in &machines {
            balance += machine - avg;
            result = result.max(balance.abs());
        }
        result
    }
}