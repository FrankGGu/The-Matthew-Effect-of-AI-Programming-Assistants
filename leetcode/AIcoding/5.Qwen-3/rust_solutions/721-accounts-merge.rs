impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn accounts_merge(mut accounts: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut parent = HashMap::new();
        let mut name_map = HashMap::new();

        for account in &accounts {
            let name = &account[0];
            let email = &account[1];
            name_map.insert(email, name);
            if !parent.contains_key(email) {
                parent.insert(email, email);
            }
        }

        fn find(parent: &mut HashMap<String, String>, x: &str) -> String {
            if parent.get(x).unwrap() != x {
                let p = find(parent, parent.get(x).unwrap());
                parent.insert(x.to_string(), p);
            }
            parent.get(x).unwrap().to_string()
        }

        fn union(parent: &mut HashMap<String, String>, x: &str, y: &str) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x != root_y {
                parent.insert(root_y, root_x);
            }
        }

        for account in &accounts {
            let emails = &account[1..];
            for i in 1..emails.len() {
                union(&mut parent, &emails[0], &emails[i]);
            }
        }

        let mut groups = HashMap::new();
        for account in &accounts {
            let email = &account[1];
            let root = find(&mut parent, email);
            groups.entry(root).or_insert_with(HashSet::new).insert(email);
        }

        let mut result = Vec::new();
        for (root, emails) in groups {
            let name = name_map.get(&root).unwrap();
            let mut merged = vec![name.clone()];
            merged.extend(emails.into_iter().cloned().collect::<Vec<_>>());
            merged.sort();
            result.push(merged);
        }

        result.sort_by(|a, b| a[0].cmp(&b[0]));
        result
    }
}
}