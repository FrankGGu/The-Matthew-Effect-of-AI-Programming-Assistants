impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_all_recipes(ingredients: Vec<Vec<String>>, recipes: Vec<String>, supplies: Vec<String>) -> Vec<String> {
        let mut supply_set = HashSet::new();
        for s in supplies {
            supply_set.insert(s);
        }

        let mut graph = std::collections::HashMap::new();
        let mut in_degree = std::collections::HashMap::new();
        let mut recipe_index = std::collections::HashMap::new();

        for (i, recipe) in recipes.iter().enumerate() {
            recipe_index.insert(recipe.clone(), i);
            in_degree.insert(i, 0);
        }

        for (i, ingreds) in ingredients.iter().enumerate() {
            for ing in ingreds {
                if recipe_index.contains_key(ing) {
                    let recipe_idx = *recipe_index.get(ing).unwrap();
                    graph.entry(recipe_idx).or_insert_with(Vec::new).push(i);
                    *in_degree.get_mut(&i).unwrap() += 1;
                }
            }
        }

        let mut queue = VecDeque::new();
        for (i, &degree) in in_degree.iter() {
            if degree == 0 {
                queue.push_back(*i);
            }
        }

        let mut result = Vec::new();
        while let Some(node) = queue.pop_front() {
            result.push(recipes[node].clone());
            if let Some(neighbors) = graph.get(&node) {
                for &neighbor in neighbors {
                    *in_degree.get_mut(&neighbor).unwrap() -= 1;
                    if *in_degree.get(&neighbor).unwrap() == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        result
    }
}
}