---
weight: 2200
title: "Chapter 14"
description: "Functions"
icon: "article"
date: "2024-08-05T21:21:14+07:00"
lastmod: "2024-08-05T21:21:14+07:00"
draft: false
toc: true
---
{{% alert icon="💡" context="info" %}}<strong>"<em>The real problem is that programmers have spent far too much time worrying about efficiency in the wrong places and at the wrong times; premature optimization is the root of all evil (or at least most of it) in programming.</em>" — Donald Knuth</strong>{{% /alert %}}

{{% alert icon="📘" context="success" %}}
<p style="text-align: justify;">
Chapter 14 of TRPL - "Functions" delves into the critical role of function declarations in Rust, discussing why functions are fundamental to programming and breaking down the various parts of a function declaration. It covers the intricacies of function definitions, the mechanics of returning values, and the specifics of inline and constexpr functions. The chapter also explores special function attributes like \[\[noreturn\]\] and the handling of local variables. In terms of argument passing, it addresses different methods including reference, array, list arguments, unspecified numbers of arguments, and default arguments. The section on overloaded functions explains automatic overload resolution, the impact of return types, scope considerations, resolution strategies for multiple arguments, and techniques for manual overload resolution. Additionally, the chapter highlights the importance of preconditions and postconditions, pointers to functions, and the use of macros, including conditional compilation, predefined macros, and pragmas. Practical advice is interspersed throughout, aimed at optimizing function use and ensuring robust and efficient code.
</p>
{{% /alert %}}


## 14.1. Why Functions?
<p style="text-align: justify;">
In Rust, functions are key to creating clear, maintainable, and efficient code. They help in breaking down complex problems into smaller, manageable pieces, enhancing both readability and maintainability.
</p>

<p style="text-align: justify;">
Consider a scenario where we need to perform a series of calculations. If we write all the logic in a single function, it might stretch to hundreds or even thousands of lines. Such lengthy functions can be difficult to understand, maintain, and debug. The primary role of functions is to split these complex tasks into smaller, more manageable parts, each with a meaningful name. This practice not only makes the code more understandable but also easier to maintain.
</p>

<p style="text-align: justify;">
For example, imagine we are implementing a system to process and analyze data. Instead of writing all the data processing logic in one long function, we can break it down into smaller functions. Each function performs a specific task, such as parsing data, filtering records, or computing statistics. By giving these functions descriptive names, such as <code>parse_data</code>, <code>filter_records</code>, and <code>compute_statistics</code>, we make the code more intuitive.
</p>

<p style="text-align: justify;">
Rust's standard library offers functions like <code>find</code> and <code>sort</code> that serve as building blocks for more complex operations. We can leverage these built-in functions to handle common tasks and then combine them to achieve more sophisticated results. This modular approach allows us to construct complex operations from simple, well-defined functions.
</p>

<p style="text-align: justify;">
When functions become excessively long, the likelihood of errors increases. Each additional line of code introduces more potential for mistakes. By keeping functions short and focused on a single task, we minimize the chance of errors. Short functions also force us to name and document their purpose and dependencies, leading to more self-explanatory code.
</p>

<p style="text-align: justify;">
In Rust, a good practice is to keep functions small enough to fit on a single screen—typically around 40 lines or fewer. However, for optimal clarity, aiming for functions that are around 7 lines is even better. While function calls do have some overhead, it's generally negligible for most use cases. For performance-critical functions, such as those accessed frequently, Rust's compiler can inline them to reduce this overhead.
</p>

<p style="text-align: justify;">
In addition to improving clarity, using functions helps avoid error-prone constructs like <code>goto</code> and overly complex loops. Instead, Rust encourages the use of iterators and other straightforward methods. For instance, nested loops can be replaced with iterators that handle complex operations more safely and elegantly.
</p>

<p style="text-align: justify;">
In summary, functions are essential for structuring code in Rust. By breaking down tasks into smaller functions, we create a clear, maintainable codebase. This approach not only makes our code easier to understand and debug but also helps in managing complexity and improving overall performance.
</p>

## 14.2. Function Declarations
<p style="text-align: justify;">
Performing tasks primarily involves calling functions. A function must be declared before it can be invoked, and its declaration outlines the function's name, the return type (if any), and the types and number of arguments it accepts. Here are some examples:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn next_elem() -> &Elem; // no arguments; returns a reference to Elem
fn exit(code: i32); // takes an i32 argument; returns nothing
fn sqrt(value: f64) -> f64; // takes an f64 argument; returns an f64
{{< /prism >}}
<p style="text-align: justify;">
Argument passing semantics mirror those of copy initialization. Type checking and implicit type conversions are applied as needed. For instance:
</p>

{{< prism lang="rust">}}
let s2 = sqrt(2.0); // calls sqrt() with an f64 argument of 2.0
let s3 = sqrt("three"); // error: sqrt() requires an f64 argument
{{< /prism >}}
<p style="text-align: justify;">
This rigorous checking and conversion are essential for maintaining code safety and accuracy. Function declarations often include argument names for clarity, although these names are not mandatory for the function to compile if it's just a declaration. A return type of <code>()</code> signifies that the function does not return a value.
</p>

<p style="text-align: justify;">
A function's type comprises its return type and its argument types. For methods within structs or enums, the struct or enum's name becomes part of the function type. For example:
</p>

{{< prism lang="rust">}}
fn f(i: i32, info: &Info) -> f64; // type: fn(i32, &Info) -> f64
fn String::index(&self, idx: usize) -> &char; // type: fn(&String, usize) -> &char
{{< /prism >}}
<p style="text-align: justify;">
This setup ensures functions are well-defined and utilized properly, fostering the creation of robust and efficient code.
</p>

## 14.3. Parts of a Function Declaration
<p style="text-align: justify;">
A function declaration not only specifies the name, arguments, and return type but can also include various specifiers and modifiers. Here are the components:
</p>

- <p style="text-align: justify;">Name of the function: This is mandatory.</p>
- <p style="text-align: justify;">Argument list: This may be empty (); it is also mandatory.</p>
- <p style="text-align: justify;">Return type: This can be <code>void</code> and may be indicated as a prefix or suffix (using <code>auto</code>); it is required.</p>
<p style="text-align: justify;">
In addition, function declarations can include:
</p>

- <p style="text-align: justify;"><code>inline</code>: Suggests that the function should be inlined for efficiency.</p>
- <p style="text-align: justify;"><code>const</code>: Indicates the function cannot modify the object it is called on.</p>
- <p style="text-align: justify;"><code>static</code>: Denotes a function not tied to a specific instance.</p>
- <p style="text-align: justify;"><code>async</code>: Marks the function as asynchronous.</p>
- <p style="text-align: justify;"><code>unsafe</code>: Indicates the function performs unsafe operations.</p>
- <p style="text-align: justify;"><code>extern</code>: Specifies that the function links to external code.</p>
- <p style="text-align: justify;"><code>pub</code>: Makes the function publicly accessible.</p>
- <p style="text-align: justify;"><code>#[no_mangle]</code>: Prevents the compiler from changing the function name during compilation.</p>
- <p style="text-align: justify;"><code>#[inline(always)]</code>: Instructs the compiler to always inline the function.</p>
- <p style="text-align: justify;"><code>#[inline(never)]</code>: Instructs the compiler to never inline the function.</p>
<p style="text-align: justify;">
Furthermore, functions can also be marked with attributes that specify their behavior, such as indicating that the function will not return normally, often used for entry points in certain environments.
</p>

<p style="text-align: justify;">
These elements collectively provide a comprehensive way to declare functions, ensuring their purpose, usage, and behavior are clearly communicated and understood.
</p>

## 14.4. Function Definitions
<p style="text-align: justify;">
Every callable function in a program must have a corresponding definition. A function definition includes the actual code that performs the function's task, while a declaration specifies the function's interface without its implementation.
</p>

<p style="text-align: justify;">
For instance, to define a function that swaps two integers:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn swap(x: &mut i32, y: &mut i32) {
    let temp = *x;
    *x = *y;
    *y = temp;
}
{{< /prism >}}
<p style="text-align: justify;">
The definition and all declarations of a function must maintain consistent types. Note that to ensure compatibility, the <code>const</code> qualifier at the highest level of an argument type is ignored. For example, these two declarations are considered the same:
</p>

{{< prism lang="rust">}}
fn example(x: i32);
fn example(x: i32);
{{< /prism >}}
<p style="text-align: justify;">
Whether <code>example()</code> is defined with or without the <code>const</code> modifier does not change its type, and the actual argument can be modified within the function based on its implementation.
</p>

<p style="text-align: justify;">
Here's how <code>example()</code> can be defined:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn example(x: i32) {
    // the value of x can be modified here
}
{{< /prism >}}
<p style="text-align: justify;">
Alternatively:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn example(x: i32) {
    // the value of x remains constant here
}
{{< /prism >}}
<p style="text-align: justify;">
Argument names in function declarations are not part of the function type and can vary across different declarations. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn max(a: i32, b: i32, c: i32) -> i32 {
    if a > b && a > c {
        a
    } else if b > c {
        b
    } else {
        c
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In declarations that are not definitions, naming arguments is optional and primarily used for documentation. Conversely, if an argument is unused in a function definition, it can be left unnamed:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn search(table: &Table, key: &str, _: &str) {
    // the third argument is not used
}
{{< /prism >}}
<p style="text-align: justify;">
Several constructs follow similar rules to functions, including:
</p>

- <p style="text-align: justify;">Constructors: These initialize objects and do not return a value, adhering to specific initialization rules.</p>
- <p style="text-align: justify;">Destructors: Used for cleanup when an object goes out of scope, they cannot be overloaded.</p>
- <p style="text-align: justify;">Function objects (closures): These implement the <code>Fn</code> trait but are not functions themselves.</p>
- <p style="text-align: justify;">Lambda expressions: These provide a concise way to create closures and can capture variables from their surrounding scope.</p>
## 14.5. Returning Values
<p style="text-align: justify;">
In function declarations, it's crucial to specify the return type, with the exception of constructors and type conversion functions. Traditionally, the return type appears before the function name, but modern syntax allows placing the return type after the argument list. For example, the following declarations are equivalent:
</p>

{{< prism lang="rust">}}
fn to_string(a: i32) -> String;
auto to_string(int a) -> string;
{{< /prism >}}
<p style="text-align: justify;">
The prefix <code>auto</code> in the second example indicates that the return type follows the argument list, marked by <code>-></code>. This syntax is particularly useful in function templates where the return type depends on the arguments. For instance:
</p>

{{< prism lang="rust">}}
template<class T, class U>
auto product(const vector<T>& x, const vector<U>& y) -> decltype(x*y);
{{< /prism >}}
<p style="text-align: justify;">
This suffix return type syntax is similar to that used in lambda expressions, although they are not identical. Functions that do not return a value are specified with a return type of <code>void</code>.
</p>

<p style="text-align: justify;">
For non-void functions, a return value must be provided. Conversely, it is an error to return a value from a void function. The return value is specified using a return statement:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn fac(n: i32) -> i32 {
    if n > 1 { n * fac(n - 1) } else { 1 }
}
{{< /prism >}}
<p style="text-align: justify;">
A function that calls itself is considered recursive. Multiple return statements can be used within a function:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn fac2(n: i32) -> i32 {
    if n > 1 {
        return n * fac2(n - 1);
    }
    1
}
{{< /prism >}}
<p style="text-align: justify;">
The semantics of returning a value are the same as those of copy initialization. The return expression is checked against the return type, and necessary type conversions are performed.
</p>

<p style="text-align: justify;">
Each function call creates new copies of its arguments and local variables. Therefore, returning a pointer or reference to a local non-static variable is problematic because the variable's memory will be reused after the function returns:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn fp() -> &i32 {
    let local = 1;
    &local // this is problematic
}
{{< /prism >}}
<p style="text-align: justify;">
Similarly, returning a reference to a local variable is also an error:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn fr() -> &i32 {
    let local = 1;
    local // this is problematic
}
{{< /prism >}}
<p style="text-align: justify;">
Compilers typically warn about such issues. Although there are no void values, a call to a void function can be used as the return value of another void function:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn g(p: &i32);
fn h(p: &i32) {
    return g(p); // equivalent to g(p); return;
}
{{< /prism >}}
<p style="text-align: justify;">
This form of return is useful in template functions where the return type is a template parameter. A function can exit in several ways:
</p>

- <p style="text-align: justify;">Executing a return statement.</p>
- <p style="text-align: justify;">Reaching the end of the function body in void functions and main(), indicating successful completion.</p>
- <p style="text-align: justify;">Throwing an uncaught exception.</p>
- <p style="text-align: justify;">Terminating due to an uncaught exception in a noexcept function.</p>
- <p style="text-align: justify;">Invoking a system function that does not return (e.g., exit()).</p>
<p style="text-align: justify;">
Functions that do not return normally can be marked with <code>[[noreturn]]</code>.
</p>

## 14.6. inline Functions
<p style="text-align: justify;">
Defining a function as inline suggests to the compiler that it should attempt to generate inline code at each call site rather than using the standard function call mechanism. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
inline fn fac(n: i32) -> i32 {
    if n < 2 { 1 } else { n * fac(n - 1) }
}
{{< /prism >}}
<p style="text-align: justify;">
The inline specifier is a hint for the compiler to replace the function call with the function code itself, which can optimize calls like <code>fac(6)</code> into a constant value such as 720. However, the extent to which this inlining occurs depends on the compiler's optimization capabilities. Some compilers might produce the constant 720, others might compute <code>6 * fac(5)</code> recursively, and others might not inline the function at all. For assured compile-time evaluation, declare the function as <code>constexpr</code> and ensure all functions it calls are also <code>constexpr</code>.
</p>

<p style="text-align: justify;">
To make inlining possible, the function definition must be available in the same scope as its declaration. The inline specifier does not change the function's semantics; an inline function still has a unique address, and so do any static variables within it.
</p>

<p style="text-align: justify;">
If an inline function is defined in multiple translation units (for example, by including it in a header file used in different source files), the definition must be identical in each translation unit to ensure consistent behavior.
</p>

## 14.7. constexpr Functions
<p style="text-align: justify;">
Generally, functions are not evaluated at compile time and thus cannot be used in constant expressions. By marking a function as <code>constexpr</code>, you indicate that it can be evaluated at compile time when given constant arguments. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
const fn fac(n: i32) -> i32 {
    if n > 1 { n * fac(n - 1) } else { 1 }
}

const F9: i32 = fac(9); // This must be evaluated at compile time
{{< /prism >}}
<p style="text-align: justify;">
Using <code>constexpr</code> in a function definition means that the function can be used in constant expressions with constant arguments. For an object, it means its initializer must be evaluated at compile time. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(n: i32) {
    let f5 = fac(5); // Might be evaluated at compile time
    let fn_var = fac(n); // Evaluated at runtime since n is a variable
    const F6: i32 = fac(6); // Must be evaluated at compile time
    // const Fnn: i32 = fac(n); // Error: can't guarantee compile-time evaluation for n
    let a: [u8; fac(4) as usize]; // OK: array bounds must be constants and fac() is constexpr
    // let a2: [u8; fac(n) as usize]; // Error: array bounds must be constants, n is a variable
}
{{< /prism >}}
<p style="text-align: justify;">
To be evaluated at compile time, a function must be simple: it should consist of a single return statement, without loops or local variables, and it must not have side effects, meaning it should be a pure function. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
let mut glob: i32 = 0;

const fn bad1(a: i32) {
    // glob = a; // Error: side effect in constexpr function
}

const fn bad2(a: i32) -> i32 {
    if a >= 0 { a } else { -a } // Error: if statement in constexpr function
}

const fn bad3(a: i32) -> i32 {
    let mut sum = 0;
    // for i in 0..a { sum += fac(i); } // Error: loop in constexpr function
    sum
}
{{< /prism >}}
<p style="text-align: justify;">
The rules for a <code>constexpr</code> constructor are different, allowing only simple member initialization.
</p>

<p style="text-align: justify;">
A <code>constexpr</code> function supports recursion and conditional expressions, enabling a broad range of operations. However, overusing <code>constexpr</code> for complex tasks can complicate debugging and increase compile times. It is best to reserve <code>constexpr</code> functions for simpler tasks they are intended for.
</p>

<p style="text-align: justify;">
Using literal types, <code>constexpr</code> functions can work with user-defined types. Similar to inline functions, <code>constexpr</code> functions follow the one-definition rule (ODR), requiring identical definitions in different translation units. Think of <code>constexpr</code> functions as a more restricted form of inline functions.
</p>

## 14.8. Conditional Evaluation
<p style="text-align: justify;">
In a <code>constexpr</code> function, branches of conditional expressions that are not executed are not evaluated. This allows a branch that isn't taken to still require run-time evaluation. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
const fn check(i: i32) -> i32 {
    if LOW <= i && i < HIGH {
        i
    } else {
        panic!("out_of_range");
    }
}

const LOW: i32 = 0;
const HIGH: i32 = 99;

// ...

const VAL: i32 = check(f(x, y, z));
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>LOW</code> and <code>HIGH</code> can be considered configuration parameters that are known at compile time, but not at design time. The function <code>f(x, y, z)</code> computes a value based on implementation specifics. This example illustrates how conditional evaluation in <code>constexpr</code> functions can handle compile-time constants while permitting run-time calculations when needed.
</p>

## 14.9. \[\[noreturn\]\] Functions
<p style="text-align: justify;">
The construct <code>#[...]</code> is referred to as an attribute and can be used in various parts of Rust's syntax. Attributes generally specify some implementation-specific property about the syntax element that follows them. One such attribute is <code>#[noreturn]</code>.
</p>

<p style="text-align: justify;">
When you place <code>#[noreturn]</code> at the beginning of a function declaration, it indicates that the function is not supposed to return. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[noreturn]
fn exit(code: i32) -> ! {
    // implementation that never returns
}
{{< /prism >}}
<p style="text-align: justify;">
Knowing that a function does not return helps in understanding the code and can assist in optimizing it. However, if a function marked with <code>#[noreturn]</code> does return, the behavior is undefined.
</p>

## 14.10. Local Variables
<p style="text-align: justify;">
In a function, names defined are generally referred to as local names. When a local variable or constant is initialized, it occurs when the execution thread reaches its definition. If not declared as <code>static</code>, each call to the function creates its own instance of the variable. On the other hand, if a local variable is declared <code>static</code>, a single statically allocated object is used for that variable across all function calls, initializing only the first time the execution thread encounters it.
</p>

<p style="text-align: justify;">
For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(mut a: i32) {
    while a > 0 {
        static mut N: i32 = 0; // Initialized once
        let x: i32 = 0; // Initialized on each call of f()

        unsafe {
            println!("n == {}, x == {}", N, x);
            N += 1;
        }
        a -= 1;
    }
}

fn main() {
    f(3);
}
{{< /prism >}}
<p style="text-align: justify;">
This code will output:
</p>

{{< prism lang="rust" line-numbers="true">}}
n == 0, x == 0
n == 1, x == 0
n == 2, x == 0
{{< /prism >}}
<p style="text-align: justify;">
The use of a static local variable enables a function to retain information between calls without needing a global variable that could be accessed or altered by other functions. The initialization of a static local variable does not cause a data race unless the function containing it is entered recursively or a deadlock occurs. Rust handles this by protecting the initialization of a local static variable with constructs like <code>std::sync::Once</code>. However, recursively initializing a static local variable leads to undefined behavior.
</p>

<p style="text-align: justify;">
Static local variables help avoid dependencies among nonlocal variables. If you need a local function, consider using a closure or a function object instead. In Rust, the scope of a label spans the entire function, regardless of the nested scope where it might be located.
</p>

## 14.11. Argument Passing
<p style="text-align: justify;">
When a function is called using the call operator <code>()</code>, memory is allocated for its parameters, and each parameter is initialized with its corresponding argument. This process follows the same rules as copy initialization, meaning the types of the arguments are checked against the types of the parameters, and necessary conversions are performed. If a parameter is not a reference, a copy of the argument is passed to the function.
</p>

<p style="text-align: justify;">
For instance, consider a function that searches for a value in an array slice:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn find(slice: &[i32], value: i32) -> Option<usize> {
    for (index, &element) in slice.iter().enumerate() {
        if element == value {
            return Some(index);
        }
    }
    None
}

fn g(slice: &[i32]) {
    if let Some(index) = find(slice, 'x' as i32) {
        // ...
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the original slice passed to the <code>find</code> function within <code>g</code> remains unmodified since slices are passed by reference in Rust.
</p>

<p style="text-align: justify;">
Rust has particular rules for passing arrays and allows for unchecked arguments through the use of <code>unsafe</code> blocks. Default arguments can be handled using function overloading or optional parameters with <code>Option</code>. Initializer lists are supported via macros or custom initializers, and argument passing in generic functions is handled in a type-safe manner.
</p>

<p style="text-align: justify;">
This approach ensures that arguments are passed efficiently and safely, adhering to Rust’s principles of ownership and borrowing.
</p>

## 14.12. Reference Arguments
<p style="text-align: justify;">
Understanding how to pass arguments to functions is essential, particularly the distinction between passing by value and passing by reference. When a function takes an argument by value, it creates a copy of the original data, which means changes within the function do not affect the original variable. Conversely, passing by reference allows the function to modify the original variable.
</p>

<p style="text-align: justify;">
Consider a function <code>f</code> that takes two parameters: an integer by value and another integer by reference. Incrementing the value parameter only changes the local copy within the function, while incrementing the reference parameter modifies the actual argument passed to the function.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(mut val: i32, ref: &mut i32) {
    val += 1;
    *ref += 1;
}
{{< /prism >}}
<p style="text-align: justify;">
If we invoke this function with two integers, the first integer remains unchanged outside the function, while the second integer is incremented.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn g() {
    let mut i = 1;
    let mut j = 1;
    f(i, &mut j);
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>i</code> stays <code>1</code> after the function call, whereas <code>j</code> becomes <code>2</code>. Using functions that modify call-by-reference arguments can make programs harder to read and should generally be avoided unless necessary. However, passing large objects by reference can be more efficient than passing by value. In such scenarios, declaring the parameter as a <code>const</code> reference ensures the function does not modify the object.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(arg: &Large) {
    // arg cannot be modified
}
{{< /prism >}}
<p style="text-align: justify;">
When a reference parameter is not marked as <code>const</code>, it implies an intention to modify the variable.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn g(arg: &mut Large) {
    // assume g modifies arg
}
{{< /prism >}}
<p style="text-align: justify;">
Similarly, declaring pointer parameters as <code>const</code> indicates the function will not alter the object being pointed to.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn strlen(s: &str) -> usize {
    // returns the length of the string
}
{{< /prism >}}
<p style="text-align: justify;">
Using <code>const</code> increases code clarity and reduces potential errors, especially in larger programs. The rules for reference initialization allow literals, constants, and arguments requiring conversion to be passed as <code>const T&</code> but not as non-const <code>T&</code>. This ensures safe and efficient passing of arguments without unintended temporaries.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn update(i: &mut f32) {
    // updates the value of i
}
{{< /prism >}}
<p style="text-align: justify;">
Passing arguments by rvalue references enables functions to modify temporary objects or objects about to be destroyed, which is useful for implementing move semantics.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(v: Vec<i32>) {
    // takes ownership of v
}

fn g(vi: &mut Vec<i32>, cvi: &Vec<i32>) {
    f(vi.clone());
    f(cvi.clone());
    f(vec![1, 2, 3, 4]);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the function <code>f</code> can accept vectors and modify them, making it suitable for move semantics. Generally, rvalue references are used for defining move constructors and move assignments.
</p>

<p style="text-align: justify;">
When deciding how to pass arguments, consider these guidelines:
</p>

1. <p style="text-align: justify;">Use pass-by-value for small objects.</p>
2. <p style="text-align: justify;">Use pass-by-const-reference for large objects that don't need modification.</p>
3. <p style="text-align: justify;">Return results directly instead of modifying arguments.</p>
4. <p style="text-align: justify;">Use rvalue references for move semantics and forwarding.</p>
5. <p style="text-align: justify;">Use pointers if "no object" is a valid option (represented by <code>Option</code>).</p>
6. <p style="text-align: justify;">Use pass-by-reference only when necessary.</p>
<p style="text-align: justify;">
Following these guidelines ensures efficient and clear argument passing, maintaining the principles of ownership and borrowing.
</p>

## 14.13. Array Arguments
<p style="text-align: justify;">
When an array is used as a function argument, a pointer to its first element is passed. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn strlen(s: &str) -> usize {
    s.len()
}

fn f() {
    let v = "Annemarie";
    let i = strlen(v);
    let j = strlen("Nicholas");
}
{{< /prism >}}
<p style="text-align: justify;">
This means that an argument of type <code>T[]</code> will be converted to <code>T*</code> when passed to a function, allowing modifications to array elements within the function. Unlike other types, arrays are passed by pointer rather than by value.
</p>

<p style="text-align: justify;">
A parameter of array type is equivalent to a parameter of pointer type. For instance:
</p>

{{< prism lang="rust">}}
fn process_array(p: &mut [i32]) {}
fn process_array_ref(buf: &mut [i32]) {}
{{< /prism >}}
<p style="text-align: justify;">
Both declarations are equivalent and represent the same function. The names of the arguments do not affect the function's type. The rules for passing multidimensional arrays are similar.
</p>

<p style="text-align: justify;">
The size of an array is not inherently available to the called function, which can lead to errors. One solution is to pass the size of the array as an additional parameter:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn compute1(vec: &[i32]) {
    let vec_size = vec.len();
    // computation
}
{{< /prism >}}
<p style="text-align: justify;">
However, it is often better to pass a reference to a container like a vector or an array for more safety and flexibility. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn process_fixed_array(arr: &[i32; 4]) {
    // use array
}

fn example_usage() {
    let a1 = [1, 2, 3, 4];
    let a2 = [1, 2];
    process_fixed_array(&a1); // OK
    // process_fixed_array(&a2); // error: wrong number of elements
}
{{< /prism >}}
<p style="text-align: justify;">
The number of elements is part of the reference-to-array type, making it less flexible than pointers or containers. References to arrays are especially useful in templates where the number of elements can be deduced:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn process_generic_array<T, const N: usize>(arr: &[T; N]) {
    // use array
}

fn example_generic_usage() {
    let a1 = [1; 10];
    let a2 = [2.0; 100];
    process_generic_array(&a1); // T is i32, N is 10
    process_generic_array(&a2); // T is f64, N is 100
}
{{< /prism >}}
<p style="text-align: justify;">
This method generates as many function definitions as there are calls with distinct array types. For multidimensional arrays, using arrays of pointers can often avoid special treatment:
</p>

{{< prism lang="rust">}}
let days: [&str; 7] = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
{{< /prism >}}
<p style="text-align: justify;">
Generally, using vectors and similar types is a better alternative to low-level arrays and pointers, providing safer and more readable code.
</p>

## 14.14. List Arguments
<p style="text-align: justify;">
A list enclosed in {} can be used as an argument for:
</p>

1. <p style="text-align: justify;">A parameter of type <code>std::initializer_list<T></code>, where the elements can be implicitly converted to type <code>T</code>.</p>
2. <p style="text-align: justify;">A type that can be initialized with the values provided in the list.</p>
3. <p style="text-align: justify;">A reference to an array of <code>T</code>, where the elements can be implicitly converted to <code>T</code>.</p>
<p style="text-align: justify;">
Technically, the first case covers all scenarios, but it’s often clearer to consider each separately. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f1<T>(list: &[T]) {}
struct S {
    a: i32,
    s: String,
}
fn f2(s: S) {}
fn f3<T, const N: usize>(arr: &[T; N]) {}
fn f4(n: i32) {}

fn g() {
    f1(&[1, 2, 3, 4]); // T is i32 and the list has 4 elements
    f2(S { a: 1, s: "MKS".to_string() }); // f2(S { a: 1, s: "MKS".to_string() })
    f3(&[1, 2, 3, 4]); // T is i32 and N is 4
    f4(1); // f4(i32::from(1))
}
{{< /prism >}}
<p style="text-align: justify;">
In cases where there might be ambiguity, a parameter with <code>initializer_list</code> takes precedence. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f<T>(list: &[T]) {}
struct S {
    a: i32,
    s: String,
}
fn f(s: S) {}
fn f<T, const N: usize>(arr: &[T; N]) {}
fn f(n: i32) {}

fn g() {
    f(&[1, 2, 3, 4]); // T is i32 and the list has 4 elements
    f(S { a: 1, s: "MKS".to_string() }); // calls f(S)
    f(&[1]); // T is i32 and the list has 1 element
}
{{< /prism >}}
<p style="text-align: justify;">
The reason an <code>initializer_list</code> parameter is given priority is to avoid confusion if different functions were selected based on the number of elements in the list. While it’s impossible to eliminate all forms of confusion in overload resolution, prioritizing <code>initializer_list</code> parameters for {}-list arguments helps reduce it.
</p>

<p style="text-align: justify;">
If a function with an <code>initializer_list</code> parameter is in scope, but the list argument doesn't match, another function can be chosen. The call <code>f({1, "MKS"})</code> is an example of this. Note that these rules specifically apply to <code>std::initializer_list<T></code> arguments. There are no special rules for <code>std::initializer_list<T>&</code> or for other types named <code>initializer_list</code> in different scopes.
</p>

## 14.15. Unspecified Number of Arguments
<p style="text-align: justify;">
There are situations where specifying the number and type of all function arguments isn't feasible. In such cases, you have three main options:
</p>

- <p style="text-align: justify;">Variadic Templates: This method allows you to manage an arbitrary number of arguments of different types in a type-safe manner. By using a template metaprogram, you can interpret the argument list and perform the necessary actions.</p>
- <p style="text-align: justify;">Initializer Lists: Using <code>std::initializer_list</code> as the argument type lets you handle an arbitrary number of arguments of a single type safely. This is particularly useful for homogeneous lists, which are common in many contexts.</p>
- <p style="text-align: justify;">Ellipsis (<code>...</code>): Terminating the argument list with ellipsis allows handling an arbitrary number of arguments of almost any type using macros from <code><cstdarg></code>. While this approach is not inherently type-safe and can be cumbersome with complex user-defined types, it has been in use since the early days of C.</p>
<p style="text-align: justify;">
The first two methods are described elsewhere. Here, we'll focus on the third method, despite its limitations in most scenarios. For instance, consider a function declaration like this:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn printf(format: &str, args: ...) -> i32 {
    // Implementation details
}
{{< /prism >}}
<p style="text-align: justify;">
This declaration specifies that a call to <code>printf</code> must have at least one argument (a format string), but may include additional arguments. Examples of its usage include:
</p>

{{< prism lang="rust" line-numbers="true">}}
printf("Hello, world!\n");
printf("My name is %s %s\n", first_name, second_name);
printf("%d + %d = %d\n", 2, 3, 5);
{{< /prism >}}
<p style="text-align: justify;">
Functions using unspecified arguments must rely on additional information (like a format string) to interpret the argument list correctly. However, this approach often bypasses the compiler's ability to check argument types and counts, leading to potential errors. For example:
</p>

{{< prism lang="rust">}}
std::printf("My name is %s %s\n", 2);
{{< /prism >}}
<p style="text-align: justify;">
Although invalid, this code may not be flagged by the compiler, resulting in unpredictable behavior.
</p>

<p style="text-align: justify;">
In scenarios where argument types and numbers can't be entirely specified, a well-designed program might only need a few such functions. Alternatives like overloaded functions, default arguments, <code>initializer_list</code> arguments, and variadic templates should be used whenever possible to maintain type safety and clarity.
</p>

<p style="text-align: justify;">
For instance, the traditional <code>printf</code> function from the C library:
</p>

{{< prism lang="rust">}}
int printf(const char* format, ...);
{{< /prism >}}
<p style="text-align: justify;">
To handle variadic arguments, you might use a combination of <code>va_list</code>, <code>va_start</code>, <code>va_arg</code>, and <code>va_end</code> macros from <code><cstdarg></code>. Alternatively, a safer and more modern approach involves <code>std::initializer_list</code>:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn error(severity: i32, args: std::initializer_list<&str>) {
    for arg in args {
        eprintln!("{}", arg);
    }
    if severity > 0 {
        std::process::exit(severity);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
You could then call this function with a list of string arguments:
</p>

{{< prism lang="rust">}}
error(1, {"Error:", "Invalid input", "Please try again"});
{{< /prism >}}
<p style="text-align: justify;">
Integrating these concepts in a modern programming context helps maintain type safety and readability while managing varying numbers of arguments effectively. This aligns with best practices in software development, ensuring that your programs are robust and maintainable.
</p>

## 14.16. Default Arguments
<p style="text-align: justify;">
In many cases, functions require multiple parameters to handle complex scenarios effectively, especially constructors that offer various ways to create objects. Consider a <code>Complex</code> class:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Complex {
    re: f64,
    im: f64,
}

impl Complex {
    fn new(r: f64, i: f64) -> Complex {
        Complex { re: r, im: i }
    }

    fn from_real(r: f64) -> Complex {
        Complex { re: r, im: 0.0 }
    }

    fn default() -> Complex {
        Complex { re: 0.0, im: 0.0 }
    }
}
{{< /prism >}}
<p style="text-align: justify;">
While the actions of these constructors are straightforward, having multiple functions performing similar tasks can lead to redundancy. This redundancy is more apparent when constructors involve complex logic. To reduce repetition, one constructor can call another:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Complex {
    fn new(r: f64, i: f64) -> Complex {
        Complex { re: r, im: i }
    }

    fn from_real(r: f64) -> Complex {
        Complex::new(r, 0.0)
    }

    fn default() -> Complex {
        Complex::new(0.0, 0.0)
    }
}
{{< /prism >}}
<p style="text-align: justify;">
This consolidation allows for easier implementation of additional functionalities, such as debugging or logging, in a single place. Further simplification can be achieved with default arguments:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Complex {
    fn new(r: f64 = 0.0, i: f64 = 0.0) -> Complex {
        Complex { re: r, im: i }
    }
}
{{< /prism >}}
<p style="text-align: justify;">
With default arguments, if fewer arguments are provided, default values are automatically used. This method clarifies that fewer arguments can be supplied, and defaults will be used as needed, making the constructor's intent explicit and reducing redundancy.
</p>

<p style="text-align: justify;">
A default argument is type-checked when the function is declared and evaluated when the function is called. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct X {
    def_arg: i32,
}

impl X {
    fn new() -> X {
        X { def_arg: 7 }
    }

    fn f(&self, arg: i32 = self.def_arg) {
        // Function implementation
    }
}

fn main() {
    let mut a = X::new();
    a.f(); // Uses default argument 7
    a.def_arg = 9;
    a.f(); // Uses updated default argument 9
}
{{< /prism >}}
<p style="text-align: justify;">
However, changing default arguments can introduce subtle dependencies and should generally be avoided. Default arguments can only be provided for trailing parameters. For example:
</p>

{{< prism lang="rust">}}
fn f(a: i32, b: i32 = 0, c: Option<&str> = None) { /*...*/ } // OK
fn g(a: i32 = 0, b: i32, c: Option<&str>) { /*...*/ } // Error
{{< /prism >}}
<p style="text-align: justify;">
Reusing or altering a default argument in subsequent declarations in the same scope is not allowed:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(x: i32 = 7); // Initial declaration
fn f(x: i32 = 7); // Error: cannot repeat default argument
fn f(x: i32 = 8); // Error: different default arguments

fn main() {
    fn f(x: i32 = 9); // OK: hides outer declaration
    // ...
}
{{< /prism >}}
<p style="text-align: justify;">
Hiding a declaration with a nested scope can lead to errors and should be handled cautiously.
</p>

<p style="text-align: justify;">
By utilizing default arguments appropriately, you can simplify function declarations, reduce redundancy, and make your code more maintainable and understandable.
</p>

## 14.17. Overloaded Functions
<p style="text-align: justify;">
While it's often recommended to give distinct names to different functions, there are situations where it makes sense to use the same name for functions that perform similar tasks on different types. This practice is known as overloading. For example, the addition operator (+) is used for both integers and floating-point numbers. This concept can be extended to user-defined functions, allowing the same name to be reused for different parameter types. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn print(x: i32) {
    println!("{}", x);
}

fn print(s: &str) {
    println!("{}", s);
}
{{< /prism >}}
<p style="text-align: justify;">
In the compiler's view, overloaded functions share only their name; they may perform entirely different tasks. The language does not enforce any similarity between them, leaving it up to the programmer. Using overloaded function names can make code more intuitive, especially for commonly used operations like <code>print</code>, <code>sqrt</code>, and <code>open</code>.
</p>

<p style="text-align: justify;">
This approach is essential when the function name holds significant meaning, such as with operators like <code>+</code>, <code>*</code>, and <code><<</code>, or with constructors in generic programming. Rust's traits and generics provide a structured way to implement overloaded functions, enabling the use of the same function name with different types safely and efficiently.
</p>

## 14.18. Automatic Overload Resolution
<p style="text-align: justify;">
When a function called <code>fct</code> is invoked, the compiler needs to determine which specific version of <code>fct</code> to execute by comparing the types of the actual arguments with the types of the parameters for all functions named <code>fct</code> in scope. The goal is to match the arguments to the parameters of the best-fitting function and produce a compile-time error if no suitable function is found. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn print(x: f64) {
    println!("{}", x);
}

fn print(x: i64) {
    println!("{}", x);
}

fn f() {
    print(1i64);  // Calls print(i64)
    print(1.0);   // Calls print(f64)
    // print(1);  // Error: ambiguous, could match print(i64) or print(f64)
}
{{< /prism >}}
<p style="text-align: justify;">
To decide which function to call, the compiler uses a hierarchy of criteria:
</p>

- <p style="text-align: justify;">Exact match, using no or only trivial conversions (e.g., reference adjustments or dereferencing).</p>
- <p style="text-align: justify;">Match using promotions, such as converting smaller integer types to larger ones or promoting <code>f32</code> to <code>f64</code>.</p>
- <p style="text-align: justify;">Match using standard conversions (e.g., <code>i32</code> to <code>f64</code>, <code>f64</code> to <code>i32</code>, pointer conversions).</p>
- <p style="text-align: justify;">Match using user-defined conversions.</p>
- <p style="text-align: justify;">Match using the ellipsis (<code>...</code>) in a function declaration.</p>
<p style="text-align: justify;">
If there are two matches at the highest level of criteria, the call is considered ambiguous and results in a compile-time error. These detailed resolution rules primarily handle the complexity of numeric type conversions.
</p>

<p style="text-align: justify;">
For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn print(x: i32) {
    println!("{}", x);
}

fn print(x: &str) {
    println!("{}", x);
}

fn print(x: f64) {
    println!("{}", x);
}

fn print(x: i64) {
    println!("{}", x);
}

fn print(x: char) {
    println!("{}", x);
}

fn h(c: char, i: i32, s: i16, f: f32) {
    print(c);        // Calls print(char)
    print(i);        // Calls print(i32)
    print(s);        // Promotes s to i32 and calls print(i32)
    print(f);        // Promotes f to f64 and calls print(f64)
    print('a');      // Calls print(char)
    print(49);       // Calls print(i32)
    print(0);        // Calls print(i32)
    print("a");      // Calls print(&str)
}
{{< /prism >}}
<p style="text-align: justify;">
The call to <code>print(0)</code> selects <code>print(i32)</code> because <code>0</code> is an integer literal. Similarly, <code>print('a')</code> calls <code>print(char)</code> since <code>'a'</code> is a character. These rules prioritize safe promotions over potentially unsafe conversions.
</p>

<p style="text-align: justify;">
Overload resolution in Rust is independent of the order in which functions are declared. Function templates are resolved by applying overload resolution rules after specializing the templates based on provided arguments. Special rules also exist for overloading with initializer lists and rvalue references.
</p>

<p style="text-align: justify;">
Although overloading relies on a complex set of rules, which can sometimes lead to unexpected function calls, it simplifies the programmer's job by allowing the same function name to be used for different types. Without overloading, we would need multiple function names for similar operations on different types, leading to tedious and error-prone code. For example, without overloading, one might need:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn print_int(x: i32) {
    println!("{}", x);
}

fn print_char(x: char) {
    println!("{}", x);
}

fn print_str(x: &str) {
    println!("{}", x);
}

fn g(i: i32, c: char, p: &str, d: f64) {
    print_int(i);    // OK
    print_char(c);   // OK
    print_str(p);    // OK
    print_int(c as i32);    // OK, but may print unexpected number
    print_char(i as char);  // OK, but may narrow unexpectedly
    // print_str(i);  // Error
    print_int(d as i32);    // OK, but narrowing conversion
}
{{< /prism >}}
<p style="text-align: justify;">
Without overloading, the programmer has to remember multiple function names and use them correctly, which can be cumbersome and prone to errors. Overloading allows the same function name to be used for different types, increasing the chances that unsuitable arguments will be caught by the compiler and reducing the likelihood of type-related errors.
</p>

## 14.19. Overloading and Return Type
<p style="text-align: justify;">
Return types are not factored into function overload resolution. This design choice ensures that determining which function to call remains straightforward and context-independent. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn sqrt(x: f32) -> f32 {
    // implementation for f32
}

fn sqrt(x: f64) -> f64 {
    // implementation for f64
}

fn f(da: f64, fla: f32) {
    let fl: f32 = sqrt(da); // calls sqrt(f64)
    let d: f64 = sqrt(da); // calls sqrt(f64)
    let fl = sqrt(fla); // calls sqrt(f32)
    let d = sqrt(fla); // calls sqrt(f32)
}
{{< /prism >}}
<p style="text-align: justify;">
If the return type were considered during overload resolution, it would no longer be possible to look at a function call in isolation to determine which function is being invoked. This would complicate the resolution process, requiring the context of each call to identify the correct function. By excluding return types from overload resolution, the language ensures that each function call can be resolved based solely on its arguments, maintaining clarity and simplicity.
</p>

## 14.20. Overloading and Scope
<p style="text-align: justify;">
Overloading occurs within the same scope, meaning functions declared in different, non-namespace scopes do not participate in overloading together. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(x: i32) {
    // implementation for i32
}

fn g() {
    fn f(x: f64) {
        // implementation for f64
    }
    f(1); // calls f(f64)
}
{{< /prism >}}
<p style="text-align: justify;">
Here, although <code>f(i32)</code> would be a better match for <code>f(1)</code>, only <code>f(f64)</code> is in scope. Local declarations can be adjusted to achieve the desired behavior. Intentional hiding can be useful, but unintentional hiding can lead to unexpected results.
</p>

<p style="text-align: justify;">
For base and derived classes, different scopes prevent overloading between base and derived class functions by default:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Base {
    fn f(&self, x: i32) {
        // implementation for Base
    }
}

struct Derived : Base {
    fn f(&self, x: f64) {
        // implementation for Derived
    }
}

fn g(d: &Derived) {
    d.f(1); // calls Derived::f(f64)
}
{{< /prism >}}
<p style="text-align: justify;">
When overloading across class or namespace scopes is necessary, <code>use</code> declarations or directives can be employed. Additionally, argument-dependent lookup can facilitate overloading across namespaces. This ensures that overloading remains controlled and predictable, improving code readability and maintainability.
</p>

## 14.21. Resolution for Multiple Arguments
<p style="text-align: justify;">
Overload resolution rules are utilized to select the most appropriate function when multiple arguments are involved, aiming for efficiency and precision across different data types. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn pow(base: i32, exp: i32) -> i32 {
    // implementation for integers
}

fn pow(base: f64, exp: f64) -> f64 {
    // implementation for floating-point numbers
}

fn pow(base: f64, exp: Complex) -> Complex {
    // implementation for double and complex numbers
}

fn pow(base: Complex, exp: i32) -> Complex {
    // implementation for complex and integer
}

fn pow(base: Complex, exp: Complex) -> Complex {
    // implementation for complex numbers
}

fn k(z: Complex) {
    let i = pow(2, 2); // calls pow(i32, i32)
    let d = pow(2.0, 2.0); // calls pow(f64, f64)
    let z2 = pow(2.0, z); // calls pow(f64, Complex)
    let z3 = pow(z, 2); // calls pow(Complex, i32)
    let z4 = pow(z, z); // calls pow(Complex, Complex)
}
{{< /prism >}}
<p style="text-align: justify;">
When the compiler selects the best match among overloaded functions with multiple arguments, it finds the optimal match for each argument. A function is chosen if it is the best match for at least one argument and an equal or better match for all other arguments. If no such function exists, the call is considered ambiguous:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn g() {
    let d = pow(2.0, 2); // error: pow(i32::from(2.0), 2) or pow(2.0, f64::from(2))?
}
{{< /prism >}}
<p style="text-align: justify;">
In this case, the call is ambiguous because <code>2.0</code> is the best match for the first argument of <code>pow(f64, f64)</code> and <code>2</code> is the best match for the second argument of <code>pow(i32, i32)</code>.
</p>

## 14.22. Manual Overload Resolution
<p style="text-align: justify;">
When functions are overloaded either too little or too much, it can lead to ambiguities. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f1(ch: char) {
    // implementation for char
}

fn f1(num: i64) {
    // implementation for i64
}

fn f2(ptr: &mut char) {
    // implementation for char pointer
}

fn f2(ptr: &mut i32) {
    // implementation for int pointer
}

fn k(i: i32) {
    f1(i); // ambiguous: f1(char) or f1(i64)?
    f2(0 as *mut i32); // ambiguous: f2(&mut char) or f2(&mut i32)?
}
{{< /prism >}}
<p style="text-align: justify;">
To avoid these issues, consider the entire set of overloaded functions to ensure they make sense together. Often, adding a specific version can resolve ambiguities. For example, adding:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f1(n: i32) {
    f1(n as i64);
}
{{< /prism >}}
<p style="text-align: justify;">
This resolves ambiguities like <code>f1(i)</code> in favor of the larger type <code>i64</code>.
</p>

<p style="text-align: justify;">
Explicit type conversion can also address specific calls:
</p>

{{< prism lang="rust">}}
f2(0 as *mut i32);
{{< /prism >}}
<p style="text-align: justify;">
However, this approach is often just a temporary fix and doesn't solve the core issue. Similar calls might appear and need to be handled.
</p>

<p style="text-align: justify;">
While beginners might find ambiguity errors frustrating, experienced programmers see these errors as helpful indicators of potential design flaws.
</p>

## 14.23. Pre- and Postconditions
<p style="text-align: justify;">
Functions come with expectations regarding their arguments. Some of these expectations are defined by the argument types, while others depend on the actual values and relationships between them. Although the compiler and linker can ensure type correctness, managing invalid argument values falls to the programmer. Preconditions are the logical criteria that should be true when a function is called, while postconditions are criteria that should be true when a function returns.
</p>

<p style="text-align: justify;">
For example, consider a function that calculates the area of a rectangle:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn area(len: i32, wid: i32) -> i32 {
    // Preconditions: len and wid must be positive
    // Postconditions: the return value must be positive and represent the area of the rectangle with sides len and wid
    len * wid
}
{{< /prism >}}
<p style="text-align: justify;">
Documenting preconditions and postconditions like this is beneficial. It helps the function’s implementer, users, and testers understand the function's requirements and guarantees. For instance, values like 0 and -12 are invalid arguments. Moreover, if very large values are passed, the result might overflow, violating the postconditions.
</p>

<p style="text-align: justify;">
Consider calling <code>area(i32::MAX, 2)</code>:
</p>

- <p style="text-align: justify;">Should the caller avoid such calls? Ideally, yes, but mistakes happen.</p>
- <p style="text-align: justify;">Should the implementer handle these cases? If so, how should errors be managed?</p>
<p style="text-align: justify;">
Various approaches exist. It’s easy for callers to overlook preconditions, and it’s challenging for implementers to check all preconditions efficiently. While reliance on the caller is preferred, a mechanism to ensure correctness is necessary. Some pre- and postconditions are easy to verify (e.g., <code>len</code> is positive), while others, like verifying "the return value is the area of a rectangle with sides <code>len</code> and <code>wid</code>," are more complex and semantic.
</p>

<p style="text-align: justify;">
Writing out pre- and postconditions can reveal subtle issues in a function. This practice not only aids in design and documentation but also helps in identifying potential problems early.
</p>

<p style="text-align: justify;">
For functions that depend solely on their arguments, preconditions apply only to those arguments. However, for functions relying on non-local values (e.g., member functions dependent on an object's state), these values must be considered as implicit arguments. Similarly, postconditions for side-effect-free functions ensure the value is correctly computed. If a function modifies non-local objects, these effects must also be documented.
</p>

<p style="text-align: justify;">
Function developers have several options:
</p>

- <p style="text-align: justify;">Ensure every input results in a valid output, eliminating preconditions.</p>
- <p style="text-align: justify;">Assume the caller ensures preconditions are met.</p>
- <p style="text-align: justify;">Check preconditions and throw an exception if they fail.</p>
- <p style="text-align: justify;">Check preconditions and terminate the program if they fail.</p>
<p style="text-align: justify;">
If a postcondition fails, it indicates either an unchecked precondition or a programming error.
</p>

## 14.24. Pointer to Function
<p style="text-align: justify;">
Just as data objects have memory addresses, the code for a function is stored in memory and can be referenced through an address. We can use pointers to functions similarly to how we use pointers to objects, but function pointers are limited to calling the function and taking its address.
</p>

<p style="text-align: justify;">
To declare a pointer to a function, you specify it similarly to the function's own declaration. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn error(s: String) { /* ... */ }
let mut efct: fn(String) = error;
efct("error".to_string());
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>efct</code> is a function pointer that points to the <code>error</code> function and can be used to call <code>error</code>.
</p>

<p style="text-align: justify;">
Function pointers must match the complete function type, including argument types and return type, exactly. Consider the following example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f1(s: String) {}
fn f2(s: String) -> i32 { 0 }
fn f3(p: &i32) {}

let mut pf: fn(String);

pf = f1; // OK
pf = f2; // error: mismatched return type
pf = f3; // error: mismatched argument type
{{< /prism >}}
<p style="text-align: justify;">
Casting function pointers to different types is possible but should be done with caution as it can lead to undefined behavior. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
type P1 = fn(&i32) -> i32;
type P2 = fn();

fn f(pf: P1) {
    let pf2 = pf as P2;
    pf2(); // likely causes a serious problem
    let pf1 = pf2 as P1;
    let x = 7;
    let y = pf1(&x);
}
{{< /prism >}}
<p style="text-align: justify;">
This example highlights the risks of casting function pointers and underscores the importance of careful type management.
</p>

<p style="text-align: justify;">
Function pointers are useful for parameterizing algorithms, especially when the algorithm needs to be provided with different operations. For example, a sorting function might accept a comparison function as an argument.
</p>

<p style="text-align: justify;">
To sort a collection of <code>User</code> structs, you could define comparison functions and pass them to the sort function:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct User {
    name: &'static str,
    id: &'static str,
    dept: i32,
}

fn cmp_name(a: &User, b: &User) -> std::cmp::Ordering {
    a.name.cmp(b.name)
}

fn cmp_dept(a: &User, b: &User) -> std::cmp::Ordering {
    a.dept.cmp(&b.dept)
}

fn main() {
    let mut users = vec![
        User { name: "Ritchie D.M.", id: "dmr", dept: 11271 },
        User { name: "Sethi R.", id: "ravi", dept: 11272 },
        User { name: "Szymanski T.G.", id: "tgs", dept: 11273 },
        User { name: "Schryer N.L.", id: "nls", dept: 11274 },
        User { name: "Schryer N.L.", id: "nls", dept: 11275 },
        User { name: "Kernighan B.W.", id: "bwk", dept: 11276 },
    ];

    users.sort_by(cmp_name);
    println!("Sorted by name:");
    for user in &users {
        println!("{} {} {}", user.name, user.id, user.dept);
    }

    users.sort_by(cmp_dept);
    println!("\nSorted by department:");
    for user in &users {
        println!("{} {} {}", user.name, user.id, user.dept);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the vector of <code>User</code> structs is sorted first by name and then by department using function pointers.
</p>

<p style="text-align: justify;">
Pointers to functions provide a flexible way to parameterize algorithms and manage different operations in a type-safe manner. However, it's crucial to ensure type compatibility to avoid errors and undefined behavior.
</p>

## 14.25. Macros
<p style="text-align: justify;">
Macros play a crucial role in C but are less prevalent in more modern languages like Rust. The key guideline for using macros is to avoid them unless absolutely necessary. Most macros indicate a limitation in the programming language, the program, or the programmer. Since macros manipulate code before the compiler processes it, they can complicate tools like debuggers, cross-referencing, and profilers. When macros are essential, it's important to read the reference manual for your implementation of the Rust preprocessor and avoid overly clever solutions. Conventionally, macros are named with capital letters to signal their presence.
</p>

<p style="text-align: justify;">
In Rust, macros should primarily be used for conditional compilation and include guards. Here’s an example of a simple macro definition:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! NAME {
    () => {
        rest_of_line
    };
}
{{< /prism >}}
<p style="text-align: justify;">
When <code>NAME</code> is encountered as a token, it is replaced by <code>rest_of_line</code>.
</p>

<p style="text-align: justify;">
Macros can also take arguments:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! MAC {
    ($x:expr, $y:expr) => {
        println!("argument1: {}, argument2: {}", $x, $y);
    };
}
{{< /prism >}}
<p style="text-align: justify;">
Using <code>MAC!(foo, bar)</code> will expand to:
</p>

{{< prism lang="rust">}}
println!("argument1: foo, argument2: bar");
{{< /prism >}}
<p style="text-align: justify;">
Macro names cannot be overloaded, and the macro preprocessor cannot handle recursive calls:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! PRINT {
    ($a:expr, $b:expr) => {
        println!("{} {}", $a, $b);
    };
    ($a:expr, $b:expr, $c:expr) => {
        println!("{} {} {}", $a, $b, $c);
    };
}

macro_rules! FAC {
    ($n:expr) => {
        if $n > 1 {
            $n * FAC!($n - 1)
        } else {
            1
        }
    };
}
{{< /prism >}}
<p style="text-align: justify;">
Macros manipulate token streams and have a limited understanding of Rust syntax and types. Errors in macros are detected when expanded, not when defined, leading to obscure error messages. Here are some plausible macros:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! CASE {
    () => {
        break; case
    };
}
macro_rules! FOREVER {
    () => {
        loop {}
    };
}
{{< /prism >}}
<p style="text-align: justify;">
Avoid unnecessary macros like:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! PI {
    () => {
        3.141593
    };
}
macro_rules! BEGIN {
    () => {
        {
    };
}
macro_rules! END {
    () => {
        }
    };
}
{{< /prism >}}
<p style="text-align: justify;">
And beware of dangerous macros:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! SQUARE {
    ($a:expr) => {
        $a * $a
    };
}
macro_rules! INCR {
    ($xx:expr) => {
        $xx += 1
    };
}
{{< /prism >}}
<p style="text-align: justify;">
Expanding <code>SQUARE!(x + 2)</code> results in <code>(x + 2) * (x + 2)</code>, leading to incorrect calculations. Instead, always use parentheses:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! MIN {
    ($a:expr, $b:expr) => {
        if $a < $b {
            $a
        } else {
            $b
        }
    };
}
{{< /prism >}}
<p style="text-align: justify;">
Even with parentheses, macros can cause side effects:
</p>

{{< prism lang="rust" line-numbers="true">}}
let mut x = 1;
let mut y = 10;
let z = MIN!(x += 1, y += 1); // x becomes 3; y becomes 11
{{< /prism >}}
<p style="text-align: justify;">
When defining macros, it is often necessary to create new names. A string can be created by concatenating two strings using the <code>concat_idents!</code> macro:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! NAME2 {
    ($a:ident, $b:ident) => {
        concat_idents!($a, $b)
    };
}
{{< /prism >}}
<p style="text-align: justify;">
To convert a parameter to a string, use the <code>stringify!</code> macro:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! printx {
    ($x:ident) => {
        println!("{} = {}", stringify!($x), $x);
    };
}
let a = 7;
let str = "asdf";
fn f() {
    printx!(a); // prints "a = 7"
    printx!(str); // prints "str = asdf"
}
{{< /prism >}}
<p style="text-align: justify;">
Use <code>#[macro_export]</code> to ensure no macro called <code>X</code> is defined, protecting against unintended effects:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[macro_export]
macro_rules! EMPTY {
    () => {
        println!("empty");
    };
}
EMPTY!(); // prints "empty"
EMPTY; // error: macro replacement list missing
{{< /prism >}}
<p style="text-align: justify;">
An empty macro argument list is often error-prone or malicious. Macros can even be variadic:
</p>

{{< prism lang="rust" line-numbers="true">}}
macro_rules! err_print {
    ($($arg:tt)*) => {
        eprintln!("error: {}", format_args!($($arg)*));
    };
}
err_print!("The answer is {}", 42); // prints "error: The answer is 42"
{{< /prism >}}
<p style="text-align: justify;">
In summary, while macros can be powerful, their use in Rust should be minimal and well-considered, favoring more robust and clear alternatives whenever possible.
</p>

## 14.26. Conditional Compilation
<p style="text-align: justify;">
One essential use of macros is for conditional compilation. The <code>#ifdef IDENTIFIER</code> directive includes code only if <code>IDENTIFIER</code> is defined. If not, it causes the preprocessor to ignore subsequent input until an <code>#endif</code> directive is encountered. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(a: i32
#ifdef ARG_TWO
, b: i32
#endif
) -> i32 {
    // function body
}
{{< /prism >}}
<p style="text-align: justify;">
If a macro named <code>ARG_TWO</code> is not defined, this results in:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn f(a: i32) -> i32 {
    // function body
}
{{< /prism >}}
<p style="text-align: justify;">
This approach can confuse tools that rely on consistent programming practices.
</p>

<p style="text-align: justify;">
While most uses of <code>#ifdef</code> are more straightforward, they must be used judiciously. The <code>#ifdef</code> and its complement <code>#ifndef</code> can be harmless if applied with restraint. Macros for conditional compilation should be carefully named to avoid conflicts with regular identifiers. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct CallInfo {
    arg_one: Node,
    arg_two: Node,
    // ...
}
{{< /prism >}}
<p style="text-align: justify;">
This simple source code could cause issues if someone writes:
</p>

{{< prism lang="rust">}}
#define ARG_TWO x
{{< /prism >}}
<p style="text-align: justify;">
Unfortunately, many essential headers include numerous risky and unnecessary macros.
</p>

<p style="text-align: justify;">
A more robust approach to conditional compilation involves using attributes like <code>#[cfg]</code> and <code>#[cfg_attr]</code>, which integrate into the language more seamlessly and avoid the pitfalls of macros. This method ensures cleaner and safer code management.
</p>

## 14.27. Predefined Macros
<p style="text-align: justify;">
Predefined macros in Rust provide similar functionality to assist with debugging and conditional compilation:
</p>

- <p style="text-align: justify;"><code>file!()</code>: Expands to the current source file's name.</p>
- <p style="text-align: justify;"><code>line!()</code>: Expands to the current line number within the source file.</p>
- <p style="text-align: justify;"><code>column!()</code>: Expands to the current column number within the source file.</p>
- <p style="text-align: justify;"><code>module_pah!()</code>: Expands to a string representing the current module path.</p>
- <p style="text-align: justify;"><code>cfg!()</code>: Evaluates to <code>true</code> or <code>false</code> based on the compilation configuration options.</p>
<p style="text-align: justify;">
These macros are useful for providing contextual information for debugging and logging. For instance, the following line of code prints the current line number and file name:
</p>

{{< prism lang="rust">}}
println!("This is line {} in file {}", line!(), file!());
{{< /prism >}}
<p style="text-align: justify;">
Conditional compilation is handled using the <code>#[cfg]</code> attribute, enabling or disabling code based on specific configuration options:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[cfg(debug_assertions)]
fn main() {
    println!("Debug mode is enabled");
}

#[cfg(not(debug_assertions))]
fn main() {
    println!("Release mode is enabled");
}
{{< /prism >}}
<p style="text-align: justify;">
Additionally, custom configuration options can be defined using the <code>--cfg</code> flag in <code>rustc</code> or within <code>Cargo.toml</code>. By using the <code>cfg!</code> macro, you can conditionally execute code blocks based on the target operating system or other compile-time conditions:
</p>

{{< prism lang="rust" line-numbers="true">}}
if cfg!(target_os = "windows") {
    println!("Running on Windows");
} else {
    println!("Running on a non-Windows OS");
}
{{< /prism >}}
<p style="text-align: justify;">
These predefined macros and conditional compilation features enhance flexibility and robustness, making it easier to manage code based on the compilation environment.
</p>

## 14.28. Pragmas
<p style="text-align: justify;">
Platform-specific and non-standard features can be managed using attributes, which are similar to pragmas in other languages. Attributes provide a standardized way to apply configuration options, hints, or compiler directives to the code. For instance:
</p>

{{< prism lang="rust">}}
#![feature(custom_attribute)]
{{< /prism >}}
<p style="text-align: justify;">
Attributes can be applied at various levels, such as modules, functions, and items. While it is generally best to avoid using non-standard features if possible, attributes provide a powerful tool for enabling specific functionality. Here are a few examples of attributes:
</p>

- <p style="text-align: justify;"><code>#[allow(dead_code)]</code>: Suppresses warnings for unused code.</p>
- <p style="text-align: justify;"><code>#[inline(always)]</code>: Suggests that the compiler should always inline a function.</p>
- <p style="text-align: justify;"><code>#[deprecated]</code>: Marks a function or module as deprecated.</p>
## 14.29. Advices
<p style="text-align: justify;">
In Rust, organizing your code into well-defined, clearly named functions is crucial for enhancing readability and maintainability. Functions serve as a means to break down complex tasks into smaller, more manageable pieces, each focusing on a single, coherent task. This modular approach not only makes the code easier to understand but also simplifies its maintenance.
</p>

<p style="text-align: justify;">
When declaring functions, you specify the function’s name, parameters, and return type. This declaration acts as a blueprint, providing an overview of what the function does and what it requires. In Rust, functions should be designed to handle specific tasks and remain succinct. Keeping functions short helps maintain clarity, making them easier to understand and debug.
</p>

<p style="text-align: justify;">
Function definitions in Rust provide the actual implementation of the function. It is essential that these definitions are straightforward and efficient, aligning with the function's declared purpose. Avoid returning pointers or references to local variables. Instead, Rust’s ownership and borrowing rules ensure that returned values are either owned or have appropriately scoped references, preventing issues like dangling references.
</p>

<p style="text-align: justify;">
For functions that require compile-time evaluation, you should use <code>const fn</code>. This feature allows functions to be evaluated during compilation, which can enhance performance by reducing runtime computations. If a function is designed to never return normally, such as one that loops indefinitely or exits the process, you should use Rust’s <code>!</code> type to denote that the function does not return.
</p>

<p style="text-align: justify;">
When passing arguments to functions, it is advisable to pass small objects by value for efficiency, while larger objects should be passed by reference. Rust’s ownership system ensures that references are used safely, adhering to borrowing rules to avoid mutable aliasing and data races. For complex types, using <code>&T</code> or <code>&mut T</code> allows you to manage immutability and mutation effectively.
</p>

<p style="text-align: justify;">
Design functions to return results directly rather than modifying objects through parameters. This approach aligns with Rust’s ownership and borrowing features, allowing for safe and clear management of data through move semantics and references. Avoid using raw pointers where feasible and rely on Rust’s type system to ensure safe and efficient data handling.
</p>

<p style="text-align: justify;">
In Rust, macros can be powerful but should be used sparingly. Functions, traits, and closures are generally preferred for most tasks due to their clarity and maintainability. When macros are necessary, use unique and descriptive names to reduce potential confusion and maintain transparency in your code.
</p>

<p style="text-align: justify;">
For functions involving complex types or multiple arguments, use slices or vectors rather than variadic arguments. This approach improves type safety and clarity. Rust does not support traditional function overloading, so to handle similar functionalities with varying inputs, consider using descriptive function names or enums. Similarly, document preconditions and postconditions clearly to enhance the correctness and readability of your functions.
</p>

<p style="text-align: justify;">
By adhering to these practices, Rust programmers can create well-structured and efficient code. Leveraging Rust’s features for ownership, borrowing, and compile-time evaluation ensures that code remains safe, maintainable, and performant.
</p>

## 14.30. Further Learning with GenAI
<p style="text-align: justify;">
Assign yourself the following tasks: Input these prompts to ChatGPT and Gemini, and glean insights from their responses to enhance your understanding.
</p>

1. <p style="text-align: justify;">Describe why functions are crucial in Rust programming. Discuss how they help in breaking down complex tasks, improving code readability, and enhancing maintainability. Provide examples of how well-defined functions contribute to clear and structured code.</p>
2. <p style="text-align: justify;">Provide an overview of how to declare functions in Rust. Discuss the components of a function declaration, including the function name, parameters, and return type. Offer examples to illustrate how function declarations set up the blueprint for function implementations.</p>
3. <p style="text-align: justify;">Break down the elements of a function declaration in Rust. Explain the significance of each part, such as the function’s name, parameters, and return type. Discuss how these components contribute to the function’s role and behavior within a program.</p>
4. <p style="text-align: justify;">Explore how to define functions in Rust. Explain the syntax and structure of function definitions, including how to provide the function body and implement its logic. Use examples to demonstrate the process of turning function declarations into executable code.</p>
5. <p style="text-align: justify;">Discuss the concept of returning values from functions in Rust. Explain how functions can return different types of values and how to handle these return types. Provide examples of functions that return values and those that do not return any value.</p>
6. <p style="text-align: justify;">Examine the use of inline functions in Rust and their impact on performance. Explain the <code>#[inline]</code> attribute and how it suggests to the compiler that a function might benefit from inlining. Provide examples of scenarios where inlining can enhance performance.</p>
7. <p style="text-align: justify;">Describe the use of <code>const fn</code> in Rust for compile-time evaluation of functions. Discuss how <code>const fn</code> functions differ from regular functions and provide examples of how they can be used to perform computations during compilation.</p>
8. <p style="text-align: justify;">Explore how conditional evaluation is managed within Rust functions. Discuss how to use conditional statements and <code>cfg</code> attributes to include or exclude code based on specific conditions. Provide examples to illustrate conditional logic in function definitions.</p>
9. <p style="text-align: justify;">Explain how to use the <code>!</code> type for functions that are intended to never return. Discuss scenarios where such functions are useful, such as in infinite loops or functions that terminate the program. Provide examples to demonstrate the use of <code>!</code> as a return type.</p>
10. <p style="text-align: justify;">Discuss different methods for passing arguments to functions in Rust. Explain the use of value passing, reference passing, and how to handle arrays and lists. Provide examples that show how to define, initialize, and manipulate function arguments effectively.</p>
<p style="text-align: justify;">
Diving into the world of Rust functions is like embarking on a thrilling exploration of a new landscape. Each function-related prompt you tackle—whether it’s understanding function declarations, optimizing performance with inline functions, or mastering argument passing—is a key part of your journey toward programming mastery. Approach these challenges with an eagerness to learn and a readiness to discover new techniques, just as you would navigate through uncharted terrain. Every obstacle you encounter is an opportunity to deepen your understanding and sharpen your skills. By engaging with these prompts, you’ll build a solid foundation in Rust’s function mechanics, gaining both insight and proficiency with each new solution you develop. Embrace the learning journey, stay curious, and celebrate your milestones along the way. Your adventure in mastering Rust functions promises to be both enlightening and rewarding. Adapt these prompts to fit your learning style and pace, and enjoy the process of uncovering Rust’s powerful capabilities. Good luck, and make the most of your exploration!
</p>
