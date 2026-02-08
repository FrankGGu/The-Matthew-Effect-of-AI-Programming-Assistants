struct Solution;

impl Solution {
    pub fn visitors_last_visited_integers(queries: Vec<String>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut last_visited = Vec::new();

        for query in queries {
            if let Ok(num) = query.parse::<i32>() {
                last_visited.clear();
                last_visited.push(num);
                result.push(num);
            } else {
                let len = last_visited.len();
                if len > 0 {
                    result.push(last_visited[len - 1]);
                }
            }
        }

        result
    }
}