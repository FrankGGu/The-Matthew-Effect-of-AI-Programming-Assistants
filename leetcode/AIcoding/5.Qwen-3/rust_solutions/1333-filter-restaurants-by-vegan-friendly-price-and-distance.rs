struct Solution;

impl Solution {
    pub fn filter_restaurants(
        restaurants: Vec<Vec<i32>>,
        vegan_friendly: i32,
        max_price: i32,
        max_distance: i32,
    ) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for r in restaurants {
            let id = r[0];
            let rating = r[1];
            let vegan = r[2];
            let price = r[3];
            let distance = r[4];
            if vegan_friendly == 1 && vegan != 1 {
                continue;
            }
            if price > max_price {
                continue;
            }
            if distance > max_distance {
                continue;
            }
            result.push(vec![id, rating]);
        }
        result.sort_by(|a, b| b[1].cmp(&a[1]).then_with(|| a[0].cmp(&b[0])));
        result
    }
}