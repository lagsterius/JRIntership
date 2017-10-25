package ru.lagsterius.jrintersip.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.lagsterius.jrintersip.dao.BookDao;
import ru.lagsterius.jrintersip.model.Book;

import java.util.List;

@Service
public class BookServiceImpl implements BookService{
    private BookDao bookDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Transactional
    public void addBook(Book book) {
        this.bookDao.addBook(book);
    }

    @Transactional
    public void updateBook(Book book) {
        this.bookDao.updateBook(book);
    }

    @Transactional
    public void removeBook(int id) {
        this.bookDao.removeBook(id);
    }

    @Transactional
    public Book getBookById(int id) {
        return this.bookDao.getBookById(id);
    }

    @Transactional
    public List<Book> listBooks() {
        return this.bookDao.listBooks();
    }
}
