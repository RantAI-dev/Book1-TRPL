---
weight: 800
title: "Chapter 2"
description: "A Tour of Rust: The Basics"
icon: "article"
date: "2024-08-05T21:16:13+07:00"
lastmod: "2024-08-05T21:16:13+07:00"
draft: false
toc: true
---
<center>

# 📘 Chapter 2 : A Tour of Rust: The Basics

</center>
{{% alert icon="💡" context="info" %}}
<strong>

"*The art of programming is the art of organizing complexity, of mastering multitude and avoiding its bastard chaos as effectively as possible*." — Edsger W. Dijkstra

</strong>
{{% /alert %}}

{{% alert icon="📘" context="success" %}}

<p style="text-align: justify;">
Chapter 2 of TRPL - “A Tour of Rust - The Basics" lays the groundwork for a comprehensive understanding of Rust's core principles. It starts with simple examples like "Hello, World!" and covers fundamental topics such as types, variables, and arithmetic operations. The chapter then explains the roles of constants, tests, and loops, and introduces pointers, arrays, and loops with detailed examples showcasing their usage. It delves into user-defined types, including structures, classes, and enumerations, highlighting their contribution to Rust's powerful and expressive type system. Emphasizing modularity, the chapter covers separate compilation, namespaces, and error handling, essential for effectively organizing and managing Rust programs. It concludes with a postscript and practical advice, offering readers valuable insights and best practices for mastering and applying Rust in their programming endeavors.
</p>

{{% /alert %}}

## 2.1. Introduction
<p style="text-align: justify;">
The aim of this chapter and the next three is to give you an idea of what Rust is, without going into a lot of details. This chapter informally presents Rust's syntax, its memory and computation model, and the basic mechanisms for organizing code into a program. These are the language facilities supporting procedural programming styles. Chapter 3 will build on this by introducing Rust's abstraction mechanisms.
</p>

<p style="text-align: justify;">
The assumption is that you have programmed before. If not, please consider reading a textbook, such as <strong>The C Programming Language</strong> by Kernighan and Ritchie, before continuing here. Even if you have programmed before, the language you used or the applications you wrote may be very different from the style of Rust presented here.
</p>

<p style="text-align: justify;">
This tour of Rust saves us from a strictly bottom-up presentation of language and library features by enabling the use of a rich set of facilities even in early chapters. For example, loops are not discussed in detail until later, but they will be used in straightforward ways long before that. Similarly, the detailed descriptions of structs, enums, ownership, and the standard library are spread over many chapters, but standard library types, such as Vec, String, Option, Result, Box, and std::io, are used freely where needed to enhance code examples.
</p>

<p style="text-align: justify;">
Imagine this as a short sightseeing tour of a city like Jakarta or Singapore. In just a few hours, you get a quick glimpse of the major attractions, hear some background stories, and receive suggestions on what to explore next. You won't fully understand the city after such a tour, nor will you grasp everything you've seen and heard. To truly know a city, you need to live in it, often for years. Similarly, this overview of Rust gives you a brief introduction, showcasing what makes Rust special and what might interest you. After this initial tour, the real exploration begins.
</p>

<p style="text-align: justify;">
This tour presents Rust as an integrated whole rather than a collection of separate layers. It doesn't differentiate between features from earlier versions of Rust and those introduced in newer editions. Instead, it offers a cohesive view of Rust, showing how its various elements work together to create a powerful and efficient programming language.
</p>

## 2.2. The Basics
<p style="text-align: justify;">
Rust is a compiled language, meaning that its source code needs to be processed by a compiler to create a runnable program. You write your Rust code in one or more source files, commonly named <code>Main.rs</code> and <code>Lib.rs</code>. The Rust compiler processes these source files to produce object files, such as <code>Main.o</code> and <code>Lib.o</code>. These object files are then combined by a linker to create the final executable program. This process ensures that all parts of your program are correctly compiled and linked together, resulting in a file that you can run on your computer.
</p>

{{< figure src="images/P8MKxO7NRG2n396LeSEs-Z2pkvBAKxWT6RtooMKT4-v2.png" width="500" height="300" class="text-center" >}}


<p style="text-align: justify;">
When we talk about the portability of Rust programs, we refer to the ability of Rust’s source code to be compiled and run on different systems. It’s important to note that the compiled executable is specific to the hardware and operating system it was built for. For instance, an executable built on a Mac will not run on a Windows PC without recompilation. However, the same Rust source code can be compiled on different systems, such as Mac, Windows, and Linux, to produce executables for those systems.
</p>

<p style="text-align: justify;">
To compile Rust source files <code>Main.rs</code> and <code>Lib.rs</code> into object files and then link them into a final executable, you need to use the <code>rustc</code> command-line tool.
</p>

{{< prism lang="shell">}}
rustc --emit=obj -o Main.o Main.rs
{{< /prism >}}
<p style="text-align: justify;">
The <code>--emit=obj</code> flag instructs the Rust compiler to produce an object file rather than an executable. The <code>-o</code> flag specifies the name of the output file, which in this case is <code>Main.o</code>. Similarly, compile <code>Lib.rs</code> into an object file named <code>Lib.o</code> using this command:
</p>

{{< prism lang="shell">}}
rustc --emit=obj -o Lib.o Lib.rs
{{< /prism >}}
<p style="text-align: justify;">
Again, <code>--emit=obj</code> tells the compiler to create an object file, and <code>-o</code> specifies the output file name, <code>Lib.o</code>. Here, <code>rustc</code> takes the two object files, <code>Main.o</code> and <code>Lib.o</code>, and the following command links them together to generate an executable named <code>MyProgram</code>.
</p>
{{< prism lang="shell">}}
rustc Main.o Lib.o -o MyProgram
{{< /prism >}}

<p style="text-align: justify;">
These commands should be executed in your VS Code terminal or command prompt from the directory where your source files are located. By following these steps, you compile and link your Rust code into a runnable program. Another technique for compiling a library is using the cargo tool and compiler option <code>--crate-type=lib</code>. You can practice this later using ChatGPT.
</p>

<p style="text-align: justify;">
Rust’s standard defines two main types of entities: core language features and standard library components. Core language features include built-in types like <code>char</code> and <code>i32</code>, as well as control flow constructs like <code>for</code> loops and <code>while</code> loops. These features are intrinsic to the language and provide the basic building blocks for writing Rust programs. Standard library components are additional tools provided by Rust’s standard library, such as collections (<code>Vec</code> and <code>HashMap</code>) and I/O operations (<code>println!</code> and <code>read_line()</code>). The standard library is implemented in Rust itself, with minimal machine code used for low-level tasks like thread context switching. This showcases Rust’s capability to handle even the most demanding systems programming tasks efficiently.
</p>

<p style="text-align: justify;">
The standard library components in Rust are ordinary Rust code provided by every Rust implementation. In fact, the Rust standard library can be implemented in Rust itself, with minimal use of machine code for tasks such as thread context switching. This demonstrates that Rust is sufficiently expressive and efficient for the most demanding systems programming tasks.
</p>

<p style="text-align: justify;">
Rust is a statically typed language, which means that the type of every variable, value, name, and expression must be known at compile time. This ensures that types are checked before the program runs, enhancing both safety and performance. The type of an entity determines what operations can be performed on it, ensuring that you can't accidentally misuse data in ways that could cause errors or crashes. By understanding these concepts, you can better appreciate how Rust ensures reliability and efficiency in systems programming.
</p>

## 2.3. Hello, World!
<p style="text-align: justify;">
The minimal Rust program is:
</p>

{{< prism lang="rust">}}
fn main() {}
// the minimal Rust program
{{< /prism >}}

<p style="text-align: justify;">
This defines a function called \<code>main\</code>, which takes no arguments and does nothing. Curly braces \<code>{}\</code> are used to group code in Rust, indicating the start and end of the function body. The double slash \<code>//\</code> begins a comment that extends to the end of the line, intended for human readers and ignored by the compiler. Every Rust program must have exactly one global function named \<code>main()\</code>. The program starts by executing this function. Unlike C++, the \<code>main\</code> function in Rust does not return a value to the system by default; it assumes successful completion unless an explicit return value or error is specified.
</p>

<p style="text-align: justify;">
Typically, a program produces some output. Here is a program that prints "Hello, World!":
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    println!("Hello, World!");
}
{{< /prism >}}

<p style="text-align: justify;">
In Rust, the <code>println!</code> macro is used for output. The expression
</p>

{{< prism lang="rust">}}
println!("Hello, World!");
{{< /prism >}}

<p style="text-align: justify;">
writes "Hello, World!" to the console. The <code>println!</code> macro is part of Rust's standard library and requires no additional imports to use. The <code>println!</code> macro uses the format string syntax, where the string literal "Hello, World!" is surrounded by double quotes. In a string literal, the backslash character <code>\</code> followed by another character denotes a special character. In this case, <code>\n</code> is the newline character, so the output is "Hello, World!" followed by a newline.
</p>

<p style="text-align: justify;">
Essentially all executable code in Rust is placed in functions and called directly or indirectly from <code>main()</code>. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn square(x: f64) -> f64 {
    x * x
}

fn print_square(x: f64) {
    println!("the square of {} is {}", x, square(x));
}

fn main() {
    print_square(1.234); // prints: the square of 1.234 is 1.522756
}
{{< /prism >}}

<p style="text-align: justify;">
A <code>()</code> return type indicates that a function does not return a value.
</p>

## 2.4. Types, Variables, and Arithmetic
<p style="text-align: justify;">
Every name and every expression in Rust has a type that determines the operations that may be performed on it. For example, the declaration
</p>

{{< prism lang="rust">}}
let inch: i32;
{{< /prism >}}

<p style="text-align: justify;">
specifies that <code>inch</code> is of type <code>i32</code>; that is, <code>inch</code> is an integer variable.
</p>

<p style="text-align: justify;">
In Rust, a declaration is a statement that introduces a new name into the program and specifies the type associated with that name. This process is fundamental to defining and using data within a Rust program. Here’s a deeper look into the key concepts involved:
</p>

- <p style="text-align: justify;"><strong>Type:</strong> A type in Rust defines a set of possible values and the operations that can be performed on those values. For instance, the <code>i32</code> type represents a 32-bit signed integer and supports operations such as addition, subtraction, and comparison. Types provide a way to categorize and manage data, ensuring that operations are consistent with the kind of data being handled.</p>
- <p style="text-align: justify;"><strong>Object:</strong> An object refers to a piece of memory that stores a value of a specific type. In Rust, when you declare a variable, you are essentially allocating a block of memory to hold a value and associating that memory with a type. This memory holds the data that your program will work with.</p>
- <p style="text-align: justify;"><strong>Value:</strong> A value represents a set of bits stored in memory, interpreted according to its type. For example, if a variable is of type <code>u8</code>, the bits stored in memory are interpreted as an unsigned 8-bit integer. The value is how the raw bits in memory are understood and used based on the type definition.</p>
- <p style="text-align: justify;"><strong>Variable:</strong> A variable is essentially a named object. It is a reference to a specific piece of memory where a value of a given type is stored. By naming this object, you create a way to access and manipulate the data it holds throughout your program. For example, <code>let x: i32 = 5;</code> declares a variable <code>x</code> that is an <code>i32</code> object holding the value <code>5</code>.</p>
<p style="text-align: justify;">
A declaration in Rust not only introduces a name but also specifies the type of data that can be stored and manipulated. The type dictates the operations allowed, the object is the memory holding the value, the value is the interpreted set of bits, and the variable is the named reference to this object. Understanding these concepts is crucial for managing data and ensuring type safety in Rust programs.
</p>

<p style="text-align: justify;">
Rust offers a variety of fundamental types. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
bool // Boolean, possible values are true and false
char // character, for example, 'a', 'z', and '9'
i32 // 32-bit integer, for example, 1, 42, and 1066
f64` // double-precision floating-point number, for example, 3.14 and 299793.0
{{< /prism >}}

<p style="text-align: justify;">
Each fundamental type corresponds directly to hardware facilities and has a fixed size that determines the range of values that can be stored in it.
</p>

{{< prism lang="{figure} images\P8MKxO7NRG2n396LeSEs-Qv2pBisqZHsgb6GqSmro-v1.png" line-numbers="true">}}
:name: rSDVQKe7Pj
:align: center
:width: 70%

Fundamental types in Rust
{{< /prism >}}

<p style="text-align: justify;">
In Rust, the <code>char</code> type is used to represent a single Unicode scalar value, which encompasses most of the characters you might use, including letters, digits, and symbols from various languages and scripts. By design, a <code>char</code> in Rust is 4 bytes (32 bits) in size. This 32-bit size is chosen to accommodate the full range of Unicode characters, ensuring that each <code>char</code> can represent any valid Unicode scalar value.
</p>

<p style="text-align: justify;">
Other types in Rust, such as integers and floating-point numbers, also have sizes that are specified in multiples of bytes. For example, an <code>i32</code>, which is a 32-bit signed integer, typically occupies 4 bytes. This consistency in size helps in managing data efficiently and performing operations with predictable memory usage.
</p>

<p style="text-align: justify;">
The exact size of these types can be confirmed at runtime using the <code>std::mem::size_of</code> function. This function returns the size, in bytes, of the type you specify. For example, <code>std::mem::size_of::<char>()</code> usually returns 4, reflecting the 4-byte size of a <code>char</code>, and <code>std::mem::size_of::<i32>()</code> also typically returns 4, indicating the size of a 32-bit integer.
</p>

<p style="text-align: justify;">
It's important to note that while these sizes are generally consistent, they can vary depending on the target architecture and compilation settings. Different hardware architectures might have different requirements or optimizations that affect the size of data types. Therefore, while Rust provides a reliable default size, it’s always good to be aware of potential variations when working with different platforms or compilation configurations.
</p>

<p style="text-align: justify;">
In Rust, arithmetic operators can be used for appropriate combinations of types:
</p>

{{< prism lang="rust" line-numbers="true">}}
x + y  // addition
+x     // unary plus (rarely used)
x - y  // subtraction
-x     // unary minus
x * y  // multiplication
x / y  // division
x % y  // remainder (modulus) for integers
{{< /prism >}}
<p style="text-align: justify;">
Similarly, comparison operators are used to compare values:
</p>

{{< prism lang="rust" line-numbers="true">}}
x == y  // equal
x != y  // not equal
x < y   // less than
x > y   // greater than
x <= y  // less than or equal to
x >= y  // greater than or equal to
{{< /prism >}}
<p style="text-align: justify;">
In Rust, assignments and arithmetic operations perform meaningful conversions between basic types to allow for mixed operations:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn some_function() {
    let mut d: f64 = 2.2; // initialize floating-point number
    let mut i: i32 = 7; // initialize integer
    d = d + i as f64; // assign sum to d, converting i to f64
    println!("d after addition: {}", d);
    i = (d * i as f64) as i32; // assign product to i, converting to i32
    println!("i after multiplication: {}", i);
}

fn main() {
    some_function();
}
{{< /prism >}}
<p style="text-align: justify;">
Note that <code>=</code> is the assignment operator, and <code>==</code> tests equality.
</p>

<p style="text-align: justify;">
Rust offers a variety of notations for expressing initialization, such as the <code>=</code> used above, and a form based on curly-brace-delimited initializer lists:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let d1: f64 = 2.3;
    let d2: f64 = 2.3;

    // Representing complex numbers as tuples
    let z = (1.0, 0.0); // a complex number with double-precision floating-point scalars
    let z2 = (d1, d2);
    let z3 = (1.0, 2.0); // the = is implicit with new()

    let v = vec![1, 2, 3, 4, 5, 6]; // a vector of ints

    println!("z: {}+{}i", z.0, z.1);
    println!("z2: {}+{}i", z2.0, z2.1);
    println!("z3: {}+{}i", z3.0, z3.1);
    println!("v: {:?}", v);
}
{{< /prism >}}
<p style="text-align: justify;">
The <code>=</code> form is traditional and dates back to C, but if in doubt, use the general <code>vec![]</code> form. If nothing else, it saves you from conversions that lose information (narrowing conversions):
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let i1: i32 = 7.2 as i32; // i1 becomes 7
    // let i2: i32 = 7.2; // error: floating-point to integer conversion not allowed directly
    let i3: i32 = {7.2 as i32}; // the = is not redundant, but braces are unnecessary

    println!("i1: {}", i1);
    // println!("i2: {}", i2); // Uncommenting this line will cause a compilation error
    println!("i3: {}", i3);
}
{{< /prism >}}
<p style="text-align: justify;">
A constant cannot be left uninitialized and a variable should only be left uninitialized in extremely rare circumstances. Don’t introduce a name until you have a suitable value for it. User-defined types (such as <code>String</code>, <code>Vec</code>, <code>Matrix</code>, <code>MotorController</code>, and <code>OrcWarrior</code>) can be defined to be implicitly initialized.
</p>

<p style="text-align: justify;">
When defining a variable in Rust, you don't need to explicitly state its type if it can be inferred from the initializer:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let b = true; // a bool
    let ch = 'x'; // a char
    let i = 123; // an i32
    let d = 1.2; // an f64

    let y: f64 = 4.0; // explicitly specifying y as f64
    let z = y.sqrt(); // z will be of type f64

    println!("b: {}", b);
    println!("ch: {}", ch);
    println!("i: {}", i);
    println!("d: {}", d);
    println!("y: {}", y);
    println!("z: {}", z);
}
{{< /prism >}}
<p style="text-align: justify;">
We use the <code>let</code> syntax for initializing variables, allowing type inference to automatically determine the appropriate type without worrying about type conversion issues. Type inference is used when specifying the type explicitly isn’t necessary. This approach is typically employed unless there are specific reasons to use explicit type annotations. Such reasons might include scenarios where a variable is declared in a wide scope, making it important to clearly indicate the type for readability, or when precise control over a variable’s range or precision is required (such as choosing <code>f64</code> instead of <code>f32</code>). Using type inference minimizes redundancy and the need to write lengthy type names, which is particularly useful in generic programming where type names can become complex and verbose.
</p>

<p style="text-align: justify;">
In addition to the conventional arithmetic and logical operators, Rust offers specific operations for modifying a variable:
</p>

{{< prism lang="rust" line-numbers="true">}}
x += y; // x = x + y
x -= y; // x = x - y
x *= y; // scaling: x = x * y
x /= y; // scaling: x = x / y
x %= y; // x = x % y
x += 1; // increment: x = x + 1
x -= 1; // decrement: x = x - 1
{{< /prism >}}
<p style="text-align: justify;">
These operators are concise, convenient, and very frequently used in Rust.
</p>

## 2.5. Constants
<p style="text-align: justify;">
Rust supports immutability through two distinct mechanisms:
</p>

- <p style="text-align: justify;"><code>const</code>: This keyword is used to declare constants that are fixed at compile time and cannot be altered. By using <code>const</code>, you are guaranteeing that the value will remain unchanged throughout the program. The Rust compiler enforces this immutability, ensuring that the value is not modified after its initial definition.</p>
- <p style="text-align: justify;"><code>static</code>: This keyword allows for the declaration of global data that can either be mutable or immutable. When using <code>static</code>, if you need the global data to be mutable, it must be marked with <code>mut</code>. However, modifying mutable static variables requires using unsafe code, as it bypasses Rust's usual safety guarantees.</p>
<p style="text-align: justify;">
These mechanisms provide different ways to manage immutability and mutability in Rust, each with its own use cases and safety considerations. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
const DMV: i32 = 17; // DMV is a named constant

// const fn to allow use in constant expressions
const fn square(x: i32) -> i32 {
    x * x
}

const MAX1: f64 = 1.4 * square(DMV) as f64; // OK if square(17) is a constant expression
// const MAX2: f64 = 1.4 * square(var); // error: var is not a constant expression
// static MAX3: f64 = 1.4 * square(var) as f64; // error: static initializers must be constant

fn sum(v: &Vec<f64>) -> f64 {
    // sum will not modify its argument
    v.iter().sum()
}

fn main() {
    let var: i32 = 17; // var is not a constant
    let v = vec![1.2, 3.4, 4.5]; // v is not a constant
    let s1 = sum(&v); // OK: evaluated at run time
    // const S2: f64 = sum(&v); // error: sum(&v) not a constant expression

    println!("DMV: {}", DMV);
    println!("var: {}", var);
    println!("MAX1: {}", MAX1);
    // println!("MAX3: {}", MAX3); // MAX3 is not defined because var is not a constant
    println!("s1: {}", s1);
}
{{< /prism >}}
<p style="text-align: justify;">
To use a function in a constant expression, it must be defined with <code>const fn</code>. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
const fn square(x: i32) -> i32 {
    x * x
}
{{< /prism >}}
<p style="text-align: justify;">
A <code>const fn</code> in Rust must be straightforward and limited to computing a value with a single return statement. This restriction ensures that <code>const fn</code> can be evaluated at compile time, making it suitable for use in constant expressions. While a <code>const fn</code> can accept non-constant arguments, the result in such cases is not considered a constant expression. This flexibility allows a <code>const fn</code> to be utilized in both constant and non-constant contexts without the need to define separate functions for each scenario.
</p>

<p style="text-align: justify;">
Certain situations in Rust require constant expressions due to language rules, such as defining array bounds, match arms, and specific constant declarations. Compile-time evaluation is also crucial for performance optimization, allowing calculations to be performed ahead of time rather than at runtime. Beyond performance considerations, immutability—where an object’s state remains unchanged—is a key design principle in Rust. This principle underpins Rust's approach to safety and reliability, ensuring that data integrity is maintained throughout a program's execution.
</p>

## 2.6. Tests and Loops
<p style="text-align: justify;">
Rust provides a conventional set of statements for expressing selection and looping. For example, here is a simple function that prompts the user and returns a boolean indicating the response:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, Write};

fn accept() -> bool {
    print!("Do you want to proceed (y or n)? ");
    io::stdout().flush().unwrap(); // ensure the question is printed immediately
    let mut answer = String::new();
    io::stdin().read_line(&mut answer).unwrap();
    if answer.trim().eq_ignore_ascii_case("y") {
        return true;
    }
    false
}

fn main() {
    if accept() {
        println!("Proceeding...");
    } else {
        println!("Operation cancelled.");
    }
}
{{< /prism >}}
<p style="text-align: justify;">
To improve the function by taking an 'n' (for "no") answer into account:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, Write};

fn accept2() -> bool {
    print!("Do you want to proceed (y or n)? ");
    io::stdout().flush().unwrap(); // ensure the question is printed immediately
    let mut answer = String::new();
    io::stdin().read_line(&mut answer).unwrap();
    match answer.trim().to_lowercase().as_str() {
        "y" => true,
        "n" => false,
        _ => {
            println!("I'll take that for a no.");
            false
        }
    }
}

fn main() {
    if accept2() {
        println!("Proceeding...");
    } else {
        println!("Operation cancelled.");
    }
}
{{< /prism >}}
<p style="text-align: justify;">
A match statement tests a value against a set of patterns. The patterns must be distinct, and if the value tested does not match any of them, the default pattern (<code>_</code>) is chosen. If no default pattern is provided, no action is taken if the value doesn’t match any case pattern.
</p>

<p style="text-align: justify;">
Few programs are written without loops. For example, we might want to give the user a few tries to produce acceptable input:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, Write};

fn accept3() -> bool {
    let mut tries = 1;
    while tries <= 3 {
        print!("Do you want to proceed (y or n)? ");
        io::stdout().flush().unwrap(); // ensure the question is printed immediately
        let mut answer = String::new();
        io::stdin().read_line(&mut answer).unwrap();
        match answer.trim().to_lowercase().as_str() {
            "y" => return true,
            "n" => return false,
            _ => {
                println!("Sorry, I don't understand that.");
                tries += 1; // increment
            }
        }
    }
    println!("I'll take that for a no.");
    false
}

fn main() {
    if accept3() {
        println!("Proceeding...");
    } else {
        println!("Operation cancelled.");
    }
}
{{< /prism >}}
<p style="text-align: justify;">
The <code>while</code> statement executes until its condition becomes false.
</p>

## 2.7. Pointers, Arrays, and Loops
<p style="text-align: justify;">
An array of elements of type <code>char</code> can be declared like this in Rust:
</p>

{{< prism lang="rust">}}
let b: [char; 6]; // array of 6 characters
{{< /prism >}}
<p style="text-align: justify;">
Similarly, a pointer can be declared like this in Rust:
</p>

{{< prism lang="rust">}}
let a: *const char; // pointer to a character
{{< /prism >}}
<p style="text-align: justify;">
In declarations, <code>[]</code> means "array of" and <code>*const</code> means "pointer to". All arrays have 0 as their lower bound, so <code>b</code> has six elements, <code>v[0]</code> to <code>v[5]</code>. The size of an array must be a constant expression. A pointer variable can hold the address of an element of the appropriate type:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let b: [char; 6] = ['0', '1', '2', '3', '4', '5'];
    let a: *const char = &b[3]; // a points to b’s fourth element (index 3)
    
    // Dereference a to get the object it points to
    let x: char = unsafe { *a }; 

    println!("The character at index 3 is: {}", x);
}
{{< /prism >}}
<p style="text-align: justify;">
In Rust, dereferencing a raw pointer requires an <code>unsafe</code> block because raw pointers bypass the language's usual safety guarantees. Unlike references, raw pointers do not enforce borrowing rules or guarantee that the memory they point to is valid, which could lead to undefined behavior if misused. By requiring an <code>unsafe</code> block, Rust ensures that developers explicitly acknowledge and take responsibility for the potential risks involved in manipulating raw pointers, such as accessing uninitialized memory or causing data races, thereby reinforcing the language's commitment to safety and preventing inadvertent unsafe operations.
</p>

{{< prism lang="{figure} images\P8MKxO7NRG2n396LeSEs-kU9amdLwJ3QZfYnTmaWW-v1.png" line-numbers="true">}}
:name: ISTZCLsC75
:align: center
:width: 70%

Unsafe dereferencing of a raw pointer in Rust.
{{< /prism >}}
<p style="text-align: justify;">
Consider copying ten elements from one array to another in Rust:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn copy_fct() {
    let v1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut v2 = [0; 10]; // to become a copy of v1
    for i in 0..10 { // copy elements
        v2[i] = v1[i];
    }
    // Printing to verify the result
    println!("v1: {:?}", v1);
    println!("v2: {:?}", v2);
}

fn main() {
    copy_fct();
}
{{< /prism >}}
<p style="text-align: justify;">
This <code>for</code> statement can be read as "set <code>i</code> to zero; while <code>i</code> is less than 10, copy the <code>i</code>th element and increment <code>i</code>." When applied to an integer variable, the increment operator, <code>+= 1</code>, simply adds 1.
</p>

<p style="text-align: justify;">
Rust also offers a simpler <code>for</code> loop for iterating over a sequence in the easiest way:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn print_arrays() {
    let v = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    
    // Iterating over the elements of v
    for x in v.iter() { // for each x in v
        println!("{}", x);
    }
    
    // Iterating over a slice of values
    for x in &[10, 21, 32, 43, 54, 65] {
        println!("{}", x);
    }
}

fn main() {
    print_arrays();
}
{{< /prism >}}
<p style="text-align: justify;">
The first <code>for</code> loop can be read as "for every element in <code>v</code>, from the first to the last, place a reference in <code>x</code> and print it." Note that we don't have to specify an array size when we initialize it with a list. The <code>for</code> loop can be used for any sequence of elements.
</p>

<p style="text-align: justify;">
If we didn’t want to copy the values from <code>v</code> into the variable <code>x</code>, but rather just have <code>x</code> refer to an element, we could write:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn increment() {
    let mut v = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    
    for x in &mut v {
        *x += 1;
    }
    
    // Printing the modified array to verify the result
    for x in &v {
        println!("{}", x);
    }
}

fn main() {
    increment();
}
{{< /prism >}}
<p style="text-align: justify;">
In a declaration, the prefix <code>&</code> means "reference to." A reference is similar to a pointer, except that you don’t need to use a prefix <code><strong></code> to access the value referred to by the reference. Also, a reference cannot be made to refer to a different object after its initialization. When used in declarations, operators (such as <code>&</code>, <code></strong></code>, and <code>[]</code>) are called declarator operators:
</p>

{{< prism lang="rust" line-numbers="true">}}
let a: [T; n];    // [T; n]: array of n Ts
let p: *const T;  // *const T: pointer to T
let r: &T;        // &T: reference to T
fn f(a: A) -> T;  // fn(A) -> T: function taking an argument of type A and returning a result of type T
{{< /prism >}}
<p style="text-align: justify;">
We try to ensure that a pointer always points to an object, so that dereferencing it is valid. When we don’t have an object to point to or if we need to represent the notion of "no object available" (e.g., for an end of a list), we give the pointer the value <code>None</code> (the equivalent of a null pointer in Rust). There is only one <code>None</code> shared by all pointer types:
</p>

{{< prism lang="rust" line-numbers="true">}}
let pd: Option<*const f64> = None;
let lst: Option<*const Link<Record>> = None; // pointer to a Link to a Record
// let x: i32 = None; // error: None is a pointer, not an integer
{{< /prism >}}
<p style="text-align: justify;">
It is often wise to check that a pointer argument that is supposed to point to something actually points to something:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::os::raw::c_char;

fn count_x(p: *const c_char, x: c_char) -> i32 {
    // Count the number of occurrences of x in p[]
    // p is assumed to point to a null-terminated array of c_char (or to nothing)
    if p.is_null() {
        return 0;
    }
    let mut count = 0;
    unsafe {
        let mut ptr = p;
        while *ptr != 0 {
            if *ptr == x {
                count += 1;
            }
            ptr = ptr.add(1); // move pointer to the next element
        }
    }
    count
}

fn main() {
    // Example usage
    let c_str = std::ffi::CString::new("hello world").unwrap();
    let c_ptr = c_str.as_ptr();

    let count = count_x(c_ptr, 'o' as c_char);
    println!("The character 'o' appears {} times.", count);
}
{{< /prism >}}
<p style="text-align: justify;">
Notice that we can advance a pointer to the next element in an array using <code>p.add(1)</code>. Additionally, in a <code>for</code> loop, the initializer can be omitted if it's not needed. The <code>count_x()</code> function is defined with the assumption that the <code>*const char</code> is a C-style string, which means the pointer refers to a null-terminated array of <code>char</code>. In older codebases, <code>0</code> or <code>NULL</code> was commonly used instead of <code>None</code>. However, using <code>None</code> helps avoid confusion between integers like <code>0</code> or <code>NULL</code> and pointers represented by <code>None</code>, making the code clearer and more consistent.
</p>

## 2.8. User-Defined Types
<p style="text-align: justify;">
In Rust, built-in types are fundamental constructs such as integers, floating-point numbers, characters, and booleans. These types are designed to be close to the hardware, which means they are efficient and directly reflect the capabilities of the underlying computer architecture. For instance, an <code>i32</code> is a 32-bit signed integer, and <code>f64</code> is a 64-bit floating-point number. They provide essential operations and are optimized for performance but are limited in their ability to represent more complex data structures or higher-level abstractions.
</p>

<p style="text-align: justify;">
To address these limitations, Rust provides mechanisms for creating user-defined types. These types are constructed using the built-in types and allow for more sophisticated data modeling. User-defined types in Rust primarily include <code>structs</code> and <code>enums</code>.
</p>

<p style="text-align: justify;">
<code>Structs</code> allow developers to bundle multiple related pieces of data into a single entity. For example, you might use a <code>struct</code> to represent a <code>Point</code> in a 2D space, encapsulating both x and y coordinates. This grouping of data into a coherent unit makes it easier to manage and work with complex data structures in a more intuitive way.
</p>

<p style="text-align: justify;">
<code>Enums</code>, on the other hand, allow you to define a type that can be one of several possible variants. This is useful for representing a value that could be different types of things. For example, an <code>enum</code> might represent various shapes, like circles and rectangles, where each variant holds different data relevant to that shape. This allows for a clear and type-safe way to handle different cases in your code.
</p>

<p style="text-align: justify;">
Rust’s abstraction mechanisms enable the creation of high-level constructs that can model complex systems or data structures, extending the capabilities of built-in types. By defining these user-defined types, programmers can encapsulate data and functionality in a manner that fits the specific needs of their application, leading to more readable, maintainable, and expressive code.
</p>

<p style="text-align: justify;">
These abstractions are crucial for developing robust and sophisticated software, as they allow programmers to build and use types that go beyond the limitations of the basic built-in types. Rust's standard library exemplifies these capabilities with a wide range of user-defined types and abstractions that demonstrate how the language's features can be used to create powerful and flexible software solutions.
</p>

## 2.9. Structures
<p style="text-align: justify;">
The first step in building a new type is often to organize the elements it needs into a data structure, a struct:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Vector {
    sz: usize,     // number of elements
    elem: *mut f64, // pointer to elements
}
{{< /prism >}}
<p style="text-align: justify;">
This first version of <code>Vector</code> consists of a <code>usize</code> and a <code>*mut f64</code>.
</p>

<p style="text-align: justify;">
A variable of type <code>Vector</code> can be defined like this in Rust:
</p>

{{< prism lang="rust" line-numbers="true">}}
let v = Vector {
    sz: 0,
    elem: std::ptr::null_mut(),
};
{{< /prism >}}
<p style="text-align: justify;">
However, by itself, that is not of much use because <code>v</code>’s <code>elem</code> pointer doesn’t point to anything. To be useful, we must give <code>v</code> some elements to point to. For example, we can construct a <code>Vector</code> like this:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn vector_init(v: &mut Vector, s: usize) {
    v.elem = vec![0.0; s].into_boxed_slice().as_mut_ptr(); // allocate an array of s doubles
    v.sz = s;
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>v</code>’s <code>elem</code> member gets a pointer produced by allocating a <code>Vec</code> and converting it to a raw pointer, and <code>v</code>’s <code>sz</code> member gets the number of elements. The <code>&mut Vector</code> indicates that we pass <code>v</code> by mutable reference so that <code>vector_init()</code> can modify the vector passed to it.
</p>

<p style="text-align: justify;">
The <code>vec!</code> macro allocates memory from an area called the heap (also known as dynamic memory).
</p>

<p style="text-align: justify;">
There is a long way to go before our <code>Vector</code> is as elegant and flexible as the standard library's <code>Vec</code>. In particular, a user of <code>Vector</code> has to know every detail of <code>Vector</code>'s representation. The rest of this section and the next gradually improve <code>Vector</code> as an example of language features and techniques.
</p>

<p style="text-align: justify;">
We use <code>Vec</code> and other standard library components as examples:
</p>

- <p style="text-align: justify;">to illustrate language features and design techniques, and</p>
- <p style="text-align: justify;">to help you learn and use the standard library components.</p>
<p style="text-align: justify;">
The emphasis on using standard library components, like <code>Vec</code> and <code>String</code>, rather than creating your own implementations, is important because these components have been thoroughly tested and optimized by the Rust community. They come with guarantees of performance and safety that custom implementations might not. Moreover, reinventing these components can lead to unnecessary complexity and potential errors, whereas using the standard library versions ensures you benefit from decades of collective expertise and robust design.
</p>

<p style="text-align: justify;">
We use <code>.</code> (dot) to access struct members through a name (and through a reference) and <code>*</code> to dereference a pointer to access struct members. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(v: Vector, rv: &Vector, pv: *const Vector) {
    let i1 = v.sz; // access through name
    let i2 = rv.sz; // access through reference
    let i3 = unsafe { (*pv).sz }; // access through pointer
}
{{< /prism >}}
<p style="text-align: justify;">
In Rust, accessing struct members through a name or reference is straightforward with the <code>.</code> operator. When accessing through a pointer, we use the <code>*</code> operator to dereference the pointer and then access the member. The <code>unsafe</code> block is necessary because dereferencing raw pointers is considered unsafe in Rust.
</p>

## 2.10. Structs in Rust
<p style="text-align: justify;">
Separating data from the operations performed on it has its benefits, such as offering flexibility in how the data can be utilized. However, for a user-defined type to fully embody the characteristics of a "real type," a more integrated approach is necessary, where the data’s representation is closely tied to its operations. This integration helps in maintaining data integrity, ensuring consistent usage, and allowing future enhancements to the representation without exposing internal details to users.
</p>

<p style="text-align: justify;">
To achieve this, Rust uses the concept of a <code>struct</code> with associated functions. A <code>struct</code> in Rust can include various fields, and you can define methods to manipulate these fields. The public methods of a <code>struct</code> define its interface, which users interact with, while the private fields remain hidden from direct access. This design ensures that all interactions with the <code>struct</code> are mediated through its defined methods, maintaining control over how the data is accessed and modified.For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Vector {
    elem: Box<[f64]>, // pointer to the elements
    sz: usize,        // the number of elements
}

impl Vector {
    // Constructor to create a new Vector
    fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(), // Allocate elements on the heap
            sz: s,
        }
    }

    // Method to get the element at a given index
    fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    // Method to set the element at a given index
    fn set(&mut self, i: usize, value: f64) {
        self.elem[i] = value;
    }

    // Method to get the size of the Vector
    fn size(&self) -> usize {
        self.sz
    }
}

fn main() {
    // Create a new Vector of size 6
    let mut vec = Vector::new(6);

    // Set values in the Vector
    for i in 0..vec.size() {
        vec.set(i, i as f64);
    }

    // Get and print values from the Vector
    for i in 0..vec.size() {
        println!("vec[{}] = {}", i, vec.get(i));
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Given that, we can define a variable of our new type <code>Vector</code>:
</p>

{{< prism lang="rust">}}
let mut v = Vector::new(6); // a Vector with 6 elements
{{< /prism >}}
<p style="text-align: justify;">
In this example, the <code>Vector</code> struct has private fields (<code>elem</code> and <code>sz</code>) and public methods (<code>new</code>, <code>get</code>, <code>set</code>, and <code>size</code>) that provide controlled access to the data. This encapsulation ensures that the data can only be accessed and modified in intended ways, allowing for future improvements to the implementation without affecting the interface.
</p>

<p style="text-align: justify;">
We can illustrate a <code>Vector</code> object graphically:
</p>

{{< prism lang="{figure} images\P8MKxO7NRG2n396LeSEs-htidjDEZZtzXYAx4UQE0-v1.png" line-numbers="true">}}
:name: UBWuMBmfLf
:align: center
:width: 70%

Vector implementation in Rust.
{{< /prism >}}
<p style="text-align: justify;">
Essentially, the <code>Vector</code> object acts as a "handle" that contains a pointer to the elements (<code>elem</code>) and the number of elements (<code>sz</code>). The number of elements (6 in this example) can differ between <code>Vector</code> objects and can change over time for a given <code>Vector</code> object. Despite this variability, the <code>Vector</code> object itself maintains a consistent size. This approach, where a fixed-size handle manages a variable amount of data stored elsewhere, is a fundamental technique in Rust for managing dynamic information. Understanding how to design and use such objects is a key aspect of Rust programming.
</p>

<p style="text-align: justify;">
In Rust, the representation of a <code>Vector</code> (with fields <code>elem</code> and <code>sz</code>) is only accessible through the interface provided by the public methods: <code>new()</code>, <code>get()</code>, and <code>size()</code>. The <code>read_and_sum()</code> example can be simplified as follows:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Vector {
    elem: Box<[f64]>, // pointer to the elements
    sz: usize,        // the number of elements
}

impl Vector {
    // Constructor to create a new Vector
    fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(), // Allocate elements on the heap
            sz: s,
        }
    }

    // Method to get the element at a given index
    fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    // Method to set the element at a given index
    fn set(&mut self, i: usize, value: f64) {
        self.elem[i] = value;
    }

    // Method to get the size of the Vector
    fn size(&self) -> usize {
        self.sz
    }
}

fn read_and_sum(s: usize) -> f64 {
    let mut v = Vector::new(s); // create a vector with s elements
    for i in 0..v.size() {
        let mut input = String::new();
        std::io::stdin().read_line(&mut input).expect("Failed to read line");
        v.set(i, input.trim().parse().expect("Please enter a number"));
    }
    let mut sum = 0.0;
    for i in 0..v.size() {
        sum += v.get(i);
    }
    sum
}

fn main() {
    let s = 5; // Specify the number of elements to read
    println!("Enter {} numbers:", s);
    let sum = read_and_sum(s);
    println!("The sum of the entered numbers is: {}", sum);
}
{{< /prism >}}
<p style="text-align: justify;">
A function with the same name as its struct, such as <code>new()</code>, acts as a constructor and is used to create instances of the struct. Thus, <code>Vector::new()</code> replaces the need for a manual initialization function. Constructors ensure that instances of the struct are properly initialized, solving the issue of uninitialized variables.
</p>

<p style="text-align: justify;">
The <code>Vector::new(usize)</code> method defines how to create <code>Vector</code> objects. It requires an integer input, which specifies the number of elements the <code>Vector</code> should have. This integer is used to determine the size of the <code>Vector</code>. The constructor initializes the <code>Vector</code> fields using a member initializer list:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, Write}; // Import necessary modules

// Define the Vector struct
struct Vector {
    elem: Box<[f64]>, // Pointer to the elements
    sz: usize,        // Number of elements
}

impl Vector {
    // Constructor to create a new Vector
    fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(), // Allocate elements on the heap
            sz: s,
        }
    }

    // Method to get the element at a given index
    fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    // Method to set the element at a given index
    fn set(&mut self, i: usize, value: f64) {
        self.elem[i] = value;
    }

    // Method to get the size of the Vector
    fn size(&self) -> usize {
        self.sz
    }
}

// Function to read values into the Vector and compute the sum
fn read_and_sum(s: usize) -> f64 {
    let mut v = Vector::new(s); // Create a Vector with s elements
    for i in 0..v.size() {
        print!("Enter number {}: ", i + 1);
        io::stdout().flush().unwrap(); // Ensure the prompt is displayed immediately
        let mut input = String::new();
        io::stdin().read_line(&mut input).expect("Failed to read line");
        v.set(i, input.trim().parse().expect("Please enter a valid number"));
    }
    let mut sum = 0.0;
    for i in 0..v.size() {
        sum += v.get(i);
    }
    sum
}

// Main function to demonstrate the usage
fn main() {
    let s = 5; // Specify the number of elements to read
    println!("You will enter {} numbers.", s);
    let sum = read_and_sum(s);
    println!("The sum of the entered numbers is: {}", sum);
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>elem</code> is first initialized with a pointer to an array of <code>s</code> elements of type <code>f64</code>, allocated on the heap. After that, <code>sz</code> is set to <code>s</code>.
</p>

<p style="text-align: justify;">
Element access is provided by a method called \<code>get\</code>, which returns a reference to the specified element (\<code>&f64\</code>). The \<code>size\</code> method allows users to retrieve the number of elements in the vector.
</p>

## 2.11. Enumerations in Rust
<p style="text-align: justify;">
Besides structs, Rust offers a simple user-defined type called an enum, which allows us to list possible values:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Define the Color enum
enum Color {
    Red,
    Blue,
    Green,
}

// Define the TrafficLight enum
enum TrafficLight {
    Green,
    Yellow,
    Red,
}

fn main() {
    // Create instances of the enums
    let col = Color::Red;
    let light = TrafficLight::Red;

    // Match and print the values to demonstrate usage
    match col {
        Color::Red => println!("Color is Red"),
        Color::Blue => println!("Color is Blue"),
        Color::Green => println!("Color is Green"),
    }

    match light {
        TrafficLight::Green => println!("Traffic light is Green"),
        TrafficLight::Yellow => println!("Traffic light is Yellow"),
        TrafficLight::Red => println!("Traffic light is Red"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In Rust, the variants (e.g., <code>Red</code>) are scoped within their respective enums, enabling them to be used in multiple enums without conflict. For example, <code>Color::Red</code> is separate from <code>TrafficLight::Red</code>.
</p>

<p style="text-align: justify;">
Enums in Rust are a powerful feature for defining a type that can be one of several different variants, each with its own specific value or structure. They are particularly useful for representing small, fixed sets of potential values, such as states in a state machine, options in a configuration, or different types of messages in a communication protocol.
</p>

<p style="text-align: justify;">
One of the primary benefits of using enums is the clarity they bring to the code. Instead of relying on simple integers or other primitive types, enums use symbolic and descriptive names for each variant. This not only makes the code more readable but also helps reduce errors. For instance, instead of using numeric constants like <code>0</code>, <code>1</code>, and <code>2</code> to represent different states, you can use descriptive names like <code>Pending</code>, <code>Processing</code>, and <code>Completed</code>. This makes the code self-documenting and easier to understand, minimizing the likelihood of mistakes due to misinterpretation of what each value represents.
</p>

<p style="text-align: justify;">
Rust enums are strongly typed, meaning that each variant is associated with a specific enum type. This strong typing prevents accidental misuse of constants and ensures that values from different enums cannot be mixed up. For example, if you have an enum <code>Status</code> with variants <code>Active</code>, <code>Inactive</code>, and <code>Pending</code>, you cannot accidentally assign a variant from another enum, like <code>Error</code>, to a variable of type <code>Status</code>. This strong type safety helps catch errors at compile time, making your code more robust and less prone to bugs.
</p>

<p style="text-align: justify;">
In addition to improving type safety and code clarity, Rust enums support pattern matching, which allows you to handle different variants in a concise and expressive manner. This feature, combined with the strong typing, makes enums a versatile and essential tool for writing clean, maintainable Rust code.
</p>

<p style="text-align: justify;">
By default, an enum in Rust supports basic operations like assignment, initialization, and comparisons (e.g., <code>==</code> and <code><</code>). Since an enum is a user-defined type, we can also add custom methods to it:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Define the TrafficLight enum
enum TrafficLight {
    Green,
    Yellow,
    Red,
}

// Implement the TrafficLight enum with a custom method
impl TrafficLight {
    fn next(&self) -> TrafficLight {
        match self {
            TrafficLight::Green => TrafficLight::Yellow,
            TrafficLight::Yellow => TrafficLight::Red,
            TrafficLight::Red => TrafficLight::Green,
        }
    }
}

fn main() {
    let light = TrafficLight::Red;
    let next = light.next(); // next becomes TrafficLight::Green

    // Print the current and next traffic light states
    match light {
        TrafficLight::Green => println!("Current light is Green"),
        TrafficLight::Yellow => println!("Current light is Yellow"),
        TrafficLight::Red => println!("Current light is Red"),
    }

    match next {
        TrafficLight::Green => println!("Next light is Green"),
        TrafficLight::Yellow => println!("Next light is Yellow"),
        TrafficLight::Red => println!("Next light is Red"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Rust’s enum system differs significantly from that of C++ in terms of type safety and scope. In C++, plain enums are essentially named integer constants and do not enforce strict typing. This means that the values of a plain enum are treated as simple integers, which can lead to potential issues such as inadvertently mixing values from different enums or misusing these values inappropriately. The lack of strict type enforcement in C++ means that values from one enum can be mistakenly assigned to a variable of another enum type or used in unintended ways, potentially leading to errors or undefined behavior.
</p>

<p style="text-align: justify;">
In contrast, Rust’s enums are strongly typed and scoped. Each enum in Rust is a distinct type with its own set of well-defined variants. This strong typing ensures that each enum’s variants are strictly tied to the enum type itself, preventing any accidental mixing with variants from other enums or direct use of raw integer values. Rust’s type system enforces that you use only the defined variants of the enum, which adds a layer of safety and clarity to the code. This strict enforcement helps to avoid common mistakes, ensures more predictable behavior, and improves the overall robustness of the code.
</p>

<p style="text-align: justify;">
By maintaining this strong typing and scoping, Rust provides a more controlled and error-resistant approach to working with enums, in contrast to the more permissive and less type-safe handling found in C++.
</p>

## 2.12. Modularity
<p style="text-align: justify;">
In Rust, a program is typically made up of various components like functions, user-defined types, trait implementations, and generics. Each of these components plays a specific role and contributes to the overall functionality of the program. Effectively managing these components requires a clear understanding of how they interact with one another and how they are organized within the code.
</p>

<p style="text-align: justify;">
One of the most important aspects of managing these components is distinguishing between the interface and the implementation of each part. The interface of a component is essentially its public contract—it defines what a function or type is and what it does, including its public methods and how it should be used by other parts of the program. This is done through declarations, which include function signatures, type definitions, and trait declarations. These declarations provide all the necessary information needed to interact with the component without revealing the internal workings or details of how it is implemented.
</p>

<p style="text-align: justify;">
On the other hand, the implementation of a component encompasses the actual code that performs the operations and provides the functionality. It includes the specific logic of functions, the internal structure of types, and the actual code for trait methods. The implementation details are kept separate from the interface to encapsulate how the functionality is achieved, which allows for modifications and improvements to the internal workings without affecting the parts of the program that rely on the component's interface.
</p>

<p style="text-align: justify;">
This separation of interface and implementation not only promotes modularity and reusability but also enhances maintainability. By adhering to this principle, you can ensure that components are used correctly according to their defined contracts, while their internal details remain hidden and protected. This approach helps in managing complexity and ensures that changes to one part of the program do not inadvertently break other parts, thereby fostering a more robust and organized codebase. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Import the necessary module for the sqrt function
use std::f64;

// Define the sqrt function
fn sqrt(x: f64) -> f64 {
    x.sqrt()
}

// Define the Vector struct
struct Vector {
    elem: Box<[f64]>, // elem points to an array of f64s
    sz: usize,
}

impl Vector {
    // Constructor to create a new Vector
    fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(), // Allocate elements on the heap
            sz: s,
        }
    }

    // Method to get the element at a given index
    fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    // Method to get the size of the Vector
    fn size(&self) -> usize {
        self.sz
    }
}

fn main() {
    // Create a new Vector of size 5
    let vec = Vector::new(5);

    // Print the size of the Vector
    println!("Size of the vector: {}", vec.size());

    // Example usage of the sqrt function
    let value = 16.0;
    println!("The square root of {} is {}", value, sqrt(value));

    // Get and print elements from the Vector
    for i in 0..vec.size() {
        println!("vec[{}] = {}", i, vec.get(i));
    }
}
{{< /prism >}}
<p style="text-align: justify;">
The important point is that the bodies of the functions, or their definitions, are separate from their declarations. In this example, the implementation of <code>sqrt()</code> would be defined elsewhere, but let's focus on the <code>Vector</code> struct for now. We define all the methods for <code>Vector</code> like this:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Vector {
    fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(),
            sz: s,
        }
    }

    fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    fn size(&self) -> usize {
        self.sz
    }
}
{{< /prism >}}
<p style="text-align: justify;">
We must define the methods for <code>Vector</code>, just as we define the <code>sqrt()</code> function, even though <code>sqrt()</code> might be provided by a standard library. The functions in the standard library are essentially "other code we use," created using the same language features that we use.
</p>

<p style="text-align: justify;">
Here’s the complete code with the <code>Vector</code> struct and its methods:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Import the necessary module for the sqrt function
use std::f64;

// Define the sqrt function
fn sqrt(x: f64) -> f64 {
    x.sqrt()
}

// Define the Vector struct
struct Vector {
    elem: Box<[f64]>, // elem points to an array of f64s
    sz: usize,
}

impl Vector {
    // Constructor to create a new Vector
    fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(), // Allocate elements on the heap
            sz: s,
        }
    }

    // Method to get the element at a given index
    fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    // Method to get the size of the Vector
    fn size(&self) -> usize {
        self.sz
    }
}

fn main() {
    // Create a new Vector of size 5
    let vec = Vector::new(5);

    // Print the size of the Vector
    println!("Size of the vector: {}", vec.size());

    // Example usage of the sqrt function
    let value = 16.0;
    println!("The square root of {} is {}", value, sqrt(value));

    // Get and print elements from the Vector
    for i in 0..vec.size() {
        println!("vec[{}] = {}", i, vec.get(i));
    }
}
{{< /prism >}}
## 2.13. Separate Compilation
<p style="text-align: justify;">
Rust’s support for separate compilation is a key feature that enhances modularity, organization, and efficiency in programming. This approach allows a Rust program to be divided into multiple source files, each handling different parts of the code. By compiling these parts independently, Rust promotes a clear separation of concerns and improves overall code management.
</p>

<p style="text-align: justify;">
In practice, separate compilation means that the declarations of types and functions are made visible to the rest of the program, while the detailed definitions of these types and functions are kept in separate source files. This means that when you use a function or type from another part of your code or from an external library, you only need to know its public interface—the declarations that specify what the function or type does and how to interact with it. The actual implementation, which includes the detailed code and logic, resides in different source files.
</p>

<p style="text-align: justify;">
This modular approach has several advantages. It helps in organizing the program into semi-independent units, which makes it easier to manage and understand. Each module or source file can focus on a specific aspect of the program, reducing complexity and making the codebase more maintainable. Additionally, by compiling modules separately, Rust reduces compilation times, as changes in one part of the code do not require recompiling the entire program. Instead, only the modified parts and their dependencies are recompiled.
</p>

<p style="text-align: justify;">
Libraries in Rust follow the same principle of separate compilation. Libraries are collections of functions, types, and other code segments that are compiled independently from the main program. When you use a library, you interact with it through its public interface, which is defined in its declarations. The internal details of the library are encapsulated and managed separately, ensuring a clean and efficient integration.
</p>

<p style="text-align: justify;">
Overall, separate compilation in Rust fosters a well-organized code structure, enhances modularity, and improves build efficiency, while also enforcing a clear separation between different parts of the program. This not only helps in minimizing errors but also makes large and complex codebases more manageable and scalable.
</p>

<p style="text-align: justify;">
Typically, we place the declarations that define a module's interface in a file named to reflect its purpose. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Vector.rs
pub struct Vector {
    elem: Box<[f64]>,
    sz: usize,
}

impl Vector {
    pub fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(),
            sz: s,
        }
    }

    pub fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    pub fn size(&self) -> usize {
        self.sz
    }
}
{{< /prism >}}
<p style="text-align: justify;">
This declaration would go in a file named <code>vector.rs</code>, and users would import this module to use its interface. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Main.rs
mod Vector;
use Vector::Vector;
use std::f64::consts::SQRT_2; // example of using a standard library constant

fn sqrt_sum(v: &Vector) -> f64 {
    let mut sum = 0.0;
    for i in 0..v.size() {
        sum += v.get(i).sqrt(); // sum of square roots
    }
    sum
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>Vector.rs</code> contains the definition of the <code>Vector</code> struct and its methods, while <code>Main.rs</code> imports this module to utilize <code>Vector</code>. The <code>use</code> keyword brings items from the module and the standard library into scope, making them available in the code.
</p>

<p style="text-align: justify;">
To ensure consistency, the <code>Vector.rs</code> file that provides the implementation of <code>Vector</code> also includes the module declaration for its interface:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Vector.rs
pub struct Vector {
    elem: Box<[f64]>,
    sz: usize,
}

impl Vector {
    pub fn new(s: usize) -> Vector {
        Vector {
            elem: vec![0.0; s].into_boxed_slice(),
            sz: s,
        }
    }

    pub fn get(&self, i: usize) -> f64 {
        self.elem[i]
    }

    pub fn size(&self) -> usize {
        self.sz
    }
}
{{< /prism >}}
<p style="text-align: justify;">
The <code>Main.rs</code> file will import this module to use the <code>Vector</code> interface:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Main.rs
mod Vector;
use Vector::Vector;

fn main() {
    let v = Vector::new(10);
    println!("Size: {}", v.size());
    for i in 0..v.size() {
        println!("Element {}: {}", i, v.get(i));
    }
}

fn sqrt_sum(v: &Vector) -> f64 {
    let mut sum = 0.0;
    for i in 0..v.size() {
        sum += v.get(i).sqrt(); // sum of square roots
    }
    sum
}
{{< /prism >}}
<p style="text-align: justify;">
In this setup, <code>Main.rs</code> and <code>Vector.rs</code> share the <code>Vector</code> interface information defined in <code>Vector.rs</code>, but the two files are otherwise independent and can be compiled separately. This modular approach allows for separate compilation and maintains the independence of program components.
</p>

{{< prism lang="{figure} images\P8MKxO7NRG2n396LeSEs-Dx2q7fIbxugxD2wtXfax-v1.png" line-numbers="true">}}
:name: O4UPXvXezE
:align: center
:width: 50%

Modular design of Vector implementation.
{{< /prism >}}
<p style="text-align: justify;">
Separate compilation is a concept that extends beyond the specifics of any one programming language. Instead, it relates to how a language's features and implementation can be used to manage and compile code in a modular and efficient way. While the underlying principle is not unique to Rust or any other language, Rust provides robust mechanisms to support and enhance this practice.
</p>

<p style="text-align: justify;">
The practical importance of separate compilation lies in its ability to improve code organization, maintainability, and build efficiency. To fully leverage separate compilation, it's essential to approach it through a combination of modularity and organization.
</p>

- <p style="text-align: justify;">Modularity is a key aspect here. It involves breaking down a program into smaller, manageable units or components that can be developed and tested independently. In Rust, this is achieved through constructs such as modules and crates. Modules are used to logically group related functions, types, and constants within a single file or across multiple files, while crates serve as the primary unit of code distribution and compilation, encapsulating related modules and other resources.</p>
- <p style="text-align: justify;">Logical Representation of modularity is accomplished through the language’s features. In Rust, you define modules and crates to represent different parts of your program. Modules allow you to organize code within a file or across files, while crates represent a package of code that can be compiled and used independently. This logical separation helps you manage code more effectively by keeping related functionalities together and maintaining clear boundaries between different parts of the codebase.</p>
## 2.14. Modules
<p style="text-align: justify;">
In addition to functions, structs, and enums, Rust offers modules as a way to group related declarations and prevent name clashes. For example, you might want to experiment with your own complex number type:
</p>

{{< prism lang="rust" line-numbers="true">}}
mod custom {
    pub struct Complex {
        // fields and methods for Complex
    }

    pub fn sqrt(c: Complex) -> Complex {
        // implementation for sqrt
    }

    pub fn main() {
        let z = Complex { /* initialization */ };
        let z2 = sqrt(z);
        println!("{{{}, {}}}", z2.real(), z2.imag());
        // ...
    }
}

fn main() {
    custom::main();
}
{{< /prism >}}
<p style="text-align: justify;">
By placing the code in the <code>custom</code> module, it ensures that the names do not conflict with the standard library names in the <code>std</code> module. This precaution is wise because the standard library provides support for complex arithmetic.
</p>

<p style="text-align: justify;">
The easiest way to access a name from another module is by prefixing it with the module name (e.g., <code>std::io::stdout</code> and <code>custom::main</code>). The main function is defined in the global scope, meaning it isn't part of any specific module, struct, or function. To bring names from the standard library into scope, we use the <code>use</code> statement:
</p>

{{< prism lang="rust">}}
use std::io;
{{< /prism >}}
<p style="text-align: justify;">
Modules are mainly used to organize larger components of a program, such as libraries. They make it easier to build a program from independently developed parts.
</p>

## 2.15. Error Handling
<p style="text-align: justify;">
Error handling in Rust is a multifaceted subject that extends beyond mere language syntax to include broader programming strategies and tools. Rust approaches error handling through a combination of a strong type system and powerful abstractions that facilitate the development of robust and reliable applications.
</p>

<p style="text-align: justify;">
Rust’s type system plays a crucial role in this process. Instead of relying solely on primitive types like <code>char</code>, <code>i32</code>, and <code>f64</code>, and basic control structures such as <code>if</code>, <code>while</code>, and <code>for</code>, Rust encourages the use of more sophisticated types and constructs. These include <code>String</code> for dynamic text, <code>HashMap</code> for associative arrays, and <code>Regex</code> for regular expressions. By employing these higher-level abstractions, developers can write more expressive and error-resistant code. The use of specialized types and algorithms, such as <code>sort</code>, <code>find</code>, and <code>draw_all</code>, not only simplifies development but also allows the Rust compiler to perform more rigorous checks, catching potential errors early in the development process.
</p>

<p style="text-align: justify;">
Rust's design philosophy emphasizes creating clean and efficient abstractions. This includes defining custom user types and implementing associated algorithms that fit specific needs. This modular approach means that code can be organized into components with clear interfaces, reducing the likelihood of errors and improving maintainability. As applications grow and make use of various libraries, the point at which errors occur may be different from where they are handled. This separation can complicate error management but also underscores the need for consistent error handling practices.
</p>

<p style="text-align: justify;">
To effectively handle errors in a Rust application, developers must establish robust error handling standards. These standards should account for the potential complexity introduced by extensive library use and modular design. By integrating Rust’s type system and leveraging its abstraction mechanisms, developers can create applications that handle errors gracefully and maintain high reliability.
</p>

## 2.16. Exceptions
<p style="text-align: justify;">
Consider the <code>Vector</code> example. How should out-of-range element access be handled? The <code>Vector</code> implementer doesn't know what the user wants to happen in such situations, and the user can't always prevent out-of-range accesses. The solution is for the <code>Vector</code> implementer to catch these errors and notify the user. In Rust, this can be managed with the <code>Result</code> type to indicate potential errors. For instance, the <code>Vector</code> implementation can return a <code>Result</code> to show either success or an error:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Vector {
    pub fn get(&self, i: usize) -> Result<f64, String> {
        if i >= self.sz {
            Err(format!("Index {} out of range for Vector", i))
        } else {
            Ok(self.elem[i])
        }
    }
}
{{< /prism >}}
<p style="text-align: justify;">
The <code>get</code> method checks for out-of-range access and returns an <code>Err</code> variant if the index is invalid. The user can then handle this error accordingly:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let v = Vector::new(10);
    match v.get(10) {
        Ok(value) => println!("Value: {}", value),
        Err(e) => println!("Error: {}", e),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the attempt to access <code>v.get(10)</code> will fail, and an error message will be displayed. Using the <code>Result</code> type for error handling in Rust makes error management more systematic and readable.
</p>

## 2.17. Invariants
<p style="text-align: justify;">
Using the <code>Result</code> type to handle out-of-range access in Rust demonstrates how functions can validate their arguments and refuse execution if fundamental conditions, or preconditions, are not met. For example, if we were to formally define the subscript operator for a <code>Vector</code>, it would include a requirement such as "the index must be within the range \[0())". This is precisely what our <code>get()</code> method verifies. When defining functions, it's crucial to identify and validate their preconditions to ensure they are met. This practice enhances reliability and helps prevent unexpected errors.
</p>

<p style="text-align: justify;">
The <code>get()</code> method works on <code>Vector</code> objects, and its operations are only meaningful if the <code>Vector</code>'s fields have valid values. For instance, we mentioned that <code>elem</code> points to an array of <code>sz</code> doubles, but this was only noted in a comment. Such a statement, indicating what must always be true for a class, is known as a class invariant, or simply an invariant. The constructor's responsibility is to establish this invariant (so member functions can depend on it), and the member functions must ensure the invariant holds when they finish execution. Unfortunately, our <code>Vector</code> constructor did not fully achieve this. It correctly initialized the <code>Vector</code> fields but didn't validate that the arguments provided were reasonable. For example:
</p>

{{< prism lang="rust">}}
let v = Vector::new(-27);
{{< /prism >}}
<p style="text-align: justify;">
This would likely cause serious problems. To address this in Rust, we can modify the constructor as follows:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Vector {
    pub fn new(s: isize) -> Result<Vector, String> {
        if s < 0 {
            Err(String::from("Size must be non-negative"))
        } else {
            Ok(Vector {
                elem: vec![0.0; s as usize].into_boxed_slice(),
                sz: s as usize,
            })
        }
    }
}
{{< /prism >}}
<p style="text-align: justify;">
This ensures that the constructor validates the arguments, maintaining the invariant that <code>sz</code> must be non-negative.
</p>

<p style="text-align: justify;">
Here is a more appropriate definition:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Vector {
    pub fn new(s: isize) -> Result<Vector, String> {
        if s < 0 {
            return Err(String::from("Size must be non-negative"));
        }
        Ok(Vector {
            elem: vec![0.0; s as usize].into_boxed_slice(),
            sz: s as usize,
        })
    }
}
{{< /prism >}}
<p style="text-align: justify;">
The standard library error type is used to report a non-positive number of elements, as similar operations use this error type to signal such issues. If memory allocation fails, Rust will return an error instead of throwing an exception. The following example shows how to handle these cases:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn test() {
    match Vector::new(-27) {
        Ok(v) => {
            // use the vector
        },
        Err(e) => {
            if e == "Size must be non-negative" {
                // handle negative size
            } else {
                // handle other errors
            }
        }
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In Rust, custom error types are instrumental for conveying detailed information about errors from the point of detection to the point of handling. By defining custom error types, you can encapsulate specific error conditions and their context, making error handling more informative and manageable.
</p>

<p style="text-align: justify;">
Rust does not use traditional exception handling mechanisms. Instead, it relies on the <code>Result</code> and <code>Option</code> types to handle errors. When a function encounters an error, it typically returns a <code>Result</code> type that either contains a success value or an error value. When the function cannot complete its task due to an error, it handles the situation by performing minimal local cleanup if necessary and then propagating the error up the call stack. This approach allows higher-level code to manage the error appropriately.
</p>

<p style="text-align: justify;">
The concept of invariants and preconditions plays a significant role in designing robust software. Invariants are conditions that must always hold true for an object to remain valid throughout its lifecycle. They help maintain the consistency and correctness of an object's state. On the other hand, preconditions are conditions that must be met before a function can execute correctly. They ensure that the function operates under valid assumptions, preventing it from executing with invalid inputs. By clearly defining and enforcing these conditions, you improve the reliability and robustness of your code, making it easier to debug and test.
</p>

## 2.18. Static Assertions
<p style="text-align: justify;">
In Rust, error handling can be effectively managed through the type system and compile-time checks, offering a more robust alternative to runtime exceptions. While exceptions traditionally report errors that occur during program execution, Rust aims to catch as many errors as possible at compile time, reducing the risk of encountering unexpected issues during runtime.
</p>

<p style="text-align: justify;">
Rust's type system is designed to enforce strict rules about how values are used and manipulated, catching many common errors before the code is even executed. By leveraging Rust's type system, developers can define precise interfaces for user-defined types, specifying the exact conditions under which these types can be used. This approach helps prevent misuse and ensures that errors are caught early in the development process.
</p>

<p style="text-align: justify;">
Furthermore, Rust's compiler performs extensive checks to enforce these rules. For instance, Rust's ownership and borrowing system guarantees memory safety and prevents data races at compile time. If the compiler detects a violation of these rules, it reports the issue as a compiler error, prompting the developer to fix the problem before the code can be compiled and run.
</p>

<p style="text-align: justify;">
By focusing on compile-time error detection, Rust provides a more reliable and predictable development experience. Developers can catch and resolve issues early, reducing the likelihood of runtime errors and improving the overall quality of their code. This emphasis on compile-time checks distinguishes Rust from many other languages, making it particularly well-suited for systems programming and other domains where reliability and performance are critical. For instance:
</p>

{{< prism lang="rust">}}
const_assert!(std::mem::size_of::<i32>() >= 4, "integers are too small"); // check integer size
{{< /prism >}}
<p style="text-align: justify;">
This will produce the error message "integers are too small" if <code>std::mem::size_of::<i32>() >= 4</code> is false, indicating that an <code>i32</code> on this system is less than 4 bytes. These expectation statements are called assertions.
</p>

<p style="text-align: justify;">
The <code>const_assert</code> feature in Rust can be applied to any situation that can be described using constant expressions. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
const C: f64 = 299_792.458; // speed of light in km/s

fn f(speed: f64) {
    const LOCAL_MAX: f64 = 160.0 / (60.0 * 60.0); // converting 160 km/h to km/s
    const_assert!(speed < C, "can't go that fast"); // error: speed must be a constant
    const_assert!(LOCAL_MAX < C, "can't go that fast"); // OK
    // ...
}
{{< /prism >}}
<p style="text-align: justify;">
In general, <code>const_assert!(A, S)</code> generates <code>S</code> as a compiler error message if <code>A</code> evaluates to false. The most valuable application of <code>const_assert</code> is in making assertions about types used as parameters in generic programming.
</p>

## 2.19. Advices
<p style="text-align: justify;">
As you embark on learning Rust, it is crucial to adopt a patient and steady approach. Initially, Rust may appear complex due to its unique features and strict rules, but persistence will enable you to gradually master its intricacies. At the outset, focus on understanding Rust’s foundational concepts such as ownership, borrowing, and lifetimes. These principles are central to Rust's design and are essential for writing safe and efficient code. Emphasize gaining a deep comprehension of these concepts rather than merely memorizing syntax. They are the bedrock of Rust’s memory safety and concurrency guarantees, and mastering them will greatly enhance your ability to write reliable code.
</p>

<p style="text-align: justify;">
Beyond these foundational concepts, it is beneficial to explore Rust’s advanced features. The language’s robust type system allows for precise and expressive programming, facilitating the creation of complex and scalable applications. Pay attention to how Rust's type system enables you to write code that is both safe and performant by catching errors at compile time. Additionally, Rust’s concurrency model offers powerful tools for managing parallel execution while preventing common issues such as data races and deadlocks. Understanding how to effectively use Rust’s concurrency features will empower you to develop high-performance applications that can efficiently utilize modern hardware.
</p>

<p style="text-align: justify;">
Establishing a strong grasp of these core principles will not only help you navigate Rust’s complexities but also enable you to leverage its powerful capabilities fully. By focusing on foundational concepts and exploring advanced features, you will position yourself to excel in Rust development and harness its potential for building robust and scalable software.
</p>

## 2.20. Further Learning with GenAI
<p style="text-align: justify;">
Assign yourself the following tasks: Input each prompt into both ChatGPT and Gemini, and analyze the responses to deepen your understanding of Rust.
</p>

1. <p style="text-align: justify;">As a senior Rust programmer, elaborate on the concept of separate compilation using the <code>rustc</code> compiler. Given two source files, <code>main.rs</code> and <code>lib.rs</code>, provide a comprehensive guide on manually compiling these files with the <code>--crate-type=lib</code> and <code>--emit=obj</code> compiler options. Discuss the use cases and advantages of each technique, including their impact on build times, code organization, and binary sizes.</p>
2. <p style="text-align: justify;">Continue with <code>main.rs</code> and <code>lib.rs</code> to offer a detailed guide on achieving separate compilation using Cargo, Rust's package manager and build system. Explain the process of setting up a project, managing dependencies, and efficiently building the project. Highlight the benefits of using Cargo over manual compilation, such as dependency management, build automation, and workspace support.</p>
3. <p style="text-align: justify;">Write sample Rust code for a "Hello, World!" program that demonstrates unconventional uses of common Rust language features. For example, show how to utilize pattern matching, lifetimes, closures, or concurrency primitives to illustrate Rust’s versatility.</p>
4. <p style="text-align: justify;">Explain Rust's fundamental types, variable bindings, mutability, and arithmetic operations with straightforward, easy-to-understand code examples. Cover the syntax and semantics of scalar types (integers, floats, characters, booleans) and compound types (tuples, arrays), along with examples demonstrating variable immutability and arithmetic operations.</p>
5. <p style="text-align: justify;">Delve into the concept of variable immutability in Rust. Distinguish between regular variables, constant variables (<code>const</code>), and static variables (<code>static</code>). Provide examples to clarify when and why to use each type, considering aspects of performance and memory safety.</p>
6. <p style="text-align: justify;">Use sample code to explain statement selection (using <code>if</code>, <code>match</code>) and looping constructs (such as <code>for</code>, <code>while</code>, <code>loop</code>) in Rust. Discuss specific features that enhance Rust's approach to control flow compared to C/C++, such as pattern matching and exhaustive checking.</p>
7. <p style="text-align: justify;">Compare Rust's features related to arrays, raw pointers, and looping with similar features in C++. Examine how Rust’s ownership model, safety guarantees, and pointer types (e.g., <code><strong>const T</code>, <code></strong>mut T</code>) differ from C++ and their implications for safe and efficient memory management.</p>
8. <p style="text-align: justify;">As a senior software design engineer, elucidate the concept of user-defined types (UDTs) in Rust. Discuss the benefits of UDTs in Rust relative to C/C++, focusing on enums, structs, and type aliases. Provide examples to demonstrate how these features enhance type safety, clarity, and ease of maintenance.</p>
9. <p style="text-align: justify;">Explain the design and usage of structures (<code>struct</code>) in Rust. Discuss why Rust does not use classes like other object-oriented languages and the implications of this design choice. Highlight how Rust achieves encapsulation, polymorphism, and data abstraction through traits and other features instead of classes.</p>
10. <p style="text-align: justify;">Discuss Rust’s enumeration (<code>enum</code>) features and compare them to enumerations in C++. Explain the advantages and limitations of Rust's enums, including exhaustiveness checking, enum variants with data, and pattern matching, and contrast these with C++ enums.</p>
11. <p style="text-align: justify;">Explore Rust’s modularity features related to compilation. Cover static and dynamic linking, the use of modules (<code>mod</code>), crates, and the separation of interface and implementation. Discuss the pros and cons of these modularity techniques, including their impact on code organization, reuse, and compilation times.</p>
12. <p style="text-align: justify;">Explain the concept of namespaces in Rust, particularly through the use of modules and the <code>use</code> keyword. Compare this system to C++ namespaces, discussing the advantages and limitations of Rust’s approach to namespacing.</p>
13. <p style="text-align: justify;">Discuss Rust's error handling features, including the use of <code>Result</code> and <code>Option</code> types, panic mechanisms, and the absence of traditional exceptions. Provide sample code demonstrating how to handle recoverable and unrecoverable errors, and explain how invariants and static assertions (<code>const fn</code>, <code>assert!</code>) contribute to code correctness.</p>
14. <p style="text-align: justify;">Write Rust code to implement a simple calculator that takes a text stream as input. Include the implementation of an abstract syntax tree (AST) and a tokenizer. The calculator should parse and evaluate mathematical expressions, showcasing Rust's capabilities in managing complex data structures and algorithms.</p>
<p style="text-align: justify;">
Based on the responses to these prompts, thoroughly review the answers and follow the instructions provided. Ensure that your code runs smoothly in VS Code. Approach this process as if you're leveling up in a game: the more effort you invest, the more you’ll uncover about Rust, and the better your coding skills will become. Don’t be discouraged if you don’t grasp everything immediately; mastering Rust takes practice. Stay persistent, and you will become proficient in Rust in no time. Enjoy the learning journey!
</p>
