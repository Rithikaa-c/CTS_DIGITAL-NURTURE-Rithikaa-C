

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Main {

    public static void main(String[] args) {

        ApplicationContext context =
                new ClassPathXmlApplicationContext("applicationContext.xml");

        org.example.BookRepository repo = context.getBean("bookRepository", org.example.BookRepository.class);
        org.example.BookService service = context.getBean("bookService", org.example.BookService.class);

        repo.show();
        service.show();
    }
}