public class BuilderTest {

    public static void main(String[] args) {

        Computer gamingPC = new Computer.Builder()
                .setCpu("Intel i7")
                .setRam(16)
                .setStorage(512)
                .build();

        Computer officePC = new Computer.Builder()
                .setCpu("Intel i5")
                .setRam(8)
                .setStorage(256)
                .build();

        gamingPC.display();
        officePC.display();
    }
}