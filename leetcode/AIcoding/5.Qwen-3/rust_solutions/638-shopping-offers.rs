impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn shopping_offers(price: Vec<i32>, special: Vec<Vec<i32>>, needs: Vec<i32>) -> i32 {
        fn dfs(price: &Vec<i32>, special: &Vec<Vec<i32>>, needs: &Vec<i32>, memo: &mut HashMap<Vec<i32>, i32>) -> i32 {
            if let Some(&val) = memo.get(needs) {
                return val;
            }

            let mut cost = 0;
            for i in 0..needs.len() {
                cost += price[i] * needs[i];
            }

            for s in special {
                let mut valid = true;
                let mut new_needs = Vec::new();
                for i in 0..needs.len() {
                    if s[i] > needs[i] {
                        valid = false;
                        break;
                    }
                    new_needs.push(needs[i] - s[i]);
                }
                if valid {
                    let mut temp = vec![s.last().unwrap().clone()];
                    for i in 0..needs.len() {
                        temp.push(new_needs[i]);
                    }
                    cost = std::cmp::min(cost, dfs(price, special, &new_needs, memo) + s.last().unwrap().clone());
                }
            }

            memo.insert(needs.clone(), cost);
            cost
        }

        let mut memo = HashMap::new();
        dfs(&price, &special, &needs, &mut memo)
    }
}
}