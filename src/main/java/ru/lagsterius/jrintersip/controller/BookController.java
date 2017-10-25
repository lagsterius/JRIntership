package ru.lagsterius.jrintersip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import ru.lagsterius.jrintersip.model.Book;
import ru.lagsterius.jrintersip.service.BookService;

import java.util.ArrayList;
import java.util.List;



@Controller
public class BookController {
    private static int id = 0;
    private BookService bookService;

    @Autowired
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = "books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book) {
        if (book.getTitle() == "" || book.getAuthor() == "")
            return "redirect:/";
        if (book.getId() == 0)
            this.bookService.addBook(book);
        else
            this.bookService.updateBook(book);
        return "redirect:/";
    }
    
    @RequestMapping("/remove/{id}")
    public String removeBook(@PathVariable("id") int id) {
        this.bookService.removeBook(id);
        return "redirect:/";
    }
    
    @RequestMapping("/edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model) {

        BookController.id = this.bookService.getBookById(id).getId();
        model.addAttribute("listBooks", this.bookService.listBooks());
        return "redirect:/";
    }

    @RequestMapping("/read/{id}")
    public String readBook(@PathVariable("id") int id, Model model) {
        Book editBook = this.bookService.getBookById(id);
        editBook.setReadAlready(true);
        this.bookService.updateBook(editBook);
        model.addAttribute("listBooks", this.bookService.listBooks());
        return "redirect:/";
    }
    
    @RequestMapping(value = "/")
    public ModelAndView listOfBooks(@RequestParam(required = false) Integer page, @RequestParam(required = false) String field, @RequestParam(required = false) String column) {
        ModelAndView modelAndView = new ModelAndView("index");
        if (id != 0) {
            modelAndView.addObject("book", this.bookService.getBookById(id));
            id = 0;
        } else {
            modelAndView.addObject("book", new Book());
        }

        List<Book> books;
        if (field == null || field.length() < 3) {
            books = this.bookService.listBooks();
        } else {
            List<Book> tempBooks = this.bookService.listBooks();
            books = new ArrayList<Book>();
            for (Book tempBook : tempBooks)
                if (column.equals("title")) {
                    if (tempBook.getTitle().toLowerCase().contains(field.toLowerCase()))
                        books.add(tempBook);
                } else if (column.equals("description")) {
                    if (tempBook.getDescription().toLowerCase().contains(field.toLowerCase()))
                        books.add(tempBook);
                } else {
                    if (tempBook.getAuthor().toLowerCase().contains(field.toLowerCase()))
                        books.add(tempBook);
                }
        }

        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(books);
        pagedListHolder.setPageSize(10);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if (page == null || page < 1 || page > pagedListHolder.getPageCount())
            page = 1;

        modelAndView.addObject("page", page);

        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        } else if (page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page - 1);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        }
        return modelAndView;
    }
}
