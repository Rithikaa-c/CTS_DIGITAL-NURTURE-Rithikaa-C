public class MVCTest {

    public static void main(String[] args) {

        Student model =
                new Student("Rithikaa", 101, "A");

        StudentView view = new StudentView();

        StudentController controller =
                new StudentController(model, view);

        controller.updateView();

        System.out.println("\nAfter Update:\n");

        controller.setStudentName("Rithi");
        controller.setStudentGrade("A+");

        controller.updateView();
    }
}