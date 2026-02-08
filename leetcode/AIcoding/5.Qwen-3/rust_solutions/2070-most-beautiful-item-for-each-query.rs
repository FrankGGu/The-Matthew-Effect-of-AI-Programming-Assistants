impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeMap;

impl Solution {
    pub fn sort_items(mut items: Vec<Vec<i32>>, mut queries: Vec<i32>) -> Vec<i32> {
        items.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut price_to_max_beauty = BTreeMap::new();
        let mut max_beauty = 0;

        for item in items {
            let price = item[0];
            let beauty = item[1];
            max_beauty = max_beauty.max(beauty);
            price_to_max_beauty.insert(price, max_beauty);
        }

        let mut result = Vec::with_capacity(queries.len());

        for q in queries {
            let mut best = 0;
            let mut left = 0;
            let mut right = price_to_max_beauty.len() as i32 - 1;

            while left <= right {
                let mid = (left + right) / 2;
                let key = price_to_max_beauty.keys().nth(mid as usize).unwrap();
                match key.cmp(&q) {
                    Ordering::Less => {
                        best = *price_to_max_beauty.get(key).unwrap();
                        left = mid + 1;
                    }
                    Ordering::Equal => {
                        best = *price_to_max_beauty.get(key).unwrap();
                        break;
                    }
                    Ordering::Greater => {
                        right = mid - 1;
                    }
                }
            }

            result.push(best);
        }

        result
    }
}
}