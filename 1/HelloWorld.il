#include "common.il"

.assembly HelloWorld {}
.module HelloWorld.exe

// namespace Program
//  internal static class HelloWorld
.class private abstract sealed auto ansi beforefieldinit HelloWorld.Program extends [System.Runtime]System.Object
{
    .method private static hidebysig void Main() cil managed
    {
        .entrypoint

        // Console.WriteLine("Hello World!");
        ldstr "Hello World!"
        call void [System.Console]System.Console::WriteLine(string)
        ret
        // That wasn't too hard now, was it?
    }
}