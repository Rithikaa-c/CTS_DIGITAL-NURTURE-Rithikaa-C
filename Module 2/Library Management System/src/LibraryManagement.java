public class LibraryManagement {

    // Linear Search
    public static Book linearSearch(Book[] books, String title) {

        for (Book b : books) {

            if (b.title.equalsIgnoreCase(title)) {
                return b;
            }
        }

        return null;
    }

    // Binary Search
    public static Book binarySearch(Book[] books, String title) {

        int low = 0;
        int high = books.length - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            int result =
                    books[mid].title.compareToIgnoreCase(title);

            if (result == 0) {
                return books[mid];
            }

            if (result < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        // Sorted by title
        Book[] books = {
                new Book(101, "C++", "Bjarne"),
                new Book(102, "DBMS", "Korth"),
                new Book(103, "Java", "James Gosling"),
                new Book(104, "Python", "Guido")
        };

        System.out.println("Linear Search:");
        Book b1 = linearSearch(books, "Java");
        System.out.println(b1);

        System.out.println("\nBinary Search:");
        Book b2 = binarySearch(books, "Python");
        System.out.println(b2);
    }
}