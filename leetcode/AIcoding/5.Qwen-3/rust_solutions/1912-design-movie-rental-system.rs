impl Solution {

use std::collections::{HashMap, BTreeSet};

struct MovieRentalSystem {
    inventory: HashMap<i32, BTreeSet<i32>>, // movie_id -> set of shop_ids
    rented: HashMap<(i32, i32), i32>,      // (movie_id, shop_id) -> customer_id
}

impl MovieRentalSystem {
    fn new() -> Self {
        MovieRentalSystem {
            inventory: HashMap::new(),
            rented: HashMap::new(),
        }
    }

    fn report(&self) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut shops = BTreeSet::new();
        for (movie_id, shops_set) in &self.inventory {
            for &shop_id in shops_set {
                shops.insert(shop_id);
            }
        }
        for shop_id in shops {
            let mut movies = BTreeSet::new();
            for (movie_id, shops_set) in &self.inventory {
                if shops_set.contains(&shop_id) {
                    movies.insert(*movie_id);
                }
            }
            for &movie_id in &movies {
                result.push(vec![shop_id, movie_id]);
            }
        }
        result.sort();
        result
    }

    fn search(&self, shop_id: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for (movie_id, shops_set) in &self.inventory {
            if shops_set.contains(&shop_id) {
                result.push(*movie_id);
            }
        }
        result.sort();
        result
    }

    fn rent(&mut self, customer_id: i32, movie_id: i32, shop_id: i32) {
        self.rented.insert((movie_id, shop_id), customer_id);
    }

    fn drop(&mut self, customer_id: i32, movie_id: i32, shop_id: i32) {
        self.rented.remove(&(movie_id, shop_id));
    }

    fn get_rented(&self, customer_id: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for ((movie_id, shop_id), cust_id) in &self.rented {
            if *cust_id == customer_id {
                result.push(vec![*shop_id, *movie_id]);
            }
        }
        result.sort();
        result
    }
}
}