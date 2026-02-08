impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn amount_of_time(root: Option<Rc<RefCell<TreeNode>>>, start: i32) -> i32 {
    use std::collections::{HashMap, VecDeque};

    fn build_graph(
        node: &Option<Rc<RefCell<TreeNode>>>,
        parent: Option<i32>,
        graph: &mut HashMap<i32, Vec<i32>>,
    ) {
        if let Some(n) = node {
            let val = n.borrow().val;
            if let Some(p) = parent {
                graph.entry(val).or_insert_with(Vec::new).push(p);
                graph.entry(p).or_insert_with(Vec::new).push(val);
            }
            build_graph(&n.borrow().left, Some(val), graph);
            build_graph(&n.borrow().right, Some(val), graph);
        }
    }

    fn bfs(start: i32, graph: &HashMap<i32, Vec<i32>>) -> i32 {
        let mut visited = std::collections::HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(start);
        visited.insert(start);
        let mut time = 0;

        while !queue.is_empty() {
            let len = queue.len();
            for _ in 0..len {
                if let Some(node) = queue.pop_front() {
                    for &neighbor in graph.get(&node).into_iter().flatten() {
                        if !visited.contains(&neighbor) {
                            visited.insert(neighbor);
                            queue.push_back(neighbor);
                        }
                    }
                }
            }
            if !queue.is_empty() {
                time += 1;
            }
        }

        time
    }

    let mut graph = HashMap::new();
    build_graph(&root, None, &mut graph);
    bfs(start, &graph)
}
}