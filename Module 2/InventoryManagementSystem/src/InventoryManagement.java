import java.util.HashMap;

public class InventoryManagement {

    static HashMap<Integer, Product> inventory = new HashMap<>();

    // Add Product
    public static void addProduct(Product p) {
        inventory.put(p.productId, p);
        System.out.println("Product Added");
    }

    // Update Product
    public static void updateProduct(int id, int quantity, double price) {
        if (inventory.containsKey(id)) {
            Product p = inventory.get(id);
            p.quantity = quantity;
            p.price = price;
            System.out.println("Product Updated");
        } else {
            System.out.println("Product Not Found");
        }
    }

    // Delete Product
    public static void deleteProduct(int id) {
        inventory.remove(id);
        System.out.println("Product Deleted");
    }

    // Display Products
    public static void displayProducts() {
        for (Product p : inventory.values()) {
            System.out.println(p);
        }
    }

    public static void main(String[] args) {

        addProduct(new Product(101, "Laptop", 10, 50000));
        addProduct(new Product(102, "Mouse", 50, 500));

        displayProducts();

        updateProduct(101, 15, 52000);

        deleteProduct(102);

        System.out.println("\nFinal Inventory:");
        displayProducts();
    }
}