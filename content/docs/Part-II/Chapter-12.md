---
weight: 2000
title: "Chapter 12"
description: "Statements and Expressions"
icon: "article"
date: "2024-08-05T21:21:09+07:00"
lastmod: "2024-08-05T21:21:09+07:00"
draft: false
toc: true
---

{{% alert icon="💡" context="info" %}}<strong>"<em>Simplicity is prerequisite for reliability.</em>" — Edsger W. Dijkstra</strong>{{% /alert %}}

{{% alert icon="📘" context="success" %}}
<p style="text-align: justify;">
In this chapter, we explored the differences between statements and expressions in Rust. Statements perform actions but do not return values, while expressions evaluate to values and can be used in statements. We looked at how statements and expressions can be combined to create complex structures, how control flow constructs in Rust are also expressions, and the use of the <code>return</code> expression for early exits. Additionally, we discussed advanced expression usage in contexts like closures and iterator chains. Understanding these concepts is essential for writing clear and idiomatic Rust code.
</p>
{{% /alert %}}

## 12.1. Introduction to Statements and Expressions
<p style="text-align: justify;">
In Rust, statements are the building blocks of a program, and they come in several forms, each serving a distinct purpose. One type of statement is a declaration. Declarations define variables, constants, functions, structs, enums, and other items that introduce new names into the program and set their initial values or behaviors. For example, declaring a variable might look like <code>let x = 5;</code>, which defines an immutable variable <code>x</code> with a value of 5. Similarly, <code>fn add(a: i32, b: i32) -> i32 { a + b }</code> declares a function named <code>add</code> that takes two integers and returns their sum.
</p>

<p style="text-align: justify;">
An expression statement in Rust is simply an expression followed by a semicolon. These are used to perform actions that don’t necessarily return a value but do something useful, like calling a function or modifying a variable. For instance, <code>x += 1;</code> is an expression statement that increments the value of <code>x</code> by 1. The semicolon at the end indicates that the expression is being used as a statement.
</p>

<p style="text-align: justify;">
The Rust statements include a variety of constructs that allow for variable and function declarations, executing expressions, grouping multiple statements, iterating through loops, matching patterns, and controlling the flow of execution. These constructs enable the creation of complex and powerful Rust programs. The following structure is a comprehensive summary of the components and syntax patterns of Rust's statements, illustrating how Rust code is organized and written.
</p>

{{< prism lang="rust" line-numbers="true">}}
statement: 
    declaration
    expressionopt ;
    { statement-listopt }
    loop { statement-listopt }
    match expression { match-arms }
    if expression { statement-listopt } else statement
    while expression { statement-listopt }
    for pattern in expression { statement-listopt }
    break ;
    continue ;
    return expressionopt ;
    label : statement

declaration: 
    let patternopt = expression ;
    let mut patternopt = expression ;
    const IDENTIFIER : type = expression ;
    static IDENTIFIER : type = expression ;
    fn IDENTIFIER ( parameters ) -> type { statement-listopt }
    struct IDENTIFIER { fields }
    enum IDENTIFIER { variants }
    impl trait for type { statement-listopt }
    trait IDENTIFIER { items }

statement-list:
    statement statement-listopt

match-arms:
    pattern => statement ,
    pattern => statement , match-armsopt

pattern:
    literal
    _
    variable
    pattern | pattern
    pattern if guard
    ( pattern )
    [ pattern , patternopt ]
    { field-patternsopt }

field-patterns:
    IDENTIFIER : pattern
    IDENTIFIER : pattern , field-patternsopt

guard:
    expression

expression:
    literal
    path
    expression + expression
    expression - expression
    expression * expression
    expression / expression
    expression % expression
    expression & expression
    expression | expression
    expression ^ expression
    expression && expression
    expression || expression
    expression == expression
    expression != expression
    expression < expression
    expression > expression
    expression <= expression
    expression >= expression
    expression . IDENTIFIER
    expression [ expression ]
    expression ( arguments )
    & expression
    &mut expression
    * expression
    - expression
    ! expression
    ( expression )
    { statement-listopt }
    if expression { statement-listopt } else expression
    loop { statement-listopt }
    match expression { match-arms }
    while expression { statement-listopt }
    for pattern in expression { statement-listopt }
    break ;
    continue ;
    return expressionopt ;
    label : statement

arguments:
    expression , argumentsopt

type:
    IDENTIFIER
    & type
    &mut type
    [ type ; constant ]
    ( type , typeopt )
    fn ( parameters ) -> type

parameters:
    pattern : type
    pattern : type , parametersopt
{{< /prism >}}
<p style="text-align: justify;">
As you can see in the structure, a statement can take various forms, and understanding these forms is essential for mastering the language. Let's explore the different types of statements and expressions in Rust, drawing from the Rust RFCs and general syntax guidelines. A statement in Rust can be one of the following:
</p>

- <p style="text-align: justify;">Declaration: Introduces new names into the program, including variable declarations, constants, statics, function declarations, structs, enums, implementation blocks, and traits.</p>
- <p style="text-align: justify;">Expression Statement: An expression followed by a semicolon.</p>
- <p style="text-align: justify;">Block Statement: A series of statements enclosed in curly braces <code>{ }</code>.</p>
- <p style="text-align: justify;">Loop Statement: Blocks of code that execute repeatedly, including <code>loop</code>, <code>while</code>, and <code>for</code> loops.</p>
- <p style="text-align: justify;">Match Statement: A pattern-matching construct that compares a value against several patterns and executes code based on the matching pattern.</p>
- <p style="text-align: justify;">Control Flow Statements: Direct the flow of the program and include <code>if</code>, <code>while</code>, <code>for</code>, <code>break</code>, <code>continue</code>, <code>return</code>, and labeled statements.</p>
- <p style="text-align: justify;">Labeled Statements: Used to name loops, which is particularly useful for nested loops.</p>
- <p style="text-align: justify;">Statement List: A series of statements, forming a sequence of one or more statements. In a <code>match</code> statement, match arms specify patterns and corresponding actions, such as <code>pattern => statement</code>.</p>
- <p style="text-align: justify;">Patterns: Used to destructure and match values. They can include literals, wildcards (<code>_</code>), variables, and compound patterns (e.g., <code>pattern | pattern</code>, <code>pattern if guard</code>, <code>(pattern)</code>, <code>[pattern, pattern]</code>, <code>{ field-patterns }</code>).</p>
- <p style="text-align: justify;">Guards: Add extra matching criteria to patterns, requiring additional conditions to be true for the pattern to match.</p>
<p style="text-align: justify;">
Rust’s expressions compute values and encompass various forms. These include literals, paths, and binary operations such as <code>+</code>, <code>-</code>, <code><strong></code>, and <code>/</code>. You can access fields using <code>expression . IDENTIFIER</code>, and index values with <code>expression [ expression ]</code>. Function calls are made with <code>expression ( arguments )</code>, while references use <code>& expression</code> or <code>&mut expression</code>, and dereferences use <code></strong> expression</code>. Unary operations like <code>- expression</code> and <code>! expression</code>, as well as expressions enclosed in parentheses <code>( expression )</code>, are also common.
</p>

<p style="text-align: justify;">
Block expressions are enclosed in curly braces <code>{ statement-list }</code>, and conditional expressions follow the <code>if expression { statement-list } else expression</code> format. Loop expressions are written as <code>loop { statement-list }</code>, and match expressions as <code>match expression { match-arms }</code>. While expressions use <code>while expression { statement-list }</code>, and for expressions use <code>for pattern in expression { statement-list }</code>. Control flow expressions include <code>break;</code>, <code>continue;</code>, and <code>return expression;</code>, while labeled statements are written as <code>label: statement</code>.
</p>

<p style="text-align: justify;">
Function calls use arguments to pass values, formatted as <code>expression, argumentsopt</code>, representing one or more expressions separated by commas. Types in Rust define the kind of values and include identifiers for named types (such as <code>i32</code>, <code>String</code>), references (<code>& type</code>, <code>&mut type</code>), arrays (<code>[type; constant]</code>), tuples (<code>(type, type)</code>), and function types (<code>fn(parameters) -> type</code>). Parameters in function definitions specify input types using <code>pattern: type</code>, and multiple parameters are separated by commas.
</p>

## 12.2. Statements
<p style="text-align: justify;">
Statements are integral to any programming language as they perform actions but do not return values. In Rust, statements follow this same principle. One of the most common examples of a statement in Rust is a variable declaration. Variable declarations use the <code>let</code> keyword to bind a name to a value or memory location. This binding is crucial for managing and accessing data throughout your program. Let's explore the different types of statements in Rust with sample codes and clear explanations.
</p>

{{< prism lang="rust">}}
let x = 5; // Immutable variable declaration
let mut y = 10; // Mutable variable declaration
{{< /prism >}}
<p style="text-align: justify;">
In the above example, <code>x</code> is an immutable variable, meaning its value cannot be changed, while <code>y</code> is mutable, allowing its value to be modified.
</p>

<p style="text-align: justify;">
An expression statement is simply an expression followed by a semicolon. The semicolon turns the expression into a statement:
</p>

{{< prism lang="rust">}}
let z = 3 + 4; // This is an expression statement
println!("z = {}", z); // Another example of an expression statement
{{< /prism >}}
<p style="text-align: justify;">
Here, the expression <code>3 + 4</code> is followed by a semicolon, making it an expression statement.
</p>

<p style="text-align: justify;">
A block statement is a series of statements enclosed in curly braces <code>{ }</code>. Blocks are used to group multiple statements together:
</p>

{{< prism lang="rust" line-numbers="true">}}
{
    let a = 1;
    let b = 2;
    let c = a + b;
    println!("c = {}", c);
}
{{< /prism >}}
<p style="text-align: justify;">
This block contains several statements, and all variables <code>a</code>, <code>b</code>, and <code>c</code> are scoped within the block.
</p>

<p style="text-align: justify;">
Loop statements in Rust are blocks of code that execute repeatedly. Rust provides several types of loops, such as <code>loop</code>, <code>while</code>, and <code>for</code>. The <code>loop</code> keyword creates an infinite loop, which can be broken out of with the <code>break</code> statement. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
loop {
    println!("This will print forever unless we break out of the loop.");
    break;
}
{{< /prism >}}
<p style="text-align: justify;">
The <code>while</code> loop continues executing as long as its condition is true:
</p>

{{< prism lang="rust" line-numbers="true">}}
let mut count = 0;
while count < 5 {
    println!("Count is: {}", count);
    count += 1;
}
{{< /prism >}}
<p style="text-align: justify;">
The <code>for</code> loop iterates over a range or collection:
</p>

{{< prism lang="rust" line-numbers="true">}}
for i in 0..5 {
    println!("i is: {}", i);
}
{{< /prism >}}
<p style="text-align: justify;">
A match statement is a powerful pattern-matching construct that allows you to compare a value against several patterns and execute code based on the matching pattern. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let number = 3;
match number {
    1 => println!("One"),
    2 => println!("Two"),
    3 => println!("Three"),
    _ => println!("Something else"),
}
{{< /prism >}}
<p style="text-align: justify;">
In this match statement, <code>number</code> is compared against the patterns <code>1</code>, <code>2</code>, and <code>3</code>. If none of these patterns match, the <code>_</code> pattern acts as a catch-all.
</p>

<p style="text-align: justify;">
Control flow statements in Rust, such as <code>if</code>, <code>while</code>, <code>for</code>, <code>break</code>, <code>continue</code>, <code>return</code>, and labeled statements, direct the flow of the program. For example, an <code>if</code> statement evaluates a condition and executes code based on whether the condition is true or false:
</p>

{{< prism lang="rust" line-numbers="true">}}
let condition = true;
if condition {
    println!("Condition is true");
} else {
    println!("Condition is false");
}
{{< /prism >}}
<p style="text-align: justify;">
Labeled statements are used to name loops and are particularly useful when dealing with nested loops. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
'outer: for i in 0..5 {
    for j in 0..5 {
        if i == 2 {
            break 'outer;
        }
        println!("i: {}, j: {}", i, j);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the label <code>'outer</code> is used to break out of the outer loop from within the inner loop.
</p>

<p style="text-align: justify;">
Finally, a statement list is simply a series of statements, forming a sequence of one or more statements. In a match statement, match arms specify patterns and corresponding actions, such as <code>pattern => statement</code>. Multiple match arms can be combined to handle various cases, as seen in the earlier match example.
</p>

<p style="text-align: justify;">
Overall, understanding these different types of statements and their uses in Rust is essential for writing clear and effective code.
</p>

## 12.3. Expressions
<p style="text-align: justify;">
Rust's expressions compute values and encompass various forms. These include literals, paths, and binary operations such as <code>+</code>, <code>-</code>, <code>*</code>, and <code>/</code>. Literals are the simplest form of expressions, representing constant values directly in the code. They include numbers, characters, strings, and booleans. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let integer_literal = 42;
let float_literal = 3.14;
let boolean_literal = true;
let character_literal = 'a';
let string_literal = "hello";
{{< /prism >}}
<p style="text-align: justify;">
Paths are used to uniquely identify items such as structs, enums, functions, and modules in Rust. They are separated by double colons <code>::</code>. For instance, if you have a module <code>my_module</code> with a function <code>my_function</code>, you can call this function using the path <code>my_module::my_function();</code>.
</p>

{{< prism lang="rust" line-numbers="true">}}
mod my_module {
    pub fn my_function() {
        println!("Hello from my_function!");
    }
}

fn main() {
    my_module::my_function();
}
{{< /prism >}}
<p style="text-align: justify;">
Binary operations involve operators like <code>+</code>, <code>-</code>, <code>*</code>, <code>/</code>, <code>&&</code>, and <code>||</code>, applied between two operands. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let sum = 5 + 10;
let difference = 10 - 5;
let product = 4 * 5;
let quotient = 20 / 4;
let and_operation = true && false;
let or_operation = true || false;
{{< /prism >}}
<p style="text-align: justify;">
Field access expressions allow you to access fields of a struct or tuple using dot notation. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Point {
    x: i32,
    y: i32,
}

let point = Point { x: 10, y: 20 };
println!("Point x: {}, y: {}", point.x, point.y);
{{< /prism >}}
<p style="text-align: justify;">
Indexing expressions access elements of an array, slice, or vector using square brackets. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let array = [1, 2, 3, 4, 5];
let first_element = array[0];
println!("First element: {}", first_element);
{{< /prism >}}
<p style="text-align: justify;">
Function call expressions execute a function and can pass arguments to it. Functions are defined with specific signatures and can be called using their name followed by parentheses containing the arguments:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn add(a: i32, b: i32) -> i32 {
    a + b
}

let result = add(5, 10);
println!("Sum: {}", result);
{{< /prism >}}
<p style="text-align: justify;">
References allow you to refer to a value without taking ownership, using the <code>&</code> and <code>&mut</code> operators, while dereferences use the <code>*</code> operator to access the value that a reference points to. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let x = 5;
let reference_to_x = &x;
println!("Reference to x: {}", reference_to_x);

let mut y = 10;
let mutable_reference_to_y = &mut y;
*mutable_reference_to_y += 5;
println!("Mutable reference to y: {}", y);
{{< /prism >}}
<p style="text-align: justify;">
Unary operations involve a single operand and include negation <code>-</code> and logical NOT <code>!</code>. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
let positive = 5;
let negative = -positive;
println!("Negative: {}", negative);

let true_value = true;
let false_value = !true_value;
println!("False value: {}", false_value);
{{< /prism >}}
<p style="text-align: justify;">
Parentheses can be used to change the precedence of expressions, ensuring certain parts of the expression are evaluated first, such as in:
</p>

{{< prism lang="rust">}}
let result = (5 + 10) * 2;
println!("Result: {}", result);
{{< /prism >}}
<p style="text-align: justify;">
Block expressions are enclosed in curly braces <code>{}</code> and can contain multiple statements. The block evaluates to the value of the last expression within it:
</p>

{{< prism lang="rust" line-numbers="true">}}
let x = {
    let a = 2;
    let b = 3;
    a + b
};
println!("Block result: {}", x);
{{< /prism >}}
<p style="text-align: justify;">
Conditional expressions allow for branching logic using <code>if</code> and <code>else</code>:
</p>

{{< prism lang="rust" line-numbers="true">}}
let condition = true;
let number = if condition { 5 } else { 10 };
println!("Number: {}", number);
{{< /prism >}}
<p style="text-align: justify;">
Loop expressions create loops that repeatedly execute a block of code. Rust provides several types of loops: <code>loop</code>, <code>while</code>, and <code>for</code>. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
let mut count = 0;
loop {
    if count == 5 {
        break;
    }
    count += 1;
}
println!("Count after loop: {}", count);

count = 0;
while count < 5 {
    count += 1;
}
println!("Count after while: {}", count);

let array = [1, 2, 3, 4, 5];
for element in array.iter() {
    println!("Element: {}", element);
}
{{< /prism >}}
<p style="text-align: justify;">
Match expressions provide powerful pattern matching against values, allowing for complex branching logic. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let number = 2;
match number {
    1 => println!("One"),
    2 => println!("Two"),
    3 => println!("Three"),
    _ => println!("Other"),
};
{{< /prism >}}
<p style="text-align: justify;">
Control flow expressions, including <code>break</code>, <code>continue</code>, and <code>return</code>, alter the flow of the program. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn process_number(num: i32) -> i32 {
    if num > 10 {
        return num;
    }
    num + 10
}

let result = process_number(5);
println!("Processed number: {}", result);

for i in 0..5 {
    if i == 2 {
        continue;
    }
    println!("i: {}", i);
}

count = 0;
loop {
    count += 1;
    if count == 3 {
        break;
    }
}
println!("Count after break: {}", count);
{{< /prism >}}
<p style="text-align: justify;">
Function calls pass values to functions via arguments, formatted as expressions separated by commas. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn multiply(a: i32, b: i32) -> i32 {
    a * b
}

let result = multiply(5, 6);
println!("Product: {}", result);
{{< /prism >}}
<p style="text-align: justify;">
Types in Rust define the kind of values that variables can hold, including named types, references, arrays, tuples, and function types. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let integer: i32 = 10;
let string: String = String::from("Hello");
let reference: &i32 = &integer;
let array: [i32; 3] = [1, 2, 3];
let tuple: (i32, f64) = (10, 3.14);
let function: fn(i32, i32) -> i32 = multiply;
{{< /prism >}}
<p style="text-align: justify;">
Function parameters specify the types of input values a function accepts. Multiple parameters are separated by commas, such as in:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn add_numbers(x: i32, y: i32) -> i32 {
    x + y
}

let result = add_numbers(3, 4);
println!("Sum: {}", result);
{{< /prism >}}
<p style="text-align: justify;">
Understanding expressions and statements in Rust is crucial for writing efficient and readable code. By mastering these constructs, you can fully leverage the language's power to create robust and performant applications.
</p>

## 12.4. Combining Statements and Expressions
<p style="text-align: justify;">
Rust's syntax allows for combining statements and expressions to create more complex and expressive code. This combination is a key feature of Rust, enabling you to write concise and readable programs. For instance, a <code>let</code> statement can include an expression to initialize a variable, providing both action and value in a single line of code. Consider the following example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let x = {
        let y = 3;
        y + 1
    }; // Block expression within a let statement
    println!("The value of x is {}", x);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the variable <code>x</code> is initialized using a block expression. Inside the block, another variable <code>y</code> is declared and assigned the value <code>3</code>. The block then evaluates to <code>y + 1</code>, which is <code>4</code>, and this value is assigned to <code>x</code>. This demonstrates how Rust allows you to nest expressions within statements, making the code more compact and expressive.
</p>

<p style="text-align: justify;">
Using expressions within control flow statements further enhances Rust's expressiveness. For instance, you can use an <code>if</code> expression to decide the value to assign to a variable. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let number = 6;

    let result = if number % 2 == 0 {
        "even"
    } else {
        "odd"
    };

    println!("The number is {}", result);
}
{{< /prism >}}
<p style="text-align: justify;">
In this case, the <code>if</code> expression checks whether the variable <code>number</code> is even or odd. If the condition <code>number % 2 == 0</code> is true, the expression evaluates to <code>"even"</code>; otherwise, it evaluates to <code>"odd"</code>. This value is then assigned to the variable <code>result</code>. The use of the <code>if</code> expression within the assignment statement makes the code more succinct and easier to follow.
</p>

<p style="text-align: justify;">
Combining these features allows you to write Rust code that is both powerful and concise, making it easier to manage and understand complex logic. By leveraging expressions within statements, you can create more expressive and readable programs.
</p>

<p style="text-align: justify;">
Here's another example that demonstrates combining statements and expressions in a more complex scenario:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let n = 5;
    
    let factorial = {
        let mut result = 1;
        for i in 1..=n {
            result *= i;
        }
        result
    }; // Block expression to calculate factorial
    
    println!("The factorial of {} is {}", n, factorial);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the variable <code>factorial</code> is initialized using a block expression. The block contains a loop that calculates the factorial of <code>n</code>. The loop iterates from <code>1</code> to <code>n</code> (inclusive), multiplying the <code>result</code> variable by each number in the range. The final value of <code>result</code>, which is the factorial of <code>n</code>, is then assigned to <code>factorial</code>. This example highlights how you can encapsulate complex logic within block expressions to keep your main code concise.
</p>

<p style="text-align: justify;">
By practicing these techniques and exploring different ways to combine statements and expressions, you'll become more proficient in writing Rust code that is both efficient and easy to read. Familiarizing yourself with these constructs and experimenting with them in various scenarios will help you fully leverage Rust's expressive power, allowing you to tackle more complex programming challenges with confidence.
</p>

## 12.5. Expressions in Control Flow
<p style="text-align: justify;">
Control flow constructs in Rust, such as <code>if</code>, <code>match</code>, and loops, are also expressions. This means they evaluate to values and can be used in places where expressions are expected, such as the right-hand side of a <code>let</code> statement. This capability allows for more flexible and concise code. For example, an <code>if</code> expression can be used to initialize a variable based on a condition. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let number = 6;

    let result = if number % 2 == 0 {
        "even"
    } else {
        "odd"
    };

    println!("The number is {}", result);
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the <code>if</code> expression evaluates the condition <code>number % 2 == 0</code>. If the condition is true, it evaluates to <code>"even"</code>; otherwise, it evaluates to <code>"odd"</code>. This value is then assigned to the variable <code>result</code>. The use of the <code>if</code> expression within the assignment makes the code more compact and readable.
</p>

<p style="text-align: justify;">
Similarly, <code>match</code> expressions provide a powerful way to handle multiple conditions and patterns in a concise manner. They evaluate to a value based on the pattern that matches the input. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let number = 7;

    let result = match number {
        1 => "one",
        2 => "two",
        3 => "three",
        4..=6 => "between four and six",
        _ => "greater than six",
    };

    println!("The number is {}", result);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the <code>match</code> expression checks the value of <code>number</code> against several patterns. If <code>number</code> is <code>1</code>, it evaluates to <code>"one"</code>, if <code>2</code>, it evaluates to <code>"two"</code>, and so on. The range pattern <code>4..=6</code> matches any number between <code>4</code> and <code>6</code>, and the wildcard pattern <code>_</code> matches any other number. The resulting value is then assigned to the variable <code>result</code>. This demonstrates how <code>match</code> expressions can simplify complex conditional logic.
</p>

<p style="text-align: justify;">
Loops in Rust, such as <code>loop</code>, <code>while</code>, and <code>for</code>, can also be expressions. They can return values using the <code>break</code> statement with a value. Here's an example using a <code>loop</code> expression:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    println!("The result is {}", result);
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the <code>loop</code> expression repeatedly increments <code>counter</code> by <code>1</code>. When <code>counter</code> reaches <code>10</code>, the loop breaks and returns <code>counter * 2</code>. This value is then assigned to the variable <code>result</code>. The ability to return values from loops allows for more expressive and flexible control flow.
</p>

<p style="text-align: justify;">
Combining these features allows you to write Rust code that is both powerful and concise. For instance, you can nest control flow expressions to handle complex logic:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let number = 15;

    let result = if number % 3 == 0 {
        match number {
            3 => "three",
            6 => "six",
            9 => "nine",
            _ => "divisible by three"
        }
    } else {
        "not divisible by three"
    };

    println!("The number is {}", result);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the outer <code>if</code> expression checks if <code>number</code> is divisible by <code>3</code>. If true, a <code>match</code> expression is used to determine the exact value or a general case for numbers divisible by <code>3</code>. If the condition is false, it simply returns <code>"not divisible by three"</code>. This nested use of control flow expressions showcases Rust's ability to handle intricate logic concisely.
</p>

<p style="text-align: justify;">
Understanding these expressions and statements in Rust helps you write efficient and readable code, leveraging the full power of the language to create robust and performant applications. By practicing these constructs and exploring their various uses, you can master the expressive capabilities of Rust, enabling you to tackle complex programming challenges with ease and confidence.
</p>

## 12.6. The return Expression
<p style="text-align: justify;">
The <code>return</code> keyword in Rust is used to exit a function and return a value. This can be particularly useful for exiting early from a function when a certain condition is met. Unlike some other languages, Rust's <code>return</code> is an expression that produces a value. Consider the following example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let value = some_function();
    println!("The value is {}", value);
}

fn some_function() -> i32 {
    let x = 5;

    if x > 3 {
        return x + 1;
    }

    x - 1
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the <code>some_function</code> function checks if the variable <code>x</code> is greater than <code>3</code>. If the condition is true, it immediately returns <code>x + 1</code>. If the condition is false, it proceeds to the next line and evaluates <code>x - 1</code> as the function's return value. The <code>return</code> keyword provides a clear and immediate exit from the function, making the flow of logic straightforward and easy to follow.
</p>

<p style="text-align: justify;">
Using <code>return</code> effectively can simplify complex functions and make the flow of logic easier to follow. It allows you to handle different cases and exit points clearly, avoiding deeply nested conditions. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn check_value(val: i32) -> &'static str {
    if val < 0 {
        return "Negative";
    }

    if val == 0 {
        return "Zero";
    }

    "Positive"
}

fn main() {
    let result = check_value(-10);
    println!("The value is {}", result);

    let result = check_value(0);
    println!("The value is {}", result);

    let result = check_value(10);
    println!("The value is {}", result);
}
{{< /prism >}}
<p style="text-align: justify;">
Here, the <code>check_value</code> function uses multiple <code>return</code> statements to handle different conditions. If <code>val</code> is less than <code>0</code>, it returns "Negative". If <code>val</code> is <code>0</code>, it returns "Zero". Otherwise, it returns "Positive". This approach keeps each condition separate and clear, enhancing readability.
</p>

<p style="text-align: justify;">
The <code>return</code> keyword can also be used in combination with loops to exit a function early when a certain condition within the loop is met:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn find_first_even(numbers: &[i32]) -> Option<i32> {
    for &num in numbers {
        if num % 2 == 0 {
            return Some(num);
        }
    }
    None
}

fn main() {
    let numbers = [1, 3, 5, 8, 10];
    match find_first_even(&numbers) {
        Some(even) => println!("The first even number is {}", even),
        None => println!("There are no even numbers"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the <code>find_first_even</code> function iterates over a slice of integers and returns the first even number it encounters. If an even number is found, the function returns it immediately using the <code>return</code> keyword. If the loop completes without finding an even number, the function returns <code>None</code>. This use of <code>return</code> allows for an immediate exit from the function, improving efficiency and clarity.
</p>

<p style="text-align: justify;">
Combining <code>return</code> with other control flow constructs can further enhance your code's expressiveness and readability. For instance, you can use <code>return</code> within <code>match</code> expressions to handle multiple cases in a function:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn describe_number(number: i32) -> &'static str {
    match number {
        1 => return "One",
        2 => return "Two",
        3 => return "Three",
        _ => "Other",
    }
}

fn main() {
    let description = describe_number(2);
    println!("The number is {}", description);

    let description = describe_number(5);
    println!("The number is {}", description);
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the <code>describe_number</code> function uses a <code>match</code> expression to handle different values of <code>number</code>. For specific values (<code>1</code>, <code>2</code>, and <code>3</code>), it returns the corresponding string using the <code>return</code> keyword. For all other values, it returns "Other". This pattern allows you to handle each case explicitly and concisely.
</p>

<p style="text-align: justify;">
Understanding and utilizing the <code>return</code> keyword in Rust helps you write efficient and readable code. By clearly defining exit points and return values, you can create functions that are easier to understand and maintain. Practicing the use of <code>return</code> in various scenarios will enhance your ability to write robust and performant Rust applications.
</p>

## 12.7. Advanced Expression Usage
<p style="text-align: justify;">
Expressions in Rust can be used in more advanced contexts, such as closures, which are anonymous functions that can capture variables from their environment. Closures are powerful tools for creating small, reusable blocks of code that can be passed as arguments to other functions. For instance, consider the following example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let x = 5;
    let add = |y| x + y; // Closure expression
    println!("The result is {}", add(3));
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the closure <code>|y| x + y</code> captures the variable <code>x</code> from its environment and uses it to define a small function that adds <code>y</code> to <code>x</code>. When <code>add(3)</code> is called, the closure executes and returns <code>8</code>. This demonstrates how closures can encapsulate behavior and state, making your code modular and reusable.
</p>

<p style="text-align: justify;">
Expressions can also be used in iterator chains, allowing for powerful and concise data processing. Iterator chains enable you to transform and filter data in a functional programming style. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];

    let even_squares: Vec<i32> = numbers.iter()
        .filter(|&&x| x % 2 == 0)
        .map(|&x| x * x)
        .collect();

    println!("Even squares: {:?}", even_squares);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>numbers.iter()</code> creates an iterator over the vector <code>numbers</code>. The <code>filter</code> method takes a closure <code>|&&x| x % 2 == 0</code> to keep only the even numbers. The <code>map</code> method then takes another closure <code>|&x| x * x</code> to square each even number. Finally, <code>collect</code> gathers the results into a new vector. The entire process is concise and expressive, showcasing the power of combining expressions with iterators.
</p>

<p style="text-align: justify;">
Closures can also be used in conjunction with higher-order functions, which are functions that take other functions as arguments or return them as results. This is particularly useful for creating customizable behavior. Consider the following example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn apply_twice<F>(f: F, x: i32) -> i32
where
    F: Fn(i32) -> i32,
{
    f(f(x))
}

fn main() {
    let double = |x| x * 2;
    let result = apply_twice(double, 5);
    println!("The result is {}", result); // Outputs: The result is 20
}
{{< /prism >}}
<p style="text-align: justify;">
Here, the <code>apply_twice</code> function takes a closure <code>f</code> and an integer <code>x</code>, and applies the closure to <code>x</code> twice. The closure <code>double</code>, which multiplies its input by 2, is passed to <code>apply_twice</code>, resulting in <code>5 <strong> 2 </strong> 2 = 20</code>. This pattern allows for highly flexible and reusable code.
</p>

<p style="text-align: justify;">
Expressions can also be used within structs and enums to initialize fields or create associated constants. This provides a way to encapsulate logic directly within data structures. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn main() {
    let rect = Rectangle {
        width: 10,
        height: 5,
    };

    println!("The area of the rectangle is {}", rect.area());
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the <code>Rectangle</code> struct has a method <code>area</code> that calculates the area of the rectangle using an expression. This encapsulation makes the <code>Rectangle</code> struct more self-contained and easier to work with.
</p>

<p style="text-align: justify;">
Combining these advanced uses of expressions allows you to write highly expressive and efficient Rust code. By leveraging closures, iterator chains, higher-order functions, and expressions within data structures, you can create robust and modular programs. Familiarizing yourself with these patterns and practicing their use will enhance your ability to write powerful and concise Rust applications.
</p>

## 12.8. Patterns and Guards
<p style="text-align: justify;">
Patterns in Rust are a powerful feature used to destructure and match values. They allow you to bind variables to parts of data, test data structures for specific shapes, and create complex conditions in a concise and readable way. Patterns can include literals, wildcards, variables, and compound patterns. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let some_option = Some(5);

    match some_option {
        Some(x) => println!("The value is: {}", x),
        None => println!("There is no value"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the <code>match</code> statement uses a pattern to destructure the <code>Some</code> variant and bind its value to the variable <code>x</code>. If <code>some_option</code> is <code>None</code>, the second arm of the match statement executes.
</p>

<p style="text-align: justify;">
Patterns can also be more complex. They can include wildcards, variables, and compound patterns. For instance, you can use the <code>_</code> wildcard to ignore parts of a value you do not care about, or use compound patterns to match multiple possibilities:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let value = 10;

    match value {
        1 | 2 => println!("One or two"),
        3..=5 => println!("Three to five"),
        _ => println!("Something else"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the pattern <code>1 | 2</code> matches if <code>value</code> is either 1 or 2, the range pattern <code>3..=5</code> matches if <code>value</code> is between 3 and 5, and the <code>_</code> wildcard matches any other value.
</p>

<p style="text-align: justify;">
Compound patterns can also include patterns with guards, which add extra matching criteria to ensure that additional conditions are true for the pattern to match. Guards can be particularly useful for more complex matching logic. Here’s an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let number = Some(4);

    match number {
        Some(x) if x % 2 == 0 => println!("Even number: {}", x),
        Some(x) => println!("Odd number: {}", x),
        None => println!("No number"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this code, the pattern <code>Some(x) if x % 2 == 0</code> only matches if <code>number</code> is <code>Some</code> and the contained value <code>x</code> is even. If the value is odd, the second pattern <code>Some(x)</code> matches, and if <code>number</code> is <code>None</code>, the third arm matches.
</p>

<p style="text-align: justify;">
Patterns can also be used to destructure more complex data structures like tuples, arrays, and structs. For example, you can match against a tuple:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let point = (3, 5);

    match point {
        (0, y) => println!("On the y-axis at {}", y),
        (x, 0) => println!("On the x-axis at {}", x),
        (x, y) => println!("Point is at ({}, {})", x, y),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the pattern <code>(0, y)</code> matches if the first element of the tuple is <code>0</code>, and binds the second element to <code>y</code>. Similarly, <code>(x, 0)</code> matches if the second element is <code>0</code>, and <code>(x, y)</code> matches any other point.
</p>

<p style="text-align: justify;">
Destructuring a struct can also be done using patterns:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Person {
    name: String,
    age: u32,
}

fn main() {
    let person = Person {
        name: String::from("Alice"),
        age: 30,
    };

    match person {
        Person { name, age: 30 } => println!("{} is 30 years old", name),
        Person { name, age } => println!("{} is {} years old", name, age),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Here, the pattern <code>Person { name, age: 30 }</code> matches a <code>Person</code> struct with the <code>age</code> field set to <code>30</code>, binding the <code>name</code> field to the variable <code>name</code>. The second arm matches any <code>Person</code> struct, binding both <code>name</code> and <code>age</code>.
</p>

<p style="text-align: justify;">
Combining these patterns with guards and other control flow constructs in Rust allows you to write expressive, concise, and powerful code. By mastering patterns, you can handle complex data structures and conditions elegantly and efficiently, leveraging Rust’s full potential for creating robust applications.
</p>

## 12.9. Advices
<p style="text-align: justify;">
As a seasoned Rust programmer, here are refined guidelines for effectively using statements and expressions in Rust:
</p>

- <p style="text-align: justify;">Always declare variables with an initial value to ensure clarity and avoid uninitialized variables, which enhances code safety and readability. When handling multiple conditions, prefer using the <code>match</code> statement over multiple <code>if</code> statements, as it offers a cleaner, more readable, and often more efficient way to manage various branches. When iterating over a range or a collection, utilize the <code>for</code> loop for its concise syntax and powerful iteration capabilities. If there's a clear loop variable, a <code>for</code> loop should be used for better readability and seamless integration with Rust's iterator traits.</p>
- <p style="text-align: justify;">For loops without an obvious loop variable or those depending on more complex conditions, opt for a <code>while</code> loop. The <code>loop</code> construct is powerful but should be employed judiciously, ensuring clear exit conditions to prevent infinite loops. Comments should be concise and relevant, adding value and context without being verbose. Strive for self-explanatory code, using comments to clarify intent rather than restate what the code does. Explicitly state the purpose and reasoning behind code decisions in comments to aid understanding and maintenance.</p>
- <p style="text-align: justify;">Consistent indentation is crucial for enhancing readability and maintaining a clean code structure. Prioritize Rust's standard library before considering external libraries or custom implementations, as it is well-tested, optimized, and idiomatic. Limit character-level input processing to essential cases, as higher-level abstractions typically offer better performance and readability. Always validate and handle potential ill-formed input to prevent unexpected behavior and increase program robustness.</p>
- <p style="text-align: justify;">Favor higher-level abstractions, such as structs and iterators, over raw language constructs to promote code reuse, safety, and readability. Simplify expressions to avoid complexity; simple, clear expressions are easier to read, understand, and maintain. When in doubt about operator precedence, use parentheses to make your intentions explicit and your code more understandable. Avoid expressions with undefined evaluation order to ensure predictable and correct behavior. Be cautious with type conversions that can lead to data loss, using explicit casts and checks to maintain data integrity. Lastly, define symbolic constants instead of using magic numbers to enhance code readability and maintainability.</p>
<p style="text-align: justify;">
By adhering to these guidelines, you can write more efficient, readable, and maintainable Rust code. Embracing these practices will help you harness the full power of Rust's capabilities.
</p>

## 12.10. Further Learning with GenAI
<p style="text-align: justify;">
Assign yourself the following tasks: Input these prompts to ChatGPT and Gemini, and glean insights from their responses to enhance your understanding.
</p>

1. <p style="text-align: justify;">Explain the different types of declarative statements in Rust, including <code>let</code>, <code>let mut</code>, <code>const</code>, and <code>static</code>. Provide examples demonstrating their syntax and usage. Discuss how these declarations compare to similar constructs in other languages like C++ and Java. Highlight the importance of clear naming conventions for variables and constants in improving code readability and maintenance.</p>
2. <p style="text-align: justify;">Describe how expressions are evaluated in Rust. Provide examples of various expressions, such as arithmetic operations, logical operations, and function calls. Discuss the differences between expressions and statements, and explain how Rust's design ensures clarity and efficiency in code execution.</p>
3. <p style="text-align: justify;">Explain how to construct and use blocks in Rust to group multiple statements. Provide examples of using blocks within different contexts, such as in functions and conditional statements. Discuss how blocks can help in organizing code and managing scope effectively.</p>
4. <p style="text-align: justify;">Explore the different types of loop constructs in Rust, including <code>loop</code>, <code>while</code>, and <code>for</code>. Provide examples showing how to use each type of loop for various iteration tasks. Discuss the performance implications of using different loops and provide tips for optimizing loop performance.</p>
5. <p style="text-align: justify;">Describe the syntax and usage of <code>if</code>, <code>if let</code>, and <code>else</code> statements in Rust. Provide examples showing different ways to use these conditional constructs for decision making. Discuss the benefits of using <code>if let</code> for pattern matching and how it can improve code readability and efficiency.</p>
6. <p style="text-align: justify;">Explain the <code>match</code> expression in Rust and its syntax. Provide examples of simple and complex match patterns, including the use of guards. Discuss how <code>match</code> can be used to handle different cases in a clean and efficient manner, and compare it with traditional conditional statements.</p>
7. <p style="text-align: justify;">Describe the usage of <code>while</code> and <code>while let</code> loops in Rust. Provide examples showing how to use these loops for different conditional iteration tasks. Discuss the differences between <code>while</code> and <code>while let</code> and explain when to use each construct for optimal performance.</p>
8. <p style="text-align: justify;">Explain the syntax and usage of <code>for</code> loops in Rust. Provide examples showing how to iterate over collections like arrays and vectors. Discuss the performance considerations of using <code>for</code> loops and provide tips for optimizing their usage.</p>
9. <p style="text-align: justify;">Describe how to use <code>break</code> and <code>continue</code> statements within loops in Rust. Provide examples showing how to control loop execution flow using these statements. Discuss scenarios where breaking out of or continuing within a loop is beneficial for code clarity and performance.</p>
10. <p style="text-align: justify;">Explain how to use the <code>return</code> statement in Rust to return values from functions. Provide examples showing different ways to return values, including the use of expressions and blocks. Discuss how the <code>return</code> statement influences function design and performance, and compare it with return mechanisms in other languages.</p>
<p style="text-align: justify;">
Embarking on these prompts is like beginning an exhilarating journey to master Rust programming. Each topic you explore—be it declarative statements, loops, or pattern matching—is a vital step in your quest for expertise. Tackle each challenge with curiosity and determination, as if conquering levels in an epic quest. View any hurdles as opportunities to grow and sharpen your skills. By engaging with these prompts, you will deepen your understanding and proficiency in Rust with every solution you craft. Embrace the learning process, stay focused, and celebrate your progress along the way. Your adventure through Rust will be both rewarding and enlightening! Feel free to tailor these prompts to your learning style and pace. Each topic offers a unique chance to delve into Rust's robust features and gain practical experience. Best of luck, and enjoy the journey!
</p>
