/*
Hello World
*/

public class HelloWorld {
    public static void main(String[] args) throws Exception {

        // Single line comment

        /*
         * Multiple line comment
         */

        // Use of println
        // -------------------------

        // Print text on console, adds a new line
        System.out.println("Hello Acolytes. Welcome to hell!");
        System.out.println(" ");
        System.out.println("Be careful in the DAW1 vault ");
        System.out.println();

        // Use of print
        // -------------------------

        // Print text on console, doesn't add a new line
        System.out.print("Hello Acolytes. Welcome to hell!");
        System.out.print(" ");
        System.out.print("Be careful in the DAW1 vault ");

        // Use of print to simulate a jump in line
        // \n represents a new line character

        System.out.print("Hello Acolytes. Welcome to hell! \n");
        System.out.print("This text starts in a new line");
        System.out.print("\n");

        // Use of character \t to generate a tab
        // \n represents a new line character

        System.out.print("Player Attributes\n");
        System.out.print("------------------------\n");
        System.out.print("- Strength\t38\n");
        System.out.print("- Intelligence\t45\n");
        System.out.print("- Dexterity\t56\n");

        // System.out. + SPACE = list candidates is VS Code
    }
}
