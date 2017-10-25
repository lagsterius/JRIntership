package ru.lagsterius.jrintersip.service;

import ru.lagsterius.jrintersip.model.Book;

import java.util.List;

public interface BookService {
    void addBook(Book user);

    void updateBook(Book user);

    void removeBook(int id);

    Book getBookById(int id);

    List<Book> listBooks();
}
