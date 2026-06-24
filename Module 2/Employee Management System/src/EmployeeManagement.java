public class EmployeeManagement {

    static Employee[] employees = new Employee[10];
    static int count = 0;

    // Add Employee
    public static void addEmployee(Employee e) {

        if (count < employees.length) {
            employees[count] = e;
            count++;
            System.out.println("Employee Added");
        } else {
            System.out.println("Array Full");
        }
    }

    // Search Employee
    public static Employee searchEmployee(int id) {

        for (int i = 0; i < count; i++) {

            if (employees[i].employeeId == id) {
                return employees[i];
            }
        }

        return null;
    }

    // Traverse Employees
    public static void traverseEmployees() {

        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }

    // Delete Employee
    public static void deleteEmployee(int id) {

        for (int i = 0; i < count; i++) {

            if (employees[i].employeeId == id) {

                for (int j = i; j < count - 1; j++) {
                    employees[j] = employees[j + 1];
                }

                employees[count - 1] = null;
                count--;

                System.out.println("Employee Deleted");
                return;
            }
        }

        System.out.println("Employee Not Found");
    }

    public static void main(String[] args) {

        addEmployee(new Employee(101, "Riya", "Manager", 50000));
        addEmployee(new Employee(102, "Arun", "Developer", 40000));
        addEmployee(new Employee(103, "Meena", "Tester", 35000));

        System.out.println("\nAll Employees:");
        traverseEmployees();

        System.out.println("\nSearch Employee:");
        System.out.println(searchEmployee(102));

        deleteEmployee(102);

        System.out.println("\nAfter Deletion:");
        traverseEmployees();
    }
}