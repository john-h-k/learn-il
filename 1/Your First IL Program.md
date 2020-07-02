# Your First IL Program

I am unoriginal and boring, so the first program here is, you guessed it, a hello world program.
But before we get to that, we need to understand a bit of IL

## IL Data Types

IL data types are generally quite similar to C#. A notable exception is `decimal`, which is a keyword in
C#, but isn't a primitive in IL and is referred to as any other custom struct.

The 2 broad types are custom types and inbuilt types. The list of inbuilt types is
```
int8
uint8
int16
uint16
int32
uint32
int64
uint64

float32
float64

bool
char

string
object
```

As well as single and multi-dimensional arrays, pointers, and references (`ref/in/out/readonly ref`).
Other types need to be explicitly referenced with their assembly, type, and name. E.g `class [System.Runtime]System.Exception`.

## IL stack

IL methods are stack-based. Instructions can pop a certain number of values off the stack, and push too.
E.g, `ldc.i4.0` (load an `int32` with value `0`) pops 0 values and pushes 1. `add` pops 2 values, adds them, and pushes the result to the stack.

## "Hello World!" program in IL

So, for our first program, I will be unoriginal and write a hello world program. The source is [`HelloWorld.il`](HelloWorld.il). It's pretty short - here it is:

```
#include "common.il"

.assembly HelloWorld {}
.module HelloWorld.exe

// namespace Program
//  internal static class HelloWorld
.class private abstract sealed auto ansi beforefieldinit HelloWorld.Program extends [System_Runtime]System.Object
{
    .method private static hidebysig void Main() cil managed
    {
        .entrypoint

        // Console.WriteLine("Hello World!");
        ldstr "Hello World!"
        call void [System_Console]System.Console::WriteLine(string)
        ret
        // That wasn't too hard now, was it?
    }
}
```

Let's get the `#include` out the way at first. `common.il` is simply a small helper that contains the assembly references for `System.Runtime` and `System.Console`. We'll come onto assembly references later. We'll also ignore the assembly, module, class and method definitions for now, and just focus on the actual IL.
`.entrypoint` isn't part of the actual IL - it is just a marker used to say "this is the program entry!". The name can be anything, but I chose `Main` for convention.

```
// Console.WriteLine("Hello World!");
ldstr "Hello World!"
call void [System_Console]System.Console::WriteLine(string)
ret
// That wasn't too hard now, was it?
```

`ldstr` pushes a string literal reference on the stack. So, now the execution stack has a single reference on it. We then call a method - in this case, `Console.WriteLine`.

We use the `call` opcode here, and must specify the entire signature - return type, assembly, full name, and arguments.

```
call <Modifiers> <ReturnType> [<Assembly>]<FullyQualifiedType>::<MethodName>(<Params>)
```

is the general syntax of a `call`. We have no modifiers here, our return type is `void`, our assembly is `System.Console`, our type is `System.Console`. and the method and params is `Console.WriteLine(string)`. `call` pops something off the stack for each argument it takes (and one extra, for instance methods - we will get to this later), and either pushes nothing if it is `void`, else pushes a single value of the return type. Here, it pops our `string` off, and pushes nothing, so now the stack is empty

`ret` marks the end of a method. When you return from a method, the stack must be empty - we pushed an item on from `ldstr`, but `call` popped it off, so we are fine. You must always specify the `ret` opcode, it is never implicit (unlike in C#).

## Compiling

The IL assembler tool (`ilasm`) is provided in this directory. We invoke it from the command line as such:

```
[from repo root]
./ilasm "1/HelloWorld.il"
```

Because ilasm is quirky, we have to execute from repo root rather than inside this folder. This will result in a `HelloWorld.exe` executable being generated. Try running it with `dotnet HelloWorld.exe`!