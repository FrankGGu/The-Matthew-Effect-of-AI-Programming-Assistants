impl Solution {

use std::collections::HashMap;

fn pivot_table(table: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut rows = HashMap::new();
    let mut columns = HashMap::new();

    for row in table.iter() {
        let key = &row[0];
        let value = &row[1];
        let category = &row[2];

        columns.entry(category).or_insert_with(Vec::new);
        columns.get_mut(category).unwrap().push(value.clone());

        rows.entry(key).or_insert_with(|| HashMap::new());
        rows.get_mut(key).unwrap().insert(category, value.clone());
    }

    let mut result = vec![];
    let mut header = vec!["".to_string()];

    for (i, col) in columns.iter().enumerate() {
        header.push(col.0.to_string());
        if i == 0 {
            header[0] = "key".to_string();
        }
    }

    result.push(header);

    for (key, values) in rows.iter() {
        let mut row = vec![key.clone()];
        for (col, _) in columns.iter() {
            if let Some(val) = values.get(col) {
                row.push(val.clone());
            } else {
                row.push("".to_string());
            }
        }
        result.push(row);
    }

    result
}
}