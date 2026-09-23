public class Variables {
    public static void main(String[] args) {
        // Creación de variable int
        int age = 123;
        System.out.println("The age is " + age + " years");

        // Reasignación de una variable
        age = 75;
        // age = 23;               
        System.out.println("The age is " + age + " years now");

        byte numOfBooks = 34;
        System.out.println("There are " + numOfBooks + " books");

        // byte es una variable primitiva de 8 bits (-128, +127)
        // byte minimumSpeed = 345;
        byte minimumSpeed = -100;
        System.out.println("The car's minimum speed is: " + minimumSpeed + "");

        boolean isRaining = false;
        System.out.println("Is it raining? " + isRaining);

        float gravity = 9.81f;
        System.out.println("The gravity of earth is: " + gravity);

        double pi = 3.1415926535;
        System.out.println("The pi constant in double format has a value of: " + pi);

        // Conversión de doble a float
        float pi2 = 3.1415926535f;
        float pi3 = (float)3.1415926535; // CASTING
        System.out.println("The pi constant in double format has a value of: " + pi2);
        System.out.println("The pi constant in double format has a value of: " + pi3);

        double pi4 = 3.1415926535f;
        System.out.println("The pi constant in double format has a value of: " + pi4);

        byte numOfBooks2 = (byte) 130;
        System.out.println("There are " + numOfBooks2 + " books");

        // Variable sin inicializar
        int lives;
        lives = -1;
        System.out.println("Number of player lives: " + lives);

        // Definición de constantes: Usamos la palabra final
        final int numAlumnos = 7;
        System.out.println("El numero de alumnos es: " + numAlumnos);
        // numAlumnos = 12;

        final double PI = 3.141592f;
        System.out.println("The PI constant has a value of: " + PI);

        final int NUM_INGREDIENTS = 5;

        final float GRAVITY;
        GRAVITY = 9.81f; // No hacer

        // Strings: es una cadena de caracteres

        // String creation like primitive
        String name = "Bishop";

        // String creation using new operator
        String studentName = new String("Thug");

        System.out.println("My name is " + name);
        System.out.println("The student's name is " + studentName);
    }
}
