---
weight: 1000
title: "Chapter 4"
description: "A Tour of Rust: Containers and Algorithms"
icon: "article"
date: "2024-08-05T21:16:18+07:00"
lastmod: "2024-08-05T21:16:18+07:00"
draft: false
toc: true
---
<center>

# 📘 Chapter 4 : A Tour of Rust: Containers and Algorithms

</center>

{{% alert icon="💡" context="info" %}}
<strong>

"*Programs must be written for people to read, and only incidentally for machines to execute*." — Harold Abelson

</strong>
{{% /alert %}}

{{% alert icon="📘" context="success" %}}

<p style="text-align: justify;">
In this Chapter 4 of TRPL, we delve into Rust’s powerful and versatile handling of containers and algorithms, starting with an in-depth look at the standard library’s array of container types, including vectors, hash maps, and hash sets. We’ll explore how these containers can be effectively manipulated using iterators, which provide a concise and expressive way to traverse and transform data. The chapter highlights practical techniques for managing collections, performing essential operations such as sorting and filtering, and leveraging stream iterators to handle input and output efficiently. We’ll also cover advanced topics such as using predicates and crafting custom algorithms to enhance the flexibility and reusability of your code. By understanding and applying these concepts, you'll be equipped to write more efficient, expressive, and maintainable Rust code, capable of addressing a diverse array of data processing needs.
</p>

{{% /alert %}}


## 4.1. Libraries
<p style="text-align: justify;">
Alright, let’s get real: writing programs from scratch without libraries is a major headache. Libraries are like our trusty toolkits, making everything simpler and more efficient. In this chapter and the next, we’ll dive into some of the key features of Rust’s standard library, giving you a glimpse into the powerful tools it provides.
</p>

<p style="text-align: justify;">
We’ll explore essential types like <code>String</code>, <code>Vec</code>, <code>HashMap</code>, and <code>HashSet</code>. These are the building blocks that will help us craft robust and effective examples in the upcoming chapters. Think of <code>String</code> as your go-to for handling textual data, <code>Vec</code> for dynamic arrays that grow as needed, <code>HashMap</code> for quick lookups with key-value pairs, and <code>HashSet</code> for storing unique values. These types are foundational and will be used extensively, so understanding their capabilities and methods will be crucial.
</p>

<p style="text-align: justify;">
Don’t stress if you don’t get every detail right away—our goal is to give you a snapshot of what’s possible and introduce you to the essential features of Rust’s standard library. It’s designed with efficiency and reliability in mind, and it’s a significant part of every Rust setup. By leveraging these built-in tools, you avoid the need to reinvent the wheel, allowing you to focus on what really matters: writing high-quality, efficient code.
</p>

<p style="text-align: justify;">
Rust’s standard library is just the beginning. The broader Rust ecosystem is filled with additional crates that extend functionality even further, covering everything from graphical user interfaces (GUIs) and web frameworks to database management. While this book focuses on the standard library to keep things straightforward and portable, it’s worth knowing that these additional resources are available for when you’re ready to explore more specialized or advanced tasks. Embrace the standard library as your toolkit and feel free to venture beyond—it’s a rich landscape with plenty of powerful tools waiting for you!
</p>

### 4.1.1. Standard-Library Overview
<p style="text-align: justify;">
The Rust standard library is like a toolbox full of powerful utilities, designed to make programming smoother and more efficient. It offers a wide range of features to enhance your coding experience.
</p>

<p style="text-align: justify;">
The standard library includes fundamental capabilities like memory allocation and runtime type information, which are crucial for building robust applications. These tools provide the foundational support you need to manage resources effectively and write safe, performant code.
</p>

<p style="text-align: justify;">
Rust's FFI (Foreign Function Interface) allows you to seamlessly integrate C libraries and functions into your Rust code. This expands your project's functionality and leverages existing C resources, enabling you to reuse well-established libraries and reduce development time.
</p>

<p style="text-align: justify;">
Rust provides excellent support for handling strings and input/output operations. The standard library includes features for managing international character sets and localization, making it easier to develop global applications. Additionally, you can customize the I/O framework with your own streams and buffering strategies to meet specific performance requirements.
</p>

<p style="text-align: justify;">
One of the standout features of the Rust standard library is its versatile containers, such as <code>Vec</code>, <code>HashMap</code>, and <code>HashSet</code>, along with unique container types like arrays and tuples, adding more variety to data handling. <code>Vec</code> is a dynamic array that allows you to store elements contiguously in memory, providing efficient indexing and iteration, making it perfect for resizable collections. <code>HashMap</code> is a key-value store that offers fast lookups, insertions, and deletions, ideal for scenarios where you need to associate data with unique keys.<code>HashSet</code> is a collection of unique values, offering efficient membership tests and operations like union, intersection, and difference. Arrays provide fixed-size collections, while tuples allow you to group multiple values of different types into a single compound value. The library also includes useful algorithms like sort, filter, and map, and its flexibility allows you to create your own custom containers and algorithms as needed, ensuring you can handle any data processing task.
</p>

<p style="text-align: justify;">
The standard library includes a range of standard math functions, support for complex numbers, and random number generators to handle various computational tasks. These tools are essential for scientific computing, game development, and any other domain requiring numerical analysis.
</p>

<p style="text-align: justify;">
Rust offers robust regex support for efficient pattern matching and text processing. The regex crate provides powerful capabilities for searching, replacing, and extracting data from text, making it a valuable tool for data cleaning and text manipulation tasks.
</p>

<p style="text-align: justify;">
Rust facilitates safe concurrent programming with built-in support for threads, async/await syntax, and channels. These features help you write scalable and responsive applications by allowing you to perform multiple tasks simultaneously without compromising safety or performance.
</p>

<p style="text-align: justify;">
The standard library contains tools for metaprogramming, such as type traits and generics. These features enable more dynamic and flexible code, allowing you to write functions and data structures that can work with any type that meets certain criteria.
</p>

<p style="text-align: justify;">
Rust provides types like Box, Rc, and Arc for managing resources and memory safely and efficiently. These smart pointers help you handle ownership and borrowing rules, ensuring memory safety without the need for a garbage collector.
</p>

<p style="text-align: justify;">
The main goals of the Rust standard library are to offer wide utility, making it useful for programmers at all levels, to ensure efficiency with minimal overhead, and to provide simplicity in learning and using common tasks. In a nutshell, the Rust standard library equips you with a solid set of data structures and algorithms, designed to streamline your programming efforts and boost productivity.
</p>

### 4.1.2. Modules and Crates
<p style="text-align: justify;">
In Rust, modules and crates are essential for organizing and sharing code, helping you manage complexity and promote code reuse. Let's break down what these terms mean and how they can simplify your programming tasks.
</p>

<p style="text-align: justify;">
Modules in Rust serve as the building blocks of your code, allowing you to group related functions, structs, enums, constants, and even other modules together. This organization helps keep your code neat, maintainable, and logically structured.
</p>

<p style="text-align: justify;">
Here’s a simple example of how to define and use a module:
</p>

{{< prism lang="rust" line-numbers="true">}}
mod math_utils {
    pub fn add(a: i32, b: i32) -> i32 {
        a + b
    }

    pub fn subtract(a: i32, b: i32) -> i32 {
        a - b
    }
}

fn main() {
    let sum = math_utils::add(5, 3);
    let difference = math_utils::subtract(5, 3);
    println!("Sum: {}", sum);
    println!("Difference: {}", difference);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, the <code>math_utils</code> module groups together the <code>add</code> and <code>subtract</code> functions, demonstrating how modules can help keep your code organized and modular. By using the <code>pub</code> keyword, we make these functions accessible from outside the module. In the <code>main</code> function, we call <code>math_utils::add</code> and <code>math_utils::subtract</code>, showing how modules help manage and structure your code efficiently.
</p>

<p style="text-align: justify;">
Crates are the fundamental units of code distribution in Rust. Think of a crate as a package of Rust code that can be compiled into either a library or an executable. Each crate has its own namespace, allowing different crates to have items with the same names without any conflict. There are two main types of crates:
</p>

- <p style="text-align: justify;"><strong>Binary Crates:</strong> These are executable programs and must have a <code>main</code> function as their entry point.</p>
- <p style="text-align: justify;"><strong>Library Crates:</strong> These provide reusable functionality without a <code>main</code> function. They define functions, types, and other items that can be used by other crates.</p>
<p style="text-align: justify;">
Crates can depend on each other, and Rust’s package manager, Cargo, makes managing these dependencies straightforward. By adding dependencies to your <code>Cargo.toml</code> file, you can include and use other crates in your project.
</p>

<p style="text-align: justify;">
Cargo is essential for managing your project’s dependencies and building your code. To get started, open your project’s <code>Cargo.toml</code> file, located in the root directory of your Rust project. This file is where you define your project’s metadata and list its dependencies. To add a new crate, simply specify it under the <code>[dependencies]</code> section. For instance, to use the <code>rand</code> crate for generating random numbers, you would add the following line:
</p>

{{< prism lang="shell">}}
[dependencies]
rand = "0.8"
{{< /prism >}}
<p style="text-align: justify;">
This setup tells Cargo to fetch the <code>rand</code> crate and include it in your project, making it easy to use external libraries and streamline your development process. Once you’ve updated your <code>Cargo.toml</code>, you can start using the crate in your Rust code. For instance, to generate a random number, you would write:
</p>

{{< prism lang="rust" line-numbers="true">}}
use rand::Rng;

fn main() {
    let mut rng = rand::thread_rng();
    let n = rng.gen_range(0..10);
    println!("Random number: {}", n);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>use rand::Rng;</code> imports the necessary traits from the <code>rand</code> crate. The <code>rand::thread_rng()</code> function creates a random number generator, and <code>rng.gen_range(0..10)</code> generates a random number between 0 and 10.
</p>

<p style="text-align: justify;">
When you build your project with Cargo, it handles downloading the specified crate and its dependencies, compiles them, and makes them available in your code. This process is automated, so integrating external libraries is both straightforward and efficient. By relying on Cargo for crate management, you can keep your projects organized and take advantage of Rust's rich ecosystem of libraries to enhance your applications.
</p>

<p style="text-align: justify;">
In summary, Rust's modules and crates help you structure and share your code effectively. Modules keep your codebase tidy and manageable, while crates allow you to package and distribute your code, promoting code reuse and modularity.
</p>

## 4.2. Strings
<p style="text-align: justify;">
Strings are a big deal in any programming language, and Rust handles them like a champ. With its robust support for text right out of the box, Rust makes working with strings easy and efficient, even when dealing with international characters and localization.
</p>

<p style="text-align: justify;">
In Rust, you'll mostly work with two types of strings: <code>String</code> and <code>&str</code>. The <code>String</code> type is your go-to for a growable, heap-allocated string. It’s perfect when you need an owned, mutable string that you can modify. For example, you might start with a <code>String</code> like this:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let mut s = String::from("Hello, Rust!");
    s.push_str(" Welcome to the Rust language.");
    println!("{}", s);
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>String::from("Hello, Rust!")</code> creates a mutable <code>String</code>, and <code>s.push_str</code> appends additional text to it. This illustrates how <code>String</code> can be dynamically modified and expanded.
</p>

<p style="text-align: justify;">
On the other hand, <code>&str</code> is an immutable reference to a string slice. It's perfect for read-only operations and when you want to avoid the overhead of owning the string. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let slice: &str = &s[0..5];
    println!("Slice: {}", slice);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>slice</code> is a view into a part of the <code>String</code>, specifically the first five characters. It demonstrates how <code>&str</code> allows you to reference a portion of a string without taking ownership.
</p>

<p style="text-align: justify;">
Rust’s strings are UTF-8 encoded, so they handle international characters seamlessly. This is particularly useful for applications that need to support multiple languages or be localized. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let greeting = String::from("こんにちは、Rust!");
    println!("{}", greeting);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>greeting</code> contains Japanese characters, and Rust manages this text correctly thanks to its UTF-8 encoding. Additionally, just like in C++, Rust lets you extend its I/O framework. You can create your own streams and buffering strategies to customize how you handle input and output, giving you flexibility in managing textual data according to your specific needs.
</p>

<p style="text-align: justify;">
In summary, Rust provides a powerful and efficient way to work with strings, offering flexibility and robust support for both mutable and immutable text handling, international characters, and extensible I/O operations.
</p>

## 4.3 Stream I/O
<p style="text-align: justify;">
Rust's I/O operations are not only type-safe but also extendable to custom types, making it a versatile choice for a wide range of applications. The <code>std::io</code> module in Rust is a fundamental part of the standard library, providing essential functionalities for reading from and writing to various sources like the console, files, and network streams. This module forms the basis for basic I/O operations, allowing developers to interact with the user through the console, manage files for persistent storage, and handle data streams over network connections with ease.
</p>

<p style="text-align: justify;">
Rust's approach to I/O is built around its core traits and structures, particularly the <code>Read</code> and <code>Write</code> traits. These traits are foundational for I/O operations, and by implementing them, developers can define custom types that integrate seamlessly with Rust’s I/O system.
</p>

<p style="text-align: justify;">
Buffered I/O operations are supported through structures like <code>BufReader</code> and <code>BufWriter</code>, which improve performance by reducing the number of system calls. Rust's robust error handling mechanisms, using the <code>Result</code> type, ensure that I/O operations are both safe and reliable, with error handling enforced at compile time to minimize runtime errors.
</p>

<p style="text-align: justify;">
In practical terms, interacting with the console, files, and network streams in Rust is straightforward. We will cover how to handle stream input and output, including reading from and writing to various sources, and how to manage user-defined types in I/O operations. Rust's I/O system is designed to be powerful and flexible, allowing efficient handling of various tasks and custom needs.
</p>

<p style="text-align: justify;">
One of the standout features of Rust's I/O system is its extendability. By implementing the <code>Read</code> and <code>Write</code> traits for custom types, developers can integrate these types into Rust's I/O framework in a type-safe and consistent manner, tailoring the I/O capabilities to fit different application requirements.
</p>

### 4.3.1. Stream Input
<p style="text-align: justify;">
Rust's standard library has everything you need for handling input through the <code>std::io</code> module. This module makes it easy to read built-in types and even handle custom types. To get input from the user, you use the <code>std::io::stdin</code> function, which is your gateway to standard input.
</p>

<p style="text-align: justify;">
Reading an integer or floating-point number from standard input is pretty straightforward. First, you’ll use the <code>std::io</code> module, then create a mutable string to store the input. To read an integer, prompt the user and use the <code>read_line</code> method to capture the input into the string. After you have the input, use the <code>trim</code> method to remove any extra whitespace, and then use the <code>parse</code> method to convert the string into the type you need.
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io;

fn main() {
    let mut input = String::new();

    // Reading an integer
    println!("Enter an integer:");
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let i: i32 = input.trim().parse().expect("Please type a number!");

    // Reading a floating-point number
    input.clear();
    println!("Enter a floating-point number:");
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let d: f64 = input.trim().parse().expect("Please type a number!");

    println!("Integer: {}, Float: {}", i, d);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>read_line</code> reads a line of input into a <code>String</code>. We use <code>trim</code> to remove any extra whitespace, and <code>parse</code> to convert the string to the desired type. If the input cannot be parsed, <code>parse</code> will return an error.
</p>

<p style="text-align: justify;">
Now lets try to read a user's name. The process is similar to reading basic types. You prompt the user, capture the input into a mutable string, and then use the <code>trim</code> method to clean up the input.
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io;

fn main() {
    println!("Please enter your name:");
    let mut name = String::new();
    io::stdin().read_line(&mut name).expect("Failed to read line");
    let name = name.trim();
    println!("Hello, {}!", name);
}
{{< /prism >}}
<p style="text-align: justify;">
If you type "RantAI", the output will be: <code>Hello, RantAI!</code>. By default, <code>read_line</code> reads until it hits a newline character. Reading an entire line of input, including spaces, is just as easy. Again, prompt the user, capture the input into a mutable string, and then use the <code>trim</code> method to clean up the input.
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io;

fn main() {
    println!("Please enter your name:");
    let mut full_name = String::new();
    io::stdin().read_line(&mut full_name).expect("Failed to read line");
    let full_name = full_name.trim();
    println!("Hello, {}!", full_name);
}
{{< /prism >}}
<p style="text-align: justify;">
With this program, if you type "RantAI Team", the output will be: <code>Hello, RantAI Team!</code>. The <code>trim</code> method removes the newline character at the end, so <code>stdin</code> is ready for the next input.
</p>

<p style="text-align: justify;">
By understanding these basic concepts, you can handle various types of input in Rust efficiently. This forms the foundation for more complex I/O operations and paves the way for creating interactive applications.
</p>

### 4.3.2. Output
<p style="text-align: justify;">
Rust's standard library makes handling output straightforward through its <code>std::io</code> module. The <code>println!</code> macro is the primary tool for printing text to the console, supporting both built-in and user-defined types. Let's explore how Rust facilitates various output operations.
</p>

<p style="text-align: justify;">
In Rust, you can print literals directly using the <code>println!</code> macro. This macro is versatile and can handle different types of data seamlessly. For instance, printing a simple number is as easy as:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    println!("{}", 10);
}
{{< /prism >}}
<p style="text-align: justify;">
This code prints the number 10 to the console. Often, you will store values in variables and then print them. Rust makes this operation straightforward. Here’s how you can print a variable:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let i = 10;
    println!("{}", i);
}
{{< /prism >}}
<p style="text-align: justify;">
This code stores the number 10 in the variable <code>i</code> and then prints it. Rust allows you to combine text and variables in the same <code>println!</code> call. This feature is particularly useful for creating informative and formatted output. For example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let i = 10;
    println!("The value of i is {}", i);
}
{{< /prism >}}
<p style="text-align: justify;">
This code outputs: <code>The value of i is 10</code>. You can also combine multiple outputs in a single <code>println!</code> call, making your output statements more concise and readable. For instance:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let i = 10;
    println!("The value of i is {}\n", i);
}
{{< /prism >}}
<p style="text-align: justify;">
This code combines multiple outputs in one <code>println!</code> call, which can include various types of data and formatting. Rust allows you to print characters and their ASCII values using the <code>println!</code> macro. You can mix characters and their ASCII values within the same output statement. Here's an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let b = 'b' as u8;
    let c = 'c';
    println!("{}{}{}", 'a', b, c);
}
{{< /prism >}}
<p style="text-align: justify;">
This code outputs: <code>a98c</code> where <code>a</code> is printed as a character, <code>b</code> is printed as its ASCII value (98), and <code>c</code> is printed as a character.
</p>

<p style="text-align: justify;">
In summary, Rust’s <code>std::io</code> module, particularly the <code>println!</code> macro, provides a powerful and flexible way to handle output. Whether you are printing simple literals, variables, or combining different types of data, Rust makes the process straightforward and efficient. This basic understanding of Rust's output capabilities sets the foundation for more complex and dynamic output operations in your applications.
</p>

### 4.3.3. I/O of User-Defined Types
<p style="text-align: justify;">
Rust's standard library makes handling input and output for custom types straightforward and robust. Just like in C++, Rust lets you define how to handle input and output for your own types. This is achieved by implementing specific traits provided by the Rust standard library. Here's a quick guide on how to do it in Rust.
</p>

<p style="text-align: justify;">
First, let's create a simple struct <code>Entry</code> for our contact book. This struct will have a <code>name</code> field of type <code>String</code> and a <code>number</code> field of type <code>i32</code>.
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Entry {
    name: String,
    number: i32,
}
{{< /prism >}}
<p style="text-align: justify;">
To customize how an <code>Entry</code> is printed, we implement the <code>std::fmt::Display</code> trait. This lets us define the output format:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::fmt;

impl fmt::Display for Entry {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{{\"{}\", {}}}", self.name, self.number)
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Now, you can print an <code>Entry</code> using the <code>println!</code> macro:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let entry = Entry {
        name: String::from("Richard Feynman"),
        number: 123456,
    };
    println!("{}", entry);
}
{{< /prism >}}
<p style="text-align: justify;">
This prints: <code>{"Richard Feynman", 123456}</code>. Reading input for custom types involves parsing and error checking. We can do this by implementing the <code>std::str::FromStr</code> trait:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::str::FromStr;

impl FromStr for Entry {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let parts: Vec<&str> = s.trim_matches(|c| c == '{' || c == '}').split(", ").collect();
        if parts.len() != 2 {
            return Err(String::from("Invalid format"));
        }
        let name = parts[0].trim_matches('"').to_string();
        let number: i32 = parts[1].parse().map_err(|_| "Invalid number format")?;
        Ok(Entry { name, number })
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Now you can read an <code>Entry</code> from a string:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let input = "{\"John Doe\", 123456}";
    match input.parse::<Entry>() {
        Ok(entry) => println!("Parsed entry: {}", entry),
        Err(e) => println!("Error: {}", e),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
This will parse the input string and print the <code>Entry</code> object if successful. Combining these implementations lets you read and write <code>Entry</code> objects using standard input and output:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, Write};

fn main() {
    let mut input = String::new();
    println!("Please enter an entry (format: {\"name\", number}):");
    io::stdin().read_line(&mut input).expect("Failed to read line");

    match input.trim().parse::<Entry>() {
        Ok(entry) => println!("You entered: {}", entry),
        Err(e) => println!("Error: {}", e),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
With this program, if you enter <code>{"Richard Feynman", 654321}</code>, the output will be: <code>You entered: {"Richard Feynman", 654321}</code>.
</p>

<p style="text-align: justify;">
Rust's standard library provides powerful tools to handle input and output for user-defined types. By implementing the <code>std::fmt::Display</code> trait for output and the <code>std::str::FromStr</code> trait for input, you can seamlessly integrate custom types into your I/O operations. This capability allows you to create more complex and user-friendly applications.
</p>

## 4.4. Containers
<p style="text-align: justify;">
When programming, you often need to group values together and work with them efficiently. For example, reading characters into a string and then printing them out is a simple case of this. In Rust, we use containers to manage collections of data. Containers are crucial for building any program, as they help you organize and manipulate data effectively.
</p>

<p style="text-align: justify;">
Rust’s standard library provides a variety of container types designed with safety in mind, thanks to its borrow checker. This system helps prevent data races and memory issues by ensuring references are always valid and data is modified in a controlled manner.
</p>

<p style="text-align: justify;">
Here are some key Rust containers:
</p>

- <p style="text-align: justify;"><code>Vec<T></code>: A growable array that stores elements contiguously in memory, offering fast random access and efficient iteration.</p>
- <p style="text-align: justify;"><code>LinkedList<T></code>: A doubly-linked list that allows efficient insertion and removal from any position but has slower random access compared to <code>Vec</code>.</p>
- <p style="text-align: justify;"><code>VecDeque<T></code>: A double-ended queue that is efficient for operations at both ends of the sequence.</p>
- <p style="text-align: justify;"><code>HashSet<T></code>: A set where each value is unique, providing fast average-time complexity for lookups, insertions, and deletions.</p>
- <p style="text-align: justify;"><code>HashMap<K, V></code>: A key-value store with fast lookups, ideal for mapping keys to values.</p>
- <p style="text-align: justify;"><code>BTreeSet<T></code>: A set that maintains elements in sorted order and supports efficient in-order traversal.</p>
- <p style="text-align: justify;"><code>BTreeMap<K, V></code>: A key-value store with ordered keys, offering sorted traversal of entries.</p>
<p style="text-align: justify;">
Rust uses traits to define operations on these containers, allowing for more flexible and reusable code compared to C++'s inheritance model. This design ensures that Rust containers are safe and efficient while providing a consistent API for common operations like iteration, insertion, and removal.
</p>

<p style="text-align: justify;">
Choosing the right container depends on your needs: <code>Vec</code> is a good default choice for dynamic arrays, while <code>HashSet</code> and <code>HashMap</code> are best for fast lookups. Other containers like <code>LinkedList</code> and <code>VecDeque</code> have their own advantages for specific use cases. In the next section, we will delve deeper into some of the most commonly used containers: <code>Vec</code>, <code>HashMap</code>, and <code>HashSet</code>. We’ll explore their features, use cases, and how they can be effectively utilized in your Rust projects.
</p>

### 4.4.1. Vector
<p style="text-align: justify;">
A <code>Vec</code> in Rust is similar to a <code>vector</code> in C++. It is a dynamic array that stores elements contiguously in memory, which makes accessing and manipulating elements efficient. This guide will show you how to use a <code>Vec</code> to manage phone book entries effectively. You can initialize a vector with a set of values. Here’s how you can define a vector of phone book entries:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let phone_book = vec![
        Entry { name: String::from("David Hume"), number: 123456 },
        Entry { name: String::from("Karl Popper"), number: 234567 },
        Entry { name: String::from("Bertrand Arthur William Russell"), number: 345678 },
    ];

    // Printing the initialized vector
    println!("{:?}", phone_book);
}
{{< /prism >}}
<p style="text-align: justify;">
Elements in a <code>Vec</code> can be accessed using indexing, which starts at 0. Here’s how you can access and display the first entry and the total number of entries:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let phone_book = vec![
        Entry { name: String::from("David Hume"), number: 123456 },
        Entry { name: String::from("Karl Popper"), number: 234567 },
        Entry { name: String::from("Bertrand Arthur William Russell"), number: 345678 },
    ];

    println!("First entry: {:?}", phone_book[0]);
    println!("Total entries: {}", phone_book.len());
}
{{< /prism >}}
<p style="text-align: justify;">
You can iterate over a vector using a <code>for</code> loop. Here’s how to print all entries in the phone book:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let phone_book = vec![
        Entry { name: String::from("David Hume"), number: 123456 },
        Entry { name: String::from("Karl Popper"), number: 234567 },
        Entry { name: String::from("Bertrand Arthur William Russell"), number: 345678 },
    ];

    for entry in &phone_book {
        println!("{:?}", entry);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
To add a new element to the end of the vector, use the <code>push</code> method:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let mut phone_book = Vec::new();

    phone_book.push(Entry { name: String::from("David Hume"), number: 123456 });

    println!("{:?}", phone_book);
}
{{< /prism >}}
<p style="text-align: justify;">
If you need to create a copy of a vector and its elements, you can use the <code>clone</code> method. Here’s an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Debug, Clone)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let phone_book = vec![
        Entry { name: String::from("David Hume"), number: 123456 },
        Entry { name: String::from("Karl Popper"), number: 234567 },
    ];

    let book2 = phone_book.clone();

    println!("Original: {:?}", phone_book);
    println!("Copy: {:?}", book2);
}
{{< /prism >}}
<p style="text-align: justify;">
Using <code>Vec</code> in Rust provides a powerful and flexible way to manage collections of data. The examples above show how to initialize, access, iterate, add to, and copy vectors, giving you a solid foundation for utilizing this essential container in your Rust programs. Rust’s focus on safety and efficiency makes working with <code>Vec</code> a reliable choice for various programming needs.
</p>

### 4.4.2 HashMap
<p style="text-align: justify;">
When dealing with a list of (name, number) pairs, looking up a specific name can become inefficient as the list grows. Rust’s standard library provides a robust solution to this problem: the <code>HashMap</code>.
</p>

<p style="text-align: justify;">
A <code>HashMap</code> is a collection of key-value pairs optimized for quick lookups. It functions similarly to a dictionary or an associative array in other programming languages. This data structure allows you to efficiently retrieve values based on their corresponding keys, making it ideal for tasks like managing a phone book.
</p>

<p style="text-align: justify;">
You can initialize a <code>HashMap</code> with a set of key-value pairs. Here’s how you can set up a phone book using a <code>HashMap</code>:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashMap;

#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let mut phone_book = HashMap::new();

    phone_book.insert("David Hume".to_string(), Entry { name: "David Hume".to_string(), number: 123456 });
    phone_book.insert("Karl Popper".to_string(), Entry { name: "Karl Popper".to_string(), number: 234567 });
    phone_book.insert("Bertrand Arthur William Russell".to_string(), Entry { name: "Bertrand Arthur William Russell".to_string(), number: 345678 });

    println!("{:?}", phone_book);
}
{{< /prism >}}
<p style="text-align: justify;">
To access values in a <code>HashMap</code>, you index the map by the key. If the key exists, it returns the corresponding value:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashMap;

#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn get_number(phone_book: &HashMap<String, Entry>, name: &str) -> i32 {
    phone_book.get(name).map_or(0, |entry| entry.number)
}

fn main() {
    let mut phone_book = HashMap::new();

    phone_book.insert("David Hume".to_string(), Entry { name: "David Hume".to_string(), number: 123456 });
    phone_book.insert("Karl Popper".to_string(), Entry { name: "Karl Popper".to_string(), number: 234567 });

    let number = get_number(&phone_book, "David Hume");
    println!("David Hume's number is {}", number);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, if the key isn’t found, the function returns a default value (like 0). To ensure that only valid entries are inserted into the <code>HashMap</code>, you can use the <code>entry</code> API. This allows you to check if a key exists before inserting a new value:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashMap;

#[derive(Debug)]
struct Entry {
    name: String,
    number: i32,
}

fn main() {
    let mut phone_book = HashMap::new();

    phone_book.entry("David Hume".to_string()).or_insert(Entry { name: "David Hume".to_string(), number: 123456 });
    phone_book.entry("Karl Popper".to_string()).or_insert(Entry { name: "Karl Popper".to_string(), number: 234567 });

    match phone_book.get("David Hume") {
        Some(entry) => println!("Found: {} - {}", entry.name, entry.number),
        None => println!("Entry not found"),
    }
}
{{< /prism >}}
<p style="text-align: justify;">
This code ensures that if an entry for "David Hume" already exists, it won’t be overwritten.<code>HashMap</code> is an essential container in Rust for managing collections of key-value pairs. It provides efficient lookups and is flexible enough to handle various data types and structures. By understanding and utilizing <code>HashMap</code>, you can significantly improve the performance and reliability of your programs when managing collections of data.
</p>

### 4.4.3 HashSet
<p style="text-align: justify;">
When it comes to managing collections of unique items, a <code>HashSet</code> in Rust offers a highly efficient solution. Unlike a <code>HashMap</code>, which stores key-value pairs, a <code>HashSet</code> focuses solely on keys, making it perfect for scenarios where you need to track unique values without associated data. This efficiency comes from its use of hash tables, which enable quick lookups, insertions, and deletions.
</p>

<p style="text-align: justify;">
To illustrate how a <code>HashSet</code> can be used, let's consider managing a collection of names. Here's how you can initialize and work with a <code>HashSet</code> in Rust:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashSet;

fn main() {
    let mut names = HashSet::new();

    names.insert("Risman Adnan".to_string());
    names.insert("Raffy Aulia".to_string());
    names.insert("Razka Athallah".to_string());

    println!("{:?}", names);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, we create a new <code>HashSet</code> and add several names to it. The <code>HashSet</code> ensures that each name is unique within the collection. One of the core functionalities of a <code>HashSet</code> is the ability to check if it contains a specific value. This is done using the <code>contains</code> method:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashSet;

fn main() {
    let mut names = HashSet::new();

    names.insert("Risman Adnan".to_string());
    names.insert("Raffy Aulia".to_string());

    if names.contains("Risman Adnan") {
        println!("Risman Adnan is in the set.");
    }

    if !names.contains("Raffy Aulia") {
        println!("Raffy Aulia is not in the set.");
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>contains</code> is used to check for the presence of "David Hume" and "Bertrand Russell" in the <code>HashSet</code>. The method returns <code>true</code> if the item is present and <code>false</code> otherwise. If you need to remove an item from a <code>HashSet</code>, you can use the <code>remove</code> method. This method allows you to efficiently delete a value from the set:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashSet;

fn main() {
    let mut names = HashSet::new();

    names.insert("Risman Adnan".to_string());
    names.insert("Raffy Aulia".to_string());

    names.remove("Risman Adnan");

    if !names.contains("Risman Adnan") {
        println!("Risman Adnan has been removed.");
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In this snippet, "Risman Adnan" is removed from the <code>HashSet</code>. After removal, checking for "Risman Adnan" confirms that it is no longer present.
</p>

<p style="text-align: justify;">
<code>HashSet</code> is a powerful container in Rust for managing unique collections of items with high efficiency. By leveraging hashed lookups, <code>HashSet</code> provides fast performance for adding, checking, and removing items, making it an excellent choice for many use cases where uniqueness and quick access are crucial.
</p>

## 4.5. Algorithms
<p style="text-align: justify;">
A data structure, like a vector or a hash map, isn't all that useful by itself. To really make use of it, we need basic operations like adding and removing elements. But we usually do more than just store objects in a container. We sort them, print them, pick out subsets, remove certain items, search for specific objects, and so on. That’s why Rust’s standard library not only provides common container types but also offers a suite of handy algorithms to work with them.
</p>

<p style="text-align: justify;">
For instance, if you have a vector and want to sort it, Rust makes this simple with the <code>sort</code> method. You can also collect each unique element into a new vector by combining sorting with other operations. Rust’s powerful iterators come into play here, allowing you to chain methods like <code>iter</code>, <code>sorted</code>, and <code>dedup</code> to efficiently transform and process your data.
</p>

<p style="text-align: justify;">
Rust’s standard library includes a variety of algorithms that can be applied to its containers. Methods such as <code>sort</code> for sorting elements, <code>filter</code> for selecting elements based on conditions, and <code>map</code> for applying transformations are all part of this functionality. These algorithms are designed to work seamlessly with Rust's iterators, which provide a lazy and efficient way to process sequences of items.
</p>

<p style="text-align: justify;">
With these built-in algorithms, you can easily perform common tasks such as searching for specific objects with <code>find</code>, counting elements with <code>count</code>, and combining elements with <code>fold</code>. Rust’s approach to algorithms emphasizes both efficiency and safety, ensuring that operations are performed in a way that prevents common pitfalls like data races and memory issues.
</p>

<p style="text-align: justify;">
In summary, Rust’s standard library equips you with powerful algorithms to complement its container types. These algorithms enhance the functionality of data structures by enabling efficient sorting, filtering, and transformation, helping you get the most out of your containers and streamline your data processing tasks. For example, here’s how you can sort a vector and collect each unique element into a new vector:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashSet;

fn sort_and_collect_unique(vec: &mut Vec<Entry>) -> Vec<Entry> {
    vec.sort_by(|a, b| a.name.cmp(&b.name));
    let mut set = HashSet::new();
    vec.iter()
       .filter(|e| set.insert(&e.name))
       .cloned()
       .collect()
}

#[derive(Clone, Eq, PartialEq, Hash)]
struct Entry {
    name: String,
}

fn main() {
    let mut vec = vec![
        Entry { name: "Charlie".to_string() },
        Entry { name: "Alice".to_string() },
        Entry { name: "Bob".to_string() },
        Entry { name: "Alice".to_string() },
    ];

    let unique_sorted_vec = sort_and_collect_unique(&mut vec);

    for entry in unique_sorted_vec {
        println!("{}", entry.name);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
The Rust standard library provides these algorithms as methods on iterators. You can think of an iterator as a way to produce a sequence of elements. For instance, sorting a vector means defining the range of elements we want to sort, typically all elements from the start to the end of the vector:
</p>

<p style="text-align: justify;">
In this example, <code>sort_by()</code> sorts the elements in the vector by their names. For writing the sorted and unique elements to a new container, we simply need to specify the iterator that provides the elements. If we want to avoid overwriting elements, our target container must have enough space to hold all unique elements from the source.
</p>

<p style="text-align: justify;">
If we want to gather the unique elements into a new vector, we could write:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashSet;

// Define the Entry struct
#[derive(Debug, Clone, Eq, PartialEq, Hash)]
struct Entry {
    name: String,
}

// Function to collect unique elements into a new vector
fn collect_unique(vec: &mut Vec<Entry>) -> Vec<Entry> {
    // Sort the vector by the name field
    vec.sort_by(|a, b| a.name.cmp(&b.name));

    // Use a HashSet to track unique names and filter duplicates
    let mut set = HashSet::new();
    vec.iter()
       .filter(|e| set.insert(&e.name))
       .cloned()
       .collect()  // Collect directly into a new Vec
}

fn main() {
    // Initialize a vector with phone book entries
    let mut vec = vec![
        Entry { name: "Charlie".to_string() },
        Entry { name: "Alice".to_string() },
        Entry { name: "Bob".to_string() },
        Entry { name: "Alice".to_string() },
    ];

    // Call the function to collect unique entries into a new vector
    let unique_sorted_vec = collect_unique(&mut vec);

    // Print the unique and sorted entries
    for entry in unique_sorted_vec {
        println!("{}", entry.name);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Using <code>collect()</code> helps us append elements to the end of a vector, automatically resizing the vector to fit new elements. This avoids the need for error-prone, manual memory management like in C.
</p>

<p style="text-align: justify;">
If you find the iterator-based style of code, such as <code>vec.iter()</code>, to be a bit too much, you can define methods directly on your data structures and call them more intuitively:
</p>

{{< prism lang="rust" line-numbers="true">}}
impl Entry {
    fn sort_and_collect_unique(vec: &mut Vec<Entry>) -> Vec<Entry> {
        vec.sort_by(|a, b| a.name.cmp(&b.name));
        let mut seen = HashSet::new();
        vec.iter()
           .filter(|e| seen.insert(&e.name))
           .cloned()
           .collect()
    }
}

fn main() {
    let mut vec = vec![
        Entry { name: "Charlie".to_string() },
        Entry { name: "Alice".to_string() },
        Entry { name: "Bob".to_string() },
        Entry { name: "Alice".to_string() },
    ];

    let unique_sorted_vec = Entry::sort_and_collect_unique(&mut vec);

    for entry in unique_sorted_vec {
        println!("{}", entry.name);
    }
}
{{< /prism >}}
### 4.5.1. Use of Iterators
<p style="text-align: justify;">
When you start working with collections in Rust, you often use iterators to point to specific elements; methods like <code>iter()</code> and <code>iter_mut()</code> are super handy for this. Plus, many functions return iterators too. For example, the <code>find</code> method searches for a value and gives you an iterator pointing to that element:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn contains_char(s: &str, c: char) -> bool {
    s.chars().find(|&x| x == c).is_some()
}

fn main() {
    let my_string = "Hello, world!";
    let char_to_find = 'w';

    if contains_char(my_string, char_to_find) {
        println!("The character '{}' is in the string.", char_to_find);
    } else {
        println!("The character '{}' is not in the string.", char_to_find);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Like many search functions, <code>find</code> returns <code>None</code> if it doesn't find what you're looking for. Here’s a shorter way to write <code>contains_char</code>:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn contains_char(s: &str, c: char) -> bool {
    s.chars().any(|x| x == c)
}

fn main() {
    let my_string = "Hello, world!";
    let char_to_find = 'w';

    if contains_char(my_string, char_to_find) {
        println!("The character '{}' is in the string.", char_to_find);
    } else {
        println!("The character '{}' is not in the string.", char_to_find);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Now, let's tackle a more interesting problem: finding all occurrences of a character in a string. We can return the positions of these characters as a vector of indices. If we want to be able to modify the string, we need to use a mutable reference:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn find_all_positions(s: &mut String, c: char) -> Vec<usize> {
    let mut positions = Vec::new();
    for (i, ch) in s.char_indices() {
        if ch == c {
            positions.push(i);
        }
    }
    positions
}

fn main() {
    let mut text = String::from("Rust programming language");
    let char_to_find = 'g';
    let positions = find_all_positions(&mut text, char_to_find);

    println!("Positions of character '{}': {:?}", char_to_find, positions);
}
{{< /prism >}}
<p style="text-align: justify;">
We loop through the string, checking each character to see if it matches the one we’re looking for.
</p>

<p style="text-align: justify;">
Iterators and standard functions work the same way on any standard collection where it makes sense to use them. So, we can generalize <code>find_all_positions</code> to work with any collection:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn find_all<T, F>(collection: &T, target: F) -> Vec<usize>
where
    T: AsRef<[F]>,
    F: PartialEq,
{
    let mut positions = Vec::new();
    let items = collection.as_ref();
    for (i, item) in items.iter().enumerate() {
        if item == &target {
            positions.push(i);
        }
    }
    positions
}

fn main() {
    // Test with vector of integers
    let numbers = vec![4, 7, 9, 4, 2];
    let positions = find_all(&numbers, 4);
    for pos in positions {
        println!("Found 4 at position: {}", pos);
    }

    // Test with vector of strings
    let strings = vec!["a".to_string(), "b".to_string(), "a".to_string()];
    let positions = find_all(&strings, "a".to_string());
    for pos in positions {
        println!("Found 'a' at position: {}", pos);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
This version can handle any collection where items can be compared to the target value.
</p>

<p style="text-align: justify;">
The beauty of iterators is they let you separate algorithms from the collections they operate on. An algorithm works with its data through iterators and doesn’t need to know about the underlying collection. On the flip side, a collection doesn’t need to know about the algorithms that work with its elements; it just needs to provide iterators when asked (like with <code>iter()</code> and <code>iter_mut()</code>). This separation makes for very flexible and reusable code.
</p>

### 4.5.2. Iterator Types
<p style="text-align: justify;">
So, what exactly are iterators in Rust? Well, an iterator is just an object of some type, and there are a bunch of different types because each iterator needs to carry the info it needs to do its job for a specific collection. These iterator types can be as varied as the collections themselves. For example, a vector’s iterator could simply be a reference to its elements:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let numbers = vec![1, 2, 3];
    let mut iter = numbers.iter(); // `iter` is an iterator over the elements

    assert_eq!(iter.next(), Some(&1));
    assert_eq!(iter.next(), Some(&2));
    assert_eq!(iter.next(), Some(&3));
    assert_eq!(iter.next(), None);
}
{{< /prism >}}
<p style="text-align: justify;">
Or, you could have a custom iterator for a vector that wraps around when it reaches the end:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct WrapAroundIterator<'a, T> {
    vec: &'a Vec<T>,
    index: usize,
}

impl<'a, T> Iterator for WrapAroundIterator<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<Self::Item> {
        if self.vec.is_empty() {
            None
        } else {
            let item = &self.vec[self.index];
            self.index = (self.index + 1) % self.vec.len();
            Some(item)
        }
    }
}

fn main() {
    let vec = vec![4, 5, 6];
    let mut wrap_iter = WrapAroundIterator { vec: &vec, index: 0 };

    assert_eq!(wrap_iter.next(), Some(&4));
    assert_eq!(wrap_iter.next(), Some(&5));
    assert_eq!(wrap_iter.next(), Some(&6));
    assert_eq!(wrap_iter.next(), Some(&4));
}
{{< /prism >}}
<p style="text-align: justify;">
When it comes to a list, things get a bit more complex because a list element doesn't inherently know where the next element is. So, a list iterator might use internal references to keep track of the elements:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::LinkedList;

fn main() {
    let mut list = LinkedList::new();
    list.push_back(10);
    list.push_back(20);

    let mut iter = list.iter();

    assert_eq!(iter.next(), Some(&10));
    assert_eq!(iter.next(), Some(&20));
    assert_eq!(iter.next(), None);
}
{{< /prism >}}
<p style="text-align: justify;">
No matter the type, all iterators have some common behavior. For instance, using <code>next()</code> on any iterator gets you the next element in the sequence. And with Rust’s iterators, you don’t usually need to know the exact type because each collection knows its iterator types and provides them under standard names like <code>iter()</code> and <code>iter_mut()</code>. For example, <code>list.iter()</code> is the iterator type for a list.
</p>

<p style="text-align: justify;">
Here’s how you can use these iterators without worrying too much about how they work under the hood:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::LinkedList;

fn main() {
    let numbers = vec![7, 8, 9];
    for num in numbers.iter() {
        println!("{}", num);
    }

    let mut list = LinkedList::new();
    list.push_back(30);
    list.push_back(40);

    for num in list.iter() {
        println!("{}", num);
    }
}
{{< /prism >}}
### 4.5.3. Stream Iterators
<p style="text-align: justify;">
Iterators are super handy for dealing with sequences of elements in collections. But collections aren't the only places where you find sequences. For instance, an input stream produces a sequence of values, and you write a sequence of values to an output stream. So, we can also apply the idea of iterators to input and output.
</p>

<p style="text-align: justify;">
To create an iterator for output streams, we need to specify the stream we’re using and the type of objects we’re writing to it. Check this out:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, Write};

fn main() {
    let mut stdout = io::stdout();
    let mut writer = stdout.lock();

    writer.write_all(b"Hello, ").unwrap();
    writer.write_all(b"world!\n").unwrap();
}
{{< /prism >}}
<p style="text-align: justify;">
Similarly, an iterator for input streams lets us treat an input stream like a read-only collection. Again, we specify the stream and the type of values we expect:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    while let Some(Ok(line)) = lines.next() {
        println!("{}", line);
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Usually, we don't use input and output iterators directly. Instead, we use them as arguments to functions. For example, here’s a simple program that reads from a file, sorts the lines, removes duplicates, and writes the result to another file:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::BTreeSet;
use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};

fn main() -> io::Result<()> {
    let mut from = String::new();
    let mut to = String::new();
    io::stdin().read_line(&mut from)?;
    io::stdin().read_line(&mut to)?;

    let from = from.trim();
    let to = to.trim();

    let input_file = File::open(from)?;
    let output_file = File::create(to)?;

    let reader = BufReader::new(input_file);
    let mut writer = io::BufWriter::new(output_file);

    let mut lines: Vec<String> = reader.lines().filter_map(Result::ok).collect();
    lines.sort();
    lines.dedup();

    for line in lines {
        writeln!(writer, "{}", line)?;
    }

    Ok(())
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>File</code> is an input stream attached to a file, and <code>BufWriter</code> is an output stream attached to a file. The second argument to <code>writeln!</code> is used to separate output values.
</p>

<p style="text-align: justify;">
Actually, this program can be shorter. We read the lines into a vector, sort them, and write them out, removing duplicates. A more elegant solution is to avoid storing duplicates in the first place by using a <code>BTreeSet</code>, which automatically removes duplicates and keeps elements in order. We can replace the vector with a <code>BTreeSet</code>:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::BTreeSet;
use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};

fn main() -> io::Result<()> {
    let mut from = String::new();
    let mut to = String::new();
    io::stdin().read_line(&mut from)?;
    io::stdin().read_line(&mut to)?;

    let from = from.trim();
    let to = to.trim();

    let input_file = File::open(from)?;
    let output_file = File::create(to)?;

    let reader = BufReader::new(input_file);
    let mut writer = io::BufWriter::new(output_file);

    let lines: BTreeSet<String> = reader.lines().filter_map(Result::ok).collect();

    for line in lines {
        writeln!(writer, "{}", line)?;
    }

    Ok(())
}
{{< /prism >}}
<p style="text-align: justify;">
We used <code>reader</code> and <code>writer</code> only once, so we can simplify the program even more:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::BTreeSet;
use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};

fn main() -> io::Result<()> {
    let mut from = String::new();
    let mut to = String::new();
    io::stdin().read_line(&mut from)?;
    io::stdin().read_line(&mut to)?;

    let from = from.trim();
    let to = to.trim();

    let lines: BTreeSet<String> = BufReader::new(File::open(from)?)
        .lines()
        .filter_map(Result::ok)
        .collect();

    let mut writer = io::BufWriter::new(File::create(to)?);
    for line in lines {
        writeln!(writer, "{}", line)?;
    }

    Ok(())
}
{{< /prism >}}
<p style="text-align: justify;">
Whether or not this last simplification improves readability is a matter of personal preference and experience.
</p>

### 4.5.3. Predicates
<p style="text-align: justify;">
In the examples above, the algorithms have their actions for each element "built in." However, we often want to pass in the specific action we want to perform as a parameter. For instance, the <code>find</code> method lets us look for a specific value, but what if we want to look for something that meets a particular condition, or predicate? For example, suppose we want to find the first value in a <code>HashMap</code> that's greater than 50. A <code>HashMap</code> lets us access its elements as a sequence of (key, value) pairs, so we can search a <code>HashMap<String, i32></code> for a pair where the <code>i32</code> is greater than 50:
</p>

{{< prism lang="rust" line-numbers="true">}}
use std::collections::HashMap;

fn find_first_above_threshold(map: &HashMap<String, i32>, threshold: i32) -> Option<(&String, &i32)> {
    map.iter().find(|&(_, &value)| value > threshold)
}

fn main() {
    let mut scores = HashMap::new();
    scores.insert("player1".to_string(), 45);
    scores.insert("player2".to_string(), 75);
    scores.insert("player3".to_string(), 30);

    if let Some((player, score)) = find_first_above_threshold(&scores, 50) {
        println!("Found a score of {} for {}", score, player);
    } else {
        println!("No score found above 50");
    }
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>find_first_above_threshold</code> is a function that uses a closure to hold the threshold value (50) we’re comparing against. Alternatively, we could use an iterator method directly with a closure:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let mut scores = HashMap::new();
    scores.insert("itemA".to_string(), 20);
    scores.insert("itemB".to_string(), 55);
    scores.insert("itemC".to_string(), 60);

    let count_above_50 = scores.iter().filter(|&(_, &value)| value > 50).count();
    println!("Number of scores above 50: {}", count_above_50);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, we use the <code>filter</code> method along with a closure to count the elements that meet the predicate (values greater than 50). Using predicates like this makes our code more flexible and reusable, allowing us to define custom behavior without changing the algorithms themselves.
</p>

## 4.6. Advices
<p style="text-align: justify;">
When using containers and algorithms in Rust, it's essential to first understand the concepts of ownership and borrowing. These core principles are foundational to Rust's memory safety guarantees, ensuring that data is handled without the risk of undefined behavior. Beginners should familiarize themselves with how ownership is transferred between functions, the role of borrowing for accessing data without taking ownership, and the distinction between immutable and mutable references. This understanding helps in managing container elements efficiently and avoiding common pitfalls.
</p>

<p style="text-align: justify;">
Selecting the appropriate container for your data is crucial. Rust offers a range of options, such as <code>Vec<T></code> for ordered collections with fast random access, <code>HashMap<K, V></code> for associating keys with values, and <code>HashSet<T></code> for maintaining a set of unique elements. The choice of container can significantly impact both the performance and clarity of your code, so it's important to consider the specific requirements of your application, such as the need for ordering, uniqueness, or efficient lookups.
</p>

<p style="text-align: justify;">
In Rust, iterators provide a powerful and expressive way to work with collections. Rather than relying on manual loops, which can be error-prone, you can use iterator methods like <code>map</code>, <code>filter</code>, and <code>collect</code> to process data in a concise and readable manner. This approach not only simplifies the code but also helps avoid common issues such as incorrect indexing or out-of-bounds errors.
</p>

<p style="text-align: justify;">
Handling potential failure cases is an essential aspect of working with containers, and Rust's <code>Option</code> and <code>Result</code> types are designed to make this explicit. These types force the programmer to consider cases where an operation might fail, such as a missing key in a <code>HashMap</code>. By explicitly handling these cases, you can avoid common bugs and ensure that your code behaves correctly in all situations.
</p>

<p style="text-align: justify;">
Rust strongly encourages the use of immutable data by default, promoting safety and preventing data races in concurrent programs. When mutable state is necessary, Rust provides concurrency primitives like <code>Arc<Mutex<T>></code> and <code>RwLock<T></code>, which allow for safe shared access to data across threads. This design helps maintain Rust's guarantees of safety and performance, even in concurrent environments.
</p>

<p style="text-align: justify;">
To optimize your programs, consider using slices and references instead of copying data. Slices (<code>&[T]</code>) allow you to work with contiguous segments of data without taking ownership, which can be more efficient in terms of memory and performance. This practice is particularly useful when passing data to functions or iterating over elements, as it avoids unnecessary cloning and allocations.
</p>

<p style="text-align: justify;">
The Rust standard library provides a wealth of utilities and algorithms, and you should make use of these whenever possible. For specialized needs, the Rust ecosystem includes many crates, such as <code>itertools</code> for extended iterator capabilities and <code>rayon</code> for parallel computations. Leveraging these tools can save time, improve efficiency, and ensure your code adheres to best practices.
</p>

<p style="text-align: justify;">
It's also important to avoid premature optimization. While Rust offers powerful tools for low-level optimization, your primary focus should be on writing clear and correct code. Only after profiling and identifying performance bottlenecks should you consider optimizing your code. Tools like <code>cargo bench</code> and <code>cargo flamegraph</code> can help in this process by providing insights into where your code spends the most time.
</p>

<p style="text-align: justify;">
Thorough testing and documentation are vital for maintaining high-quality code. Rust's robust testing framework makes it easier to verify that your code behaves as expected, while good documentation helps others (and your future self) understand the rationale behind your design decisions. This is especially important when dealing with complex algorithms or advanced language features.
</p>

<p style="text-align: justify;">
Lastly, always strive to write idiomatic Rust code. This means adhering to community conventions and best practices, as outlined in resources like the Rust API guidelines. Idiomatic code is not only more likely to be correct but also easier to read and maintain, which is particularly valuable when writing a book like 'The Rust Programming Language'. By following these guidelines, you can help your readers learn Rust in a way that is both effective and aligned with the language's philosophy.
</p>

## 4.7. Further Learning with GenAI
<p style="text-align: justify;">
Assign yourself the following tasks: Input these prompts to ChatGPT and Gemini, and glean insights from their responses to enhance your understanding.
</p>

1. <p style="text-align: justify;">Explore advanced topics in Rust's module and crate system, including re-exporting with <code>pub use</code>, path scoping, and crate visibility. Provide detailed explanations and examples that demonstrate how to structure large Rust projects using workspaces, manage internal and external dependencies, and maintain version compatibility. Discuss how these features in Rust compare to similar practices in C/C++, such as the use of CMake, header files, and namespaces. Highlight the benefits and challenges of each approach.</p>
2. <p style="text-align: justify;">Delve into the mechanics of how different Rust crates interact with each other, focusing on the use of external crates. Provide sample code illustrating how to use crates.io to discover, integrate, and manage third-party libraries. Discuss Cargo's role in dependency management, including handling version conflicts and ensuring compatibility. Compare this with package management systems in C++, such as Conan and vcpkg, addressing how each system approaches dependency resolution, version control, and ecosystem stability.</p>
3. <p style="text-align: justify;">Examine the intricacies of string slicing and manipulation in Rust, with a focus on safe indexing and the challenges of UTF-8 encoded strings. Provide comprehensive examples of common operations, such as concatenation, substring extraction, and the use of format macros. Compare these with similar operations in C++ using <code>std::string</code> and <code>std::string_view</code>. Discuss the advantages and pitfalls of string handling in both languages, particularly in terms of safety, performance, and ease of use.</p>
4. <p style="text-align: justify;">Discuss how Rust manages interoperability between different string types, such as <code>String</code>, <code>&str</code>, <code>OsString</code>, and others. Provide examples demonstrating the conversion between these types, especially when dealing with different character encodings and operating system boundaries. Compare Rust's approach to string interoperability with C++'s handling of <code>std::wstring</code>, <code>std::string</code>, and related challenges in character encoding. Highlight best practices for cross-platform string handling.</p>
5. <p style="text-align: justify;">Beyond the common <code>Vec</code>, <code>HashMap</code>, and <code>HashSet</code>, explore the specialized container types offered by Rust, such as <code>BTreeMap</code>, <code>BTreeSet</code>, and <code>LinkedList</code>. Provide examples of scenarios where these containers are particularly useful, discussing their strengths and limitations. Compare their performance and use cases with similar data structures in C++, addressing aspects like search efficiency, memory usage, and suitability for concurrent access.</p>
6. <p style="text-align: justify;">Investigate how Rust's containers are designed to work in concurrent contexts, including the use of thread-safe variants like <code>Arc</code> and <code>Mutex</code>. Provide examples of safely sharing and mutating data across threads using Rust's synchronization primitives. Compare Rust's concurrency model with that of C++, focusing on how each language addresses thread safety and prevents data races. Discuss the trade-offs and benefits of Rust's strict compile-time checks versus C++'s more flexible runtime checks.</p>
7. <p style="text-align: justify;">Analyze how Rust's ownership and borrowing rules influence memory management for containers, particularly concerning dynamic allocation and deallocation. Provide examples of memory-efficient data structures and discuss Rust's approach to preventing issues like dangling pointers and memory leaks. Compare Rust's memory management techniques with C++'s use of smart pointers and manual memory management, highlighting the strengths and weaknesses of each approach.</p>
8. <p style="text-align: justify;">Explain how to create custom iterators in Rust and utilize iterator adaptors for efficient and lazy data processing. Provide examples showcasing advanced iterator methods such as <code>filter</code>, <code>map</code>, <code>collect</code>, and <code>fold</code>. Compare Rust's iterator system with C++'s iterator and algorithm concepts, discussing the benefits of Rust's approach in terms of safety, composability, and ease of use. Highlight the impact of Rust's ownership model on iterator safety and efficiency.</p>
9. <p style="text-align: justify;">Discuss how Rust handles errors in container algorithms, such as index out-of-bounds errors in vectors. Provide examples of using <code>Result</code> and <code>Option</code> types for robust error handling in container operations. Compare Rust's compile-time error handling with C++'s exception handling mechanisms and error codes, highlighting Rust's advantages in terms of ensuring code reliability and predictability.</p>
10. <p style="text-align: justify;">Explore performance optimization techniques for containers in Rust, such as minimizing memory allocations, optimizing hashing strategies, and leveraging the borrow checker for efficient data access. Provide examples of using crates like <code>rayon</code> for parallel processing of container data. Compare these optimization strategies with those available in C++, discussing the strengths and weaknesses of each approach in achieving high-performance, safe, and maintainable code.</p>
<p style="text-align: justify;">
As you explore these advanced topics, immerse yourself in the intricacies of Rust's design and how it distinguishes itself from other languages like C++. Approach each prompt with a curious and analytical mindset, testing and validating your understanding through hands-on experimentation in your development environment. Remember, mastery comes with practice and perseverance. Embrace each challenge as an opportunity to deepen your expertise, and celebrate the milestones along your learning journey. Your commitment to understanding and utilizing Rust's powerful features will not only elevate your coding skills but also position you as a thought leader in modern software development. Keep pushing the boundaries of your knowledge, and enjoy the process of discovery and growth.
</p>
