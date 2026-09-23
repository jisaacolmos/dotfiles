public class Operators {
    public static void main(String[] args) {
        // Suma y producto de 2 números
        int num1 = 2;
        int num2 = 5;

        int suma = num1 + num2;
        int prod = num1 * num2;

        System.out.println(num1 + " + " + num2 + " = " + suma);
        System.out.println(num1 + " * " + num2 + " = " + prod);
        System.out.println(num1 + " + " + num2 + " = " + (num1 + num2));

        System.out.println(num1 + " + ");
        System.out.println(num1 + " num2");

        // Cake program 
        int numOfCakes = 11;
        int numOfMonsters = 4;
        int numOfCakesPerMonster = numOfCakes / numOfMonsters;

        System.out.println("There are " + numOfCakesPerMonster + " cakes");
        System.out.println("for each monster.");

        // Cake program float
        // float numOfCakes2 = 11;
        // float numOfMonsters2 = 4;
        // float numOfCakesPerMonster2 = numOfCakes2 / numOfMonsters2;
        // 
        // System.out.println("There are " + numOfCakesPerMonster2 + " cakes");
        // System.out.println("for each monster.");

        int division1 = num1 / num2;
        int division2 = num2 / num1;

        System.out.println(num1 + " / " + num2 + " = " + division1);
        System.out.println(num2 + " / " + num1 + " = " + division2);

        // Division float

        float num3 = 2.0f;
        float num4 = 5.0f;
        float division3 = num3 / num4;
        float division4 = num4 / num3;
        System.out.println("\nFloat division");
        System.out.println("----------------");
        System.out.println(num3 + " / " + num4 + " = " + division3);
        System.out.println(num4 + " / " + num3 + " = " + division4);

        // Convert Integer variables to float
        // Convertir numerador to float

        int num5 = 4;
        int num6 = 7;
        
        System.out.println("\nCast numerator to float");
        System.out.println("----------------");
        
        float division5 = (float)(num6 / num5);
        float division6 = num5 / num6;

        System.out.println(num6 + " / " + num5 + " = " + division5);
        System.out.println(num5 + " / " + num6 + " = " + division6);

        // Remainder operator
        int remainder = num6 % num5;
        System.out.println(num6 + " % " + num5 + " = " + remainder);

        // Incremento de una variable
        int suma3 = 10;

        // Dos formas
        // Primera forma
        suma3 = suma3 + 5;
        System.out.println("Nuevo valor suma3 = suma3 + 5: " + suma3);

        // Segunda forma
        suma3 += 5;
        System.out.println("Nuevo valor suma3 += 5: " + suma3);

        // Incrementar una variable en una unidad
        // 4 formas
        // Primera forma
        suma3 = suma3 + 1;
        System.out.println("Nuevo valor suma3 = suma3 + 1: " + suma3);

        // Segunda forma
        suma3 += 1;
        System.out.println("Nuevo valor suma3 += 1: " + suma3);
        // Tercera forma
        suma3++;
        System.out.println("Nuevo valor suma3 ++: " + suma3);

        // Cuarta forma
        ++suma3;
        System.out.println("Nuevo valor ++ suma3: " + suma3);

        // OJO con ++variable y variable++
        int var = 10;
        int result1 = ++var;
        
        System.out.println("var: " + var);
        System.out.println("Result1: " + result1);

        var = 10;
        int result2 = var++;

        System.out.println("var:" + var);
        System.out.println("Result2: " + result2);

        // Podemos asignar una variable a otra
        // var mantiene su valor aunque variemos suma3

        suma3 = 56;
        var = suma3;
        suma3++;
        // var = suma3;

        System.out.println("var is:" + var);
        System.out.println("suma3 is:" + suma3);
    }
}
