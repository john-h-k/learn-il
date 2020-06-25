#include "common.il"

.assembly Numbers {}
.module Numbers.exe

.class private abstract sealed auto ansi beforefieldinit Numbers.Program extends [System_Runtime]System.Object
{
    .method private static hidebysig void Complain() cil managed
    {
        /*
         * Console.WriteLine("Not a valid base 10 number.\nProgram exiting...");
         * Console.ReadKey();
         */
        ldstr "Not a valid base 10 number.\nProgram exiting..."
        call void [System_Console]System.Console::WriteLine(string)
        call valuetype [System_Console]System.ConsoleKeyInfo [mscorlib]System.Console::ReadKey()
        pop // Clean the stack
        ret
    }

    .method private static hidebysig void Main() cil managed
    {
        .entrypoint

        // Initialize 2 strings and 2 integers
        .locals init
        (
            [0] string firstRequest,
            [1] string secondRequest,
            [2] int32 firstNumber,
            [3] int32 secondNumber
        )

        /*
         * firstRequest = "Enter a number:";
         * secondRequest = "Enter another number:";
         */

        // Load 2 strings into the string references
        ldstr "Enter a number:"
        stloc firstRequest
        ldstr "Enter another number:"
        stloc secondRequest

         /*
         * Console.WriteLine(firstRequest);
         * if (!int.TryParse(Console.ReadLine(), out firstNumber))
         *     goto COMPLAIN
         */

        // Request, read, and parse the first number
        ldloc firstRequest
        call void [System_Console]System.Console::WriteLine(string)
        call string [System_Console]System.Console::ReadLine()
        ldloca.s firstNumber // Load the address of the first int to the stack
        call bool [mscorlib]System.Int32::TryParse(string, int32&)
        brfalse.s COMPLAIN

        /*
         * Console.WriteLine(secondRequest);
         * if (!int.TryParse(Console.ReadLine(), out secondNumber))
         *     goto COMPLAIN
         */

        // Repeat for the second
        ldloc secondRequest
        call void [System_Console]System.Console::WriteLine(string)
        call string [System_Console]System.Console::ReadLine()
        ldloca.s secondNumber
        call bool [System_Runtime]System.Int32::TryParse(string, int32&)
        brfalse.s COMPLAIN

        /*
         * Console.WriteLine("The sum of those 2 numbers is: ");
         */

        // Print
        ldstr "The sum of those 2 numbers is: "
        call void [System_Console]System.Console::Write(string)

        /*
         * Console.WriteLine(firstNumber + secondNumber);
         * Console.ReadKey()
         * goto RETURN
         */

        // Load the 2 numbers to the stack, add them, and print them
        ldloc firstNumber
        ldloc secondNumber
        add
        call void [System_Console]System.Console::WriteLine(int32)
        call valuetype [System_Console]System.ConsoleKeyInfo [mscorlib]System.Console::ReadKey()
        pop
        br.s RETURN

        /*
         * COMPLAIN: Complain()
         * RETURN: return;
         */

        // Possibly complain, then return
        COMPLAIN: call void Numbers.Program::Complain()
        RETURN: ret
    }
}