public class Task {

    int taskId;
    String taskName;
    String status;

    public Task next;   // Link to next node

    public Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
        this.next = null;
    }
}