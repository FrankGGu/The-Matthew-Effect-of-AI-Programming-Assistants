impl Solution {

use std::collections::HashMap;

struct TrieNode {
    children: HashMap<char, TrieNode>,
    word: Option<String>,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            word: None,
        }
    }
}

fn build_trie(words: Vec<&str>) -> TrieNode {
    let mut root = TrieNode::new();
    for word in words {
        let mut node = &mut root;
        for c in word.chars() {
            node = node.children.entry(c).or_insert(TrieNode::new());
        }
        node.word = Some(word.to_string());
    }
    root
}

fn dfs(
    board: &Vec<Vec<char>>,
    i: usize,
    j: usize,
    visited: &mut Vec<Vec<bool>>,
    node: &TrieNode,
    result: &mut Vec<String>,
) {
    if i >= board.len() || j >= board[0].len() || visited[i][j] {
        return;
    }

    let c = board[i][j];
    if !node.children.contains_key(&c) {
        return;
    }

    let next_node = &node.children[&c];
    if let Some(word) = &next_node.word {
        result.push(word.clone());
    }

    visited[i][j] = true;
    dfs(board, i + 1, j, visited, next_node, result);
    dfs(board, i - 1, j, visited, next_node, result);
    dfs(board, i, j + 1, visited, next_node, result);
    dfs(board, i, j - 1, visited, next_node, result);
    visited[i][j] = false;
}

impl Solution {
    pub fn find_words(board: Vec<Vec<char>>, words: Vec<String>) -> Vec<String> {
        let trie = build_trie(words.iter().map(|s| s.as_str()).collect());
        let mut result = vec![];
        let mut visited = vec![vec![false; board[0].len()]; board.len()];

        for i in 0..board.len() {
            for j in 0..board[0].len() {
                dfs(&board, i, j, &mut visited, &trie, &mut result);
            }
        }

        result.into_iter().collect()
    }
}
}