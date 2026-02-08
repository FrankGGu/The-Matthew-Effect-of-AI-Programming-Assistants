impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Book {
    pub title: String,
    pub author: String,
    pub available_copies: i32,
}

pub fn find_books_with_no_available_copies(books: Vec<Book>) -> Vec<String> {
    books.into_iter()
        .filter(|book| book.available_copies == 0)
        .map(|book| book.title)
        .collect()
}
}