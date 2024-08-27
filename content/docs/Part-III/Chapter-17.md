---
weight: 2700
title: "Chapter 17"
description: "Structs"
icon: "article"
date: "2024-08-05T21:24:55+07:00"
lastmod: "2024-08-05T21:24:55+07:00"
draft: false
toc: true
---

{{% alert icon="💡" context="info" %}}<strong>"<em>Abstraction organizes the mind about what programs do and lets you focus on higher-level ideas. When you're working with high-level data structures, you're managing the complexity very effectively.</em>" — Bjarne Stroustrup</strong>{{% /alert %}}

{{% alert icon="📘" context="success" %}}
<p style="text-align: justify;">
In this chapter, we explored the essential role of structs in Rust, highlighting their three flavors: named-field, tuple-like, and unit-like. Named-field structs, with their clear, named components, enhance readability and maintenance, making them ideal for complex data structures. Tuple-like structs offer a lightweight, positional approach, useful when the order of data is more meaningful than names. Unit-like structs, despite lacking components, play crucial roles in type-centric operations. Through examples like a library's book catalog and a video game character model, we demonstrated how named-field structs bundle related data under a single type, providing clear conventions, encapsulation, and methods to maintain data integrity. This foundation illustrates Rust's robust toolkit for organizing and managing data, setting the stage for exploring advanced features like generics and trait implementations in subsequent chapters.
</p>
{{% /alert %}}


## 17.1. Named-Field Structs
<p style="text-align: justify;">
In Rust, structures—or simply "structs"—are fundamental building blocks, akin to C and C++ structs, Python classes, or objects in JavaScript. They are tools for bundling multiple values of potentially different types into a cohesive unit, enabling you to manage related data together. Within a struct, you can access and manipulate individual components and define methods to operate on its data.
</p>

<p style="text-align: justify;">
Structs come in three distinct flavors, each serving unique purposes and enhancing the flexibility of the language. Named-field structs are perhaps the most familiar, providing clear, named components that boost readability and make maintenance a breeze. These named fields are particularly useful when you want to ensure that each part of your data structure is easily identifiable and accessible by name. On the other hand, tuple-like structs offer a more lightweight and positional means of structuring data, akin to tuples but within the struct framework, where elements are accessed based on their order. This can be particularly handy when the data’s order is more meaningful than the names. Lastly, unit-like structs might appear trivial at first glance since they lack any components, but they are far from useless. These empty structs serve vital roles in type-centric operations, often acting as markers or signals within a program. Together, these three varieties of structs provide Rust developers with a robust toolkit for effectively organizing and managing their data.
</p>

<p style="text-align: justify;">
Rust's named-field structs allow you to bundle together multiple pieces of data under a single type. Think of them as a way to create a custom data structure where each piece of data is accessible by a name you define. This feature is somewhat similar to creating objects in languages like Python or JavaScript but with the added benefit of strict type enforcement and memory safety.
</p>

<p style="text-align: justify;">
For example, let's consider a struct to represent a book in a library system:
</p>

{{< prism lang="rust" line-numbers="true">}}
/// A book in the library catalog.
pub struct Book {
    title: String,
    author: String,
    pages: usize,
    available: bool,
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>Book</code> has four fields with specific types. The Rust convention uses CamelCase for struct names and snake_case for field names, making everything clear and predictable.
</p>

<p style="text-align: justify;">
Creating an instance of a <code>Book</code> might look like this:
</p>

{{< prism lang="rust" line-numbers="true">}}
let book = Book {
    title: "The Rust Programming Language".to_string(),
    author: "Steve Klabnik and Carol Nichols".to_string(),
    pages: 552,
    available: true,
};
{{< /prism >}}
<p style="text-align: justify;">
Rust provides a concise way to initialize structs when variable names match field names, as shown in the following function:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn create_book(title: String, author: String, pages: usize, available: bool) -> Book {
    Book { title, author, pages, available }
}
{{< /prism >}}
<p style="text-align: justify;">
Accessing and modifying the fields of a struct is straightforward using the dot operator:
</p>

{{< prism lang="rust">}}
assert_eq!(book.title, "The Rust Programming Language");
book.available = false; // updating the availability status
{{< /prism >}}
<p style="text-align: justify;">
Structs in Rust are private by default, meaning their fields are only accessible within the module where they're declared unless marked with <code>pub</code>. This encapsulation is vital for maintaining invariants and controlling how data is accessed and modified.
</p>

<p style="text-align: justify;">
For instance, let's say you're modeling a video game character:
</p>

{{< prism lang="rust" line-numbers="true">}}
pub struct Character {
    name: String,
    health: u32,
    position: (f32, f32),
    level: u32,
}

/// Simulates the character taking damage.
pub fn take_damage(character: &mut Character, damage: u32) {
    if damage < character.health {
        character.health -= damage;
    } else {
        character.health = 0; // Character is defeated
    }
}
{{< /prism >}}
<p style="text-align: justify;">
In the above setup, <code>take_damage</code> function safely modifies the <code>health</code> of a <code>Character</code>, ensuring that the health never drops below zero, demonstrating how methods can be used to safely interact with the data.
</p>

<p style="text-align: justify;">
Rust structs can also be used to create types with behavior through methods, further encapsulating functionality alongside data for maintainability and reusability.
</p>

<p style="text-align: justify;">
Overall, named-field structs in Rust offer a powerful way to structure your data with clarity and precision, ensuring that each component is well-defined and correctly managed throughout the life of your program.
</p>

## 17.2. Tuple-Like Structs
<p style="text-align: justify;">
Diving into the realm of Rust's struct types, we encounter the tuple-like structs, which as the name suggests, mirror tuples. These structs provide a streamlined way to bundle together a set of values without assigning a specific name to each element.
</p>

<p style="text-align: justify;">
For instance, let's consider a struct designed to represent the dimensions of a game level:
</p>

{{< prism lang="rust">}}
struct Dimensions(i32, i32);
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>Dimensions</code> encapsulates two <code>i32</code> values representing width and height. Constructing an instance of this struct is akin to instantiating a tuple, but you must prefix it with the struct name:
</p>

{{< prism lang="rust">}}
let level_dimensions = Dimensions(1920, 1080);
{{< /prism >}}
<p style="text-align: justify;">
Access to the values within a tuple-like struct uses indexing similar to tuples:
</p>

{{< prism lang="rust">}}
assert_eq!(level_dimensions.0 * level_dimensions.1, 2073600);
{{< /prism >}}
<p style="text-align: justify;">
To enhance accessibility, individual elements can be made public:
</p>

{{< prism lang="rust">}}
pub struct Dimensions(pub i32, pub i32);
{{< /prism >}}
<p style="text-align: justify;">
This adjustment allows the elements of <code>Dimensions</code> to be directly accessed from other modules, making the usage intuitive and straightforward, akin to accessing tuple fields.
</p>

<p style="text-align: justify;">
Tuple-like structs also serve beautifully as 'newtypes' when you need precise type distinctions without the overhead of traditional structs. For instance, if you’re managing screen resolutions in a graphics application, defining a newtype could ensure type safety:
</p>

{{< prism lang="rust">}}
struct Resolution(i32, i32);
{{< /prism >}}
<p style="text-align: justify;">
This approach is more descriptive and type-safe than using bare tuples or multiple parameters, especially when passing data across function calls. It prevents the mixing of different measures that happen to use the same data types, like mixing up width with height or other dimensions.
</p>

<p style="text-align: justify;">
Let's consider an example of implementing screen resolution management using tuple-like structs for organized data handling. First, we define a tuple-like struct called <code>Resolution</code> which will hold the width and height of a device's screen resolution.
</p>

{{< prism lang="rust">}}
// Defining a tuple-like struct to handle screen resolutions
pub struct Resolution(pub i32, pub i32);
{{< /prism >}}
<p style="text-align: justify;">
Next, we'll create a function that simulates adjusting the resolution settings for different devices based on predefined criteria, such as optimizing for performance or quality.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn set_resolution(device: &str) -> Resolution {
    match device {
        "Smartphone" => Resolution(720, 1280), // Lower resolution for performance
        "Tablet" => Resolution(1200, 1920),     // Moderate resolution
        "4K Monitor" => Resolution(3840, 2160), // High resolution for quality
        _ => Resolution(1080, 1920),            // Default resolution
    }
}
{{< /prism >}}
<p style="text-align: justify;">
We'll also create a function to display the current resolution, demonstrating how to access the elements of a tuple-like struct.
</p>

{{< prism lang="rust" line-numbers="true">}}
fn display_resolution(device_name: &str, resolution: Resolution) {
    println!(
        "The resolution for {} is {}x{} pixels.",
        device_name, resolution.0, resolution.1
    );
}
{{< /prism >}}
<p style="text-align: justify;">
Finally, we'll use these functions in the <code>main</code> function to set and display resolutions for various devices:
</p>

{{< prism lang="rust" line-numbers="true">}}
fn main() {
    let smartphone_resolution = set_resolution("Smartphone");
    let tablet_resolution = set_resolution("Tablet");
    let monitor_resolution = set_resolution("4K Monitor");

    display_resolution("Smartphone", smartphone_resolution);
    display_resolution("Tablet", tablet_resolution);
    display_resolution("4K Monitor", monitor_resolution);
}
{{< /prism >}}
<p style="text-align: justify;">
This code succinctly demonstrates how tuple-like structs can be used to encapsulate and manage data efficiently. It provides clear, type-safe handling of resolution data while maintaining readability and functionality. By using tuple-like structs, we enhance the code's maintainability and ensure that the dimensions are always correctly associated with each other, preventing common errors like misplacing width for height.
</p>

<p style="text-align: justify;">
Tuple-like structs strike a balance between simplicity and functionality, offering a compact, type-safe way to work with related data values. They are particularly useful when the emphasis is on the type itself rather than the names of its components, providing both legibility and a neat structure for managing data effectively in your Rust applications.
</p>

## 17.3. Unit-Like Structs
<p style="text-align: justify;">
In the world of Rust, where every type and structure has a purpose, even the simplest forms—those without any fields—are no exception. Known as unit-like structs, these entities are the minimalists among data structures, defined entirely without elements:
</p>

{{< prism lang="rust">}}
struct Placeholder;
{{< /prism >}}
<p style="text-align: justify;">
This may initially come across as an odd or abstract concept. However, consider a unit-like struct as a declaration of a specific type that holds significance, not through stored data, but through its mere existence. It functions similarly to the <code>()</code> unit type in Rust, which is employed to indicate the absence of a meaningful value. A unit-like struct, therefore, is a powerful tool in expressing a concept, condition, or state within your program, without the overhead of data storage.
</p>

<p style="text-align: justify;">
Unit-like structs are incredibly useful for signaling states or specific conditions in code. They are defined succinctly, without any properties, making them ideal for situations where the presence of a type is more critical than the data it might carry. This characteristic allows programmers to leverage type safety and trait implementations in a lightweight, yet semantically rich manner.
</p>

<p style="text-align: justify;">
Let's say you're developing a game and you have various types of game events. Some events, like a tick or a simple state change, don't need to carry additional data—they simply need to occur. Here’s how you might define and use a unit-like struct to handle such events:
</p>

{{< prism lang="rust" line-numbers="true">}}
// Define a unit-like struct to represent a simple event
struct GameTick;

// Function to process game events
fn process_event(event: &dyn GameEvent) {
    println!("Processing event...");
    event.execute();
}

// Game event trait
trait GameEvent {
    fn execute(&self);
}

// Implement the GameEvent trait for GameTick
impl GameEvent for GameTick {
    fn execute(&self) {
        println!("Game tick occurred.");
    }
}

fn main() {
    let tick = GameTick;
    process_event(&tick);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>GameTick</code> is a unit-like struct that implements a <code>GameEvent</code> trait. It carries no data, but it has behavior defined through its trait implementation. When <code>process_event</code> is called with a <code>GameTick</code>, it processes the event without needing any additional data from the <code>GameTick</code> struct.
</p>

<p style="text-align: justify;">
Unit-like structs are particularly useful in scenarios where you need to define a type that conforms to certain interfaces (traits) or behaviors without carrying state. They are also handy when using marker traits, which are traits that don't define any methods but signify certain properties about a type. Here's an example using a marker trait:
</p>

{{< prism lang="rust" line-numbers="true">}}
// A marker trait to indicate that a type is serializable
trait Serializable {}

// A unit-like struct that represents a serializable token
struct SerializableToken;

// Implement Serializable for SerializableToken
impl Serializable for SerializableToken {}

fn main() {
    let token = SerializableToken;
    // The presence of 'token' indicates that something is serializable
    println!("This type is serializable!");
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>SerializableToken</code> serves as a proof or marker that some functionality is supported (serialization in this case), which can be checked or enforced at compile time.
</p>

<p style="text-align: justify;">
In summary, while unit-like structs don't hold any data, they play a critical role in scenarios where the existence of a type itself carries meaning or when compliance to certain behaviors is required without the need for associated state.
</p>

## 17.4. Generic Structs
<p style="text-align: justify;">
Expanding on our exploration of Rust's structs, another powerful feature that significantly enhances the language's capability for abstraction and code reuse is generic structs. Generics allow you to define structures that can operate on a variety of data types while maintaining type safety.
</p>

<p style="text-align: justify;">
Generic structs are defined by specifying type parameters in angle brackets after the struct name. These parameters can then be used as types for the fields within the struct. This approach is particularly useful when you want your struct to be flexible regarding the type of data it can hold. Here’s a straightforward example to illustrate:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Point<T> {
    x: T,
    y: T,
}

fn main() {
    let integer_point = Point { x: 5, y: 10 };
    let float_point = Point { x: 1.0, y: 4.5 };

    println!("Integer Point: ({}, {})", integer_point.x, integer_point.y);
    println!("Float Point: ({}, {})", float_point.x, float_point.y);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>Point</code> is a generic struct capable of holding any type, as indicated by the generic type parameter <code>T</code>. We create instances of <code>Point</code> with integers and floats, demonstrating the struct's flexibility.
</p>

<p style="text-align: justify;">
While generics increase flexibility, you might occasionally need to restrict what types can be used with a generic struct. Rust allows you to specify constraints on generic parameters using trait bounds, ensuring that the types used provide certain functionalities:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Rectangle<T> where T: Copy + PartialOrd {
    width: T,
    height: T,
}

impl<T> Rectangle<T> where T: Copy + PartialOrd {
    fn is_square(&self) -> bool {
        self.width == self.height
    }
}

fn main() {
    let rectangle = Rectangle { width: 15, height: 15 };

    println!("Is the rectangle a square? {}", rectangle.is_square());
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>Rectangle</code> requires its type parameter <code>T</code> to implement the <code>Copy</code> and <code>PartialOrd</code> traits. This requirement ensures that values of type <code>T</code> can be copied and compared, which are operations needed in the <code>is_square</code> method to check if the rectangle is a square.
</p>

<p style="text-align: justify;">
When working with generic structs, you often need to implement methods that work with their generic types. You can define methods on a generic struct by specifying the same type parameters in the <code>impl</code> block:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Wrapper<T> {
    value: T,
}

impl<T> Wrapper<T> {
    fn new(value: T) -> Self {
        Wrapper { value }
    }

    fn value(&self) -> &T {
        &self.value
    }
}

fn main() {
    let wrapped_integer = Wrapper::new(10);
    let wrapped_string = Wrapper::new("Hello, Rust!");

    println!("Wrapped Integer: {}", wrapped_integer.value());
    println!("Wrapped String: {}", wrapped_string.value());
}
{{< /prism >}}
<p style="text-align: justify;">
This code illustrates how a <code>Wrapper</code> struct can encapsulate different types, providing a simple but powerful example of how generics can serve to abstract and simplify operations on data.
</p>

<p style="text-align: justify;">
The use of generic structs is crucial for building reusable components in Rust. By abstracting over types, you can write code that is applicable to a broad range of scenarios, reducing duplication and increasing the reliability of your software systems.
</p>

<p style="text-align: justify;">
Through generics, Rust achieves a balance between powerful type safety features and the flexibility necessary for effective abstraction and reuse in software development.
</p>

## 17.5. Struct Ownership and Borrowing
<p style="text-align: justify;">
In Rust, the concepts of ownership and borrowing are foundational to the language's approach to memory safety and concurrency. These concepts are crucial for developers to grasp, especially when working with structs, which are custom data types that group together related data. Ownership determines who owns a piece of data, while borrowing allows temporary access to data without taking ownership. This distinction is critical for preventing issues like data races and dangling pointers, which are common problems in other programming languages. When a struct is created, its fields may contain values that have their own ownership rules. Understanding how these rules interact within the context of structs is vital for ensuring that data is accessed safely and efficiently.
</p>

<p style="text-align: justify;">
For instance, when a struct owns a piece of data, it is responsible for cleaning up that data when it goes out of scope. This automatic management is a key feature of Rust’s ownership system, eliminating the need for manual memory management. However, if multiple parts of a program need to access data stored in a struct, borrowing comes into play. Borrowing allows other parts of the program to read or modify data without transferring ownership. This can be done either mutably or immutably, with strict rules to ensure that mutable and immutable borrows do not coexist, thus preventing data inconsistencies.
</p>

<p style="text-align: justify;">
In practice, these principles mean that when designing structs and functions in Rust, developers must carefully consider how data flows through the program. They need to think about whether data should be moved, borrowed, or cloned, depending on the specific use case. For example, if a function needs to modify a struct's data, it will require a mutable reference to that data, ensuring exclusive access during the modification. Conversely, if multiple parts of a program only need to read the data, multiple immutable references can coexist, enabling safe concurrent access. By adhering to Rust's ownership and borrowing rules, developers can write code that is not only safe and efficient but also clear in terms of how data is managed and shared throughout the program.
</p>

### 17.5.1. Ownership with Structs
<p style="text-align: justify;">
Ownership in Rust is a powerful concept that prevents data races at compile time. When a struct is created, it owns all its fields unless those fields explicitly use types like <code>Box</code>, <code>Rc</code>, or <code>Arc</code>, which internally manage ownership in more complex ways. This ownership is exclusive—meaning that when a struct instance is passed to a function, it is moved unless the type implements the <code>Copy</code> trait. Here’s an example:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Book {
    title: String,
    pages: u32,
}

fn display_book(book: Book) {
    println!("{}: {} pages", book.title, book.pages);
}

fn main() {
    let my_book = Book {
        title: "Rust Programming".to_string(),
        pages: 312,
    };

    display_book(my_book);

    // The next line would cause a compile-time error: value borrowed here after move
    // println!("I still can access: {}", my_book.title);
}
{{< /prism >}}
<p style="text-align: justify;">
In this example, <code>my_book</code> is moved into the <code>display_book</code> function. After the move, <code>my_book</code> is no longer usable in the <code>main</code> function because its ownership has been transferred to <code>display_book</code>.
</p>

### 17.5.2. Borrowing with Structs
<p style="text-align: justify;">
Borrowing allows you to access data without taking ownership of it. This is crucial for allowing multiple parts of your code to read the data, or for a single part to modify it, without relinquishing total control. Rust has two types of borrows: immutable and mutable. Immutable borrows allow multiple readers, but no modification, while mutable borrows allow modification, but only one at a time.
</p>

<p style="text-align: justify;">
Here’s how you might borrow fields from a struct:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Computer {
    processor: String,
    memory_gb: u32,
}

fn upgrade_memory(comp: &mut Computer, additional_memory: u32) {
    comp.memory_gb += additional_memory;
}

fn main() {
    let mut my_computer = Computer {
        processor: "x86_64".to_string(),
        memory_gb: 16,
    };

    upgrade_memory(&mut my_computer, 16);

    println!("Updated memory: {}GB", my_computer.memory_gb);
}
{{< /prism >}}
<p style="text-align: justify;">
In this case, <code>my_computer</code> is mutably borrowed by the <code>upgrade_memory</code> function. The function modifies the <code>memory_gb</code> field, but does not take ownership of the <code>Computer</code> instance, allowing further use of <code>my_computer</code> after the function call.
</p>

<p style="text-align: justify;">
Rust’s borrowing rules also extend to the field level. You can borrow individual fields of a struct independently, unless a mutable borrow of one field implicitly borrows the entire struct mutably, which would prevent immutable borrows of other fields simultaneously.
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Player {
    name: String,
    score: u32,
}

fn main() {
    let mut player = Player {
        name: "Alice".to_string(),
        score: 88,
    };

    let player_name = &player.name;  // Immutable borrow of one field
    // player.score += 10;  // Error: cannot borrow `player` as mutable because it is also borrowed as immutable

    println!("Player: {}", player_name);
}
{{< /prism >}}
<p style="text-align: justify;">
Here, borrowing <code>player.name</code> immutably prevents <code>player.score</code> from being mutably borrowed at the same time.
</p>

<p style="text-align: justify;">
These ownership and borrowing mechanisms are not just theoretical—they have practical implications, especially in concurrent programming where managing access to shared data is critical. By enforcing these rules, Rust provides strong guarantees against data races, making concurrent code safer and easier to reason about.
</p>

<p style="text-align: justify;">
In summary, understanding and applying the principles of ownership and borrowing to structs in Rust not only helps in managing data safely but also optimizes resource usage and enhances program reliability, particularly in multi-threaded environments.
</p>

## 17.6. Trait Implementation for Structs
<p style="text-align: justify;">
A fundamental feature of Rust’s type system is its support for traits, which allow for the definition of shared behavior across different types. Structs can implement traits, thereby extending their functionality and enabling code reuse. This section delves into the specifics of implementing traits for structs, highlighting both derived traits and custom implementations.
</p>

<p style="text-align: justify;">
Rust provides several "derived" traits that can be automatically implemented by the compiler for your structs. These include <code>Debug</code>, <code>Clone</code>, <code>Copy</code>, and <code>Default</code>, among others. Deriving these traits is straightforward and highly beneficial for basic usability of your types.
</p>

<p style="text-align: justify;">
For example, consider a struct <code>Book</code> that we want to print out easily for debugging purposes:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Debug)]
struct Book {
    title: String,
    author: String,
    pages: u32,
}

fn main() {
    let my_book = Book {
        title: "Rust Programming".to_string(),
        author: "OpenAI".to_string(),
        pages: 512,
    };

    println!("{:?}", my_book);
}
{{< /prism >}}
<p style="text-align: justify;">
Here, the <code>#[derive(Debug)]</code> attribute automatically implements the <code>Debug</code> trait for <code>Book</code>, allowing us to print the struct using the <code>{:?}</code> formatter in the <code>println!</code> macro.
</p>

<p style="text-align: justify;">
While derived traits offer convenience, more complex behaviors require custom implementations. For instance, if you want to check if two instances of a type are the same, you might implement the <code>PartialEq</code> trait:
</p>

{{< prism lang="rust" line-numbers="true">}}
struct Coordinates {
    x: f64,
    y: f64,
}

impl PartialEq for Coordinates {
    fn eq(&self, other: &Self) -> bool {
        (self.x - other.x).abs() < f64::EPSILON && (self.y - other.y).abs() < f64::EPSILON
    }
}

fn main() {
    let point1 = Coordinates { x: 24.0, y: 42.0 };
    let point2 = Coordinates { x: 24.0, y: 42.0 };

    println!("Are the points equal? {}", point1 == point2);
}
{{< /prism >}}
<p style="text-align: justify;">
n this example, <code>PartialEq</code> is manually implemented to consider floating point precision, which is crucial for coordinates.
</p>

<p style="text-align: justify;">
A struct can implement multiple traits, enhancing its functionality comprehensively. For example, adding functionality to clone and display a struct:
</p>

{{< prism lang="rust" line-numbers="true">}}
#[derive(Clone, Debug)]
struct Device {
    id: u32,
    name: String,
}

impl std::fmt::Display for Device {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{} (ID: {})", self.name, self.id)
    }
}

fn main() {
    let device = Device {
        id: 101,
        name: "Router".to_string(),
    };

    let device_clone = device.clone();
    println!("{}", device); // Display
    println!("{:?}", device_clone); // Debug
}
{{< /prism >}}
<p style="text-align: justify;">
Here, <code>Device</code> is both clonable and printable in a user-friendly format thanks to the <code>Display</code> trait, while still retaining the debug-print capabilities via the <code>Debug</code> trait.
</p>

<p style="text-align: justify;">
Implementing traits for structs not only enhances the functionality of your types but also ensures that they integrate seamlessly with Rust's standard library and ecosystem. Whether it’s custom behavior or leveraging derived traits, the ability to define how your types interact with Rust's features like formatting, comparison, and copying is fundamental to creating robust, reusable components.
</p>

<p style="text-align: justify;">
In summary, by understanding and utilizing trait implementations, you can harness the full potential of structs in Rust, making your code more modular, maintainable, and expressive.
</p>

## 17.7. Advices
<p style="text-align: justify;">
Structs are essential building blocks in Rust, enabling developers to group related data under a single type. There are three main types of structs: named-field, tuple-like, and unit-like, each suited for different purposes and use cases. Named-field structs provide clear and explicit field names, which enhance code readability and maintainability, making them ideal for complex data structures. Tuple-like structs, on the other hand, offer a simpler, positional approach that is useful when the order of data elements is more important than their names. Unit-like structs, although they don't contain data, are valuable for type-centric operations and signaling unique types. Understanding and effectively utilizing these different types of structs is crucial for writing robust and idiomatic Rust code. Here are some tips to help you use structs more effectively.
</p>

- <p style="text-align: justify;"><strong>Choose the Right Struct Flavor</strong>: When designing data structures, select the appropriate type of struct based on the use case. For complex data with distinct fields, named-field structs are best for readability and maintenance. Use tuple-like structs for simpler, ordered data where field names are unnecessary. Unit-like structs are ideal for marker or phantom types where the struct's existence is more important than containing data.</p>
- <p style="text-align: justify;"><strong>Prioritize Clarity and Consistency</strong>: For named-field structs, use descriptive and consistent naming conventions for fields. This practice not only improves code readability but also helps in communicating the purpose and structure of the data to other developers.</p>
- <p style="text-align: justify;"><strong>Encapsulation and Data Integrity</strong>: Encapsulate fields whenever possible by making them private and providing public methods to access or modify them. This approach maintains data integrity and prevents unauthorized or accidental modifications, promoting safer and more controlled data handling.</p>
- <p style="text-align: justify;"><strong>Leverage Struct Methods and Associated Functions</strong>: Implement methods and associated functions to encapsulate behavior related to the struct. This practice keeps the logic associated with the data close to the data itself, promoting better organization and modularity in your code.</p>
- <p style="text-align: justify;"><strong>Use Traits for Common Behavior</strong>: Implement traits on structs to define shared behavior across different types. This can simplify your code and make it more extensible. For example, implementing the <code>Display</code> trait allows for easy printing of struct data, while the <code>Clone</code> or <code>Copy</code> traits can define how instances are duplicated.</p>
- <p style="text-align: justify;"><strong>Minimize Data Duplication</strong>: Be mindful of data ownership and avoid unnecessary duplication. Use references and borrowing to pass data around functions and methods without moving ownership. This approach conserves memory and can improve performance.</p>
- <p style="text-align: justify;"><strong>Optimize for Performance</strong>: Be aware of the trade-offs between using heap-allocated data (e.g., <code>Box</code>, <code>Vec</code>, <code>String</code>) and stack-allocated data. For structs containing large or dynamically sized data, consider using heap allocation to avoid stack overflows and manage memory usage more effectively.</p>
- <p style="text-align: justify;"><strong>Documentation and Comments</strong>: Document your structs, especially their fields and intended use cases. This not only helps others understand your code but also serves as a reference for yourself when revisiting the project after some time.</p>
- <p style="text-align: justify;"><strong>Testing and Debugging</strong>: Write tests for your structs, particularly if they encapsulate critical logic or have complex behavior. Additionally, derive the <code>Debug</code> trait for your structs to facilitate easy debugging, as it allows you to print struct contents quickly during development.</p>
- <p style="text-align: justify;"><strong>Plan for Future Extensions</strong>: When designing structs, consider future extensions and potential changes. This foresight can help you design more flexible and adaptable data structures, reducing the need for breaking changes or major refactoring later on.</p>
<p style="text-align: justify;">
These practices help Rust programmers create safe, efficient, and maintainable data structures, laying a solid foundation for building complex systems.
</p>

## 17.8. Further Learning with GenAI
<p style="text-align: justify;">
Assign yourself the following tasks: Input these prompts to ChatGPT and Gemini, and glean insights from their responses to enhance your understanding.
</p>

1. <p style="text-align: justify;">Explore the benefits of named-field structs in Rust. How do they enhance code clarity and maintainability? Provide examples where named-field structs are particularly advantageous compared to other struct types.</p>
2. <p style="text-align: justify;">Discuss the use cases for tuple-like structs in Rust. How do they differ from named-field structs in terms of syntax and usage? Illustrate with examples where tuple-like structs are the preferred choice.</p>
3. <p style="text-align: justify;">Examine the purpose and applications of unit-like structs in Rust. In what scenarios are they used, and why are they useful despite not containing any data? Include examples to highlight their practical uses.</p>
4. <p style="text-align: justify;">Explain the concept of generic structs in Rust. How do they enable code reusability and flexibility? Provide an example of a generic struct and discuss how it can be used with different types.</p>
5. <p style="text-align: justify;">Analyze how Rust's ownership and borrowing rules apply to structs. What are the key considerations when defining and using structs in a Rust program? Discuss the implications for memory safety and data management.</p>
6. <p style="text-align: justify;">Delve into how ownership works with structs in Rust. What happens to a struct's data when it is moved or assigned to another variable? Provide examples illustrating different ownership scenarios.</p>
7. <p style="text-align: justify;">Investigate the concept of borrowing with structs in Rust. How do mutable and immutable borrowing work with structs, and what are the rules and limitations? Use examples to demonstrate common borrowing patterns.</p>
8. <p style="text-align: justify;">Discuss how traits are implemented for structs in Rust. What are the benefits of implementing traits, and how do they facilitate polymorphism and code reuse? Provide examples of trait implementations for common traits like <code>Debug</code>, <code>Clone</code>, and custom traits.</p>
9. <p style="text-align: justify;">Compare and contrast the different types of structs in Rust: named-field, tuple-like, and unit-like. What are the strengths and limitations of each type? When should one type be chosen over the others?</p>
10. <p style="text-align: justify;">Explore advanced patterns and techniques for using structs in Rust. How can structs be used in conjunction with enums, pattern matching, and advanced trait implementations to create powerful and flexible data structures? Include examples to illustrate these patterns.</p>
<p style="text-align: justify;">
Diving into the world of structs in Rust is like embarking on an exciting journey through the intricacies of data management and memory safety. Each of these prompts—whether exploring the specifics of named-field, tuple-like, or unit-like structs, or delving into advanced topics like generic structs, ownership, and trait implementations—serves as a vital milestone in your quest to master Rust's powerful type system. Embrace each challenge with enthusiasm and curiosity, as you uncover new concepts and techniques. This exploration is not just about learning new syntax or rules; it's about deepening your understanding of how to write safe, efficient, and idiomatic Rust code. As you work through these prompts, take the time to experiment, reflect on what you've learned, and celebrate your progress. This journey promises to be both enlightening and rewarding, offering you a solid foundation in Rust’s rich and nuanced type system. Approach each topic with an open mind, adapt the exercises to your learning style, and enjoy the process of becoming a more proficient and confident Rust programmer. Good luck, and relish the adventure of mastering structs in Rust!
</p>
