# Code Style Guide

## Declarative style

Favor a declarative programming style over imperative.
That means expressing the logic of computation without describing its control flow.

### No setters

> Setters are evil

Avoid defining setter methods that simply assign values to struct fields.
If you need to modify a field it seems that you wrong design of your struct.
The most of the values **must be immutable** after the struct creation.
Consider to create a new instance of the struct with the desired values instead.

#### No setters: unexpected changes

```go
package order

type Order struct {
    price int64
}

func NewOrder(price int64) *Order {
    return &Order{
        price: price,
    }
}

func (o *Order) GetPrice() int64 {
    return o.price
}

func (o *Order) SetPrice(price int64) {
    o.price = price
}
```

```go
package main

import (
    "fmt"
    "your_module/order"
)

func main() {
    ord := order.NewOrder(100)
    processOrder(ord)
    fmt.Println("Order price after processing:", ord.GetPrice()) // Unexpectedly prints 200, but should be 100
}

func processOrder(o *order.Order) {
    o.SetPrice(200) // Oh, no! Some developer changed the price directly!
}
```

### No getters

> Getters are evil

If you do not use setters - getters are useless.
If you really need to get some data from the struct - just omit `Get` prefix in the method name. That is all!

If the method returns, for example, the `price` field - just name it `Price()`. Why do you need `GetPrice()`?
Does the `Price() int64` not returns the price? Why do you need `Get` prefix? Just avoid it.

**Use:**

```go
package order

type Order struct {
    uuid string
    status string
    price int64
}

func NewOrder(
    uuid string,
    status string,
    price int64,
) *Order {
    return &Order{
        uuid: uuid,
        status: status,
        price: price,
    }
}

func (*Order) UUID() string {
    return o.uuid
}

func (o *Order) Status() string {
    return o.status
}

func (o *Order) Price() int64 {
    return o.price
}
```

```go
package main

import (
    "fmt"
    "your_module/order"
)

func main() {
    ord1 := order.NewOrder("uuid1", "status1", 100)
    ord2 := order.NewOrder("uuid2", "status2", 200)
    fmt.Println(
        "Order 1: %s, %s, %s:",
        ord1.UUID(),
        ord1.Status(),
        ord1.Price(),
    ) // Prints uuid1, status1, 100
    fmt.Println(
        "Order 2: %s, %s, %s:",
        ord2.UUID(),
        ord2.Status(),
        ord2.Price(),
    ) // Prints uuid2, status2, 200
}

func processOrder(o *order.Order) {
    // There is no any method changes the input order!
}
```

Look! No `Get` prefix! Just `Price()` method that returns the price.
And we **do not have any setters**! The `price` field is immutable after the struct creation!
**We are sure that no one can change the price unexpectedly!**

### No logic in constructors

Constructors are meant to initialize and return instances of types and should not contain any logic or side effects.
They should simply set up the struct with default values or provided parameters.

### Custom types

### Funcs return only one value

## Document all

> ⚠️ **Even unexported!**

Every package, function, method, field and type must have a clear and concise comment explaining its purpose and usage.
Use [GoDoc conventions](https://go.dev/doc/comment) for documentation.

### What the function does

Describe what the function does and not how it does it.
The doc have to include a summary of the function's behavior, its inputs, outputs, and any side effects.

#### Sentence structure

The first sentence should be a short summary that starts with the name of the function.
**After a blank line**, provide more detailed information if necessary.
The comment should be written in full sentences and be clear to someone unfamiliar with the code.

#### Input / Output

#### Multiple parameters / return values

If the function has more than one parameter or returns values, describe each of them clearly.
Specify the type and purpose of each parameter and return value.

```go
// Tokenize splits the input string into a slice of substrings based on the specified delimiter.
//
// It returns a slice of substrings and an error if the operation fails.
//
// Parameters:
//   - input: The string to be tokenized.
//   - delimiter: The delimiter used to split the input string.
// 
// Example:
//
//  Tokenize("a,b,c", ",") // returns []string{"a", "b", "c"}, nil
func Tokenize(input string, delimiter string) ([]string, error)
```

**How it looks in VSCode:**

![how it looks in VSCode](docs/style//img/godoc_02.png)

#### Single parameter / return value

If the function has only one parameter and one return value,
a brief description is sufficient but if necessary, you can still elaborate.

**For example:**

```go
// ParseType parses the type from a commit subject string.
//
// The expected format has the type at the beginning of the subject,
// optionally followed by a scope in parentheses and a colon.
//
// For example:
//
//  "feat(ui): add new button" // type is "feat"
//  "fix: resolve issue" // type is "fix"
func ParseType(s string) Type
```

**How it looks in VSCode:**

![how it looks in VSCode](docs/style/img/godoc_01.png)

#### No arguments / return values

If the function has no parameters or does not return any values, a simple description of its purpose is sufficient.

**For example:**

```go
// Initialize sets up the necessary configurations for the application.
func Initialize()
```

## Exporting

### Functions must be exported

Every function or method is intended to be used outside its package and must be exported
(i.e., its name should start with an uppercase letter).
This makes the function accessible to other packages.

We do not allow any unexported functions in the codebase!
If you dedicate a code in a function - it must be accessible from others outside the package!

#### Functions must be exported: config example

**❌ Bad:**

```go
package main

func main() {
    cfg, err := file.ReadConfig("config.json")
    if err != nil {
        log.Fatal(err)
    }
    // Use cfg...
}
```

```go
package file

// ReadConfig reads and parses a config file.
func ReadConfig(path string) (*Config, error) {
    data, err := readFile(path)
    if err != nil {
        return nil, err
    }
    return parseConfig(data)
}

func readFile(path string) ([]byte, error) {
    return os.ReadFile(path)
}

func parseConfig(data []byte) (*Config, error) {
    var cfg Config
    err := json.Unmarshal(data, &cfg)
    return &cfg, err
}
```

**✅ Good:**

```go
package main

import (
    "log"
    "your_module/file"
)

func main() {
    cfg, err := file.ReadConfig("config.json")
    if err != nil {
        log.Fatal(err)
    }
    // Use cfg...
}
```

```go
package file

// ReadConfig reads and parses a config file.
func ReadConfig(path string) (*Config, error) {
    data, err := Read(path)
    if err != nil {
        return nil, err
    }
    return ParseConfig(data)
}

// Read reads a file and returns its contents.
func Read(path string) ([]byte, error) {
    return os.ReadFile(path)
}

// ParseConfig parses config data from bytes.
func ParseConfig(data []byte) (*Config, error) {
    var cfg Config
    err := json.Unmarshal(data, &cfg)
    return &cfg, err
}
```

**⭐️ Better:**

```go
package main

import (
    "log"
    "your_module/file"
    "your_module/config"
)

func main() {
    data, err := file.Read("config.json")
    if err != nil {
        log.Fatal(err)
    }
    cfg, err := config.ParseConfig(data)
    if err != nil {
        log.Fatal(err)
    }
    // Use cfg...
}
```

```go
package file

// Read reads a file and returns its contents.
func Read(path string) ([]byte, error) {
    return os.ReadFile(path)
}
```

```go
package config

func ParseConfig(data []byte) (*Config, error) {
    var cfg Config
    err := json.Unmarshal(data, &cfg)
    return &cfg, err
}
```

### Any type must have a constructor

Each struct or type must have a constructor function that initializes and returns an instance of the struct.
The constructor should be named `New<TypeName>` and should set default values for the struct's fields if necessary.

### Types must be exported

All structs and types that are intended to be used outside their package must be exported
(i.e., their names should start with an uppercase letter).
This allows other packages to define them in outer function signatures.

But! **The fields of the structs must be unexported** to maintain encapsulation
and prevent direct access from outside the package.

### Fields must be unexported

**All struct fields must be unexported** to maintain encapsulation and prevent direct access from outside the package.

When defining structs, ensure that all fields are unexported (i.e., start with a lowercase letter).
This encapsulation helps maintain control over how data is accessed and modified.

## Test all

Every new feature or bugfix must include corresponding tests.
Use Go's testing package to write unit tests that cover various scenarios and edge cases.

### Testify

Use [testify package](https://github.com/stretchr/testify)
to make **asserts** in your tests.

> ❌ Never use `t.Error()` because it definetely damages the reading!

**❌ Bad:**

VSCode and JetBrains Goland can create unit-tests templates in one click
that extremely improves your productivity but it still needs to refactor
the `t.Run()` section!

```go
package file

import "testing"

func TestName_String(t *testing.T) {
    tests := []struct {
        name string
        n    Name
        want string
    }{
        // TODO: Add test cases.
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            if got := tt.n.String(); got != tt.want {
                t.Errorf("Name.String() = %v, want %v", got, tt.want)
            }
        })
    }
}
```

**✅ Good:**

```go
package file

import (
    "testing"

    "github.com/stretchr/testify/assert"
)

func TestName_String(t *testing.T) {
    tests := []struct {
        name string
        n    Name
        want string
    }{
        // TODO: Add test cases.
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            assert.Equal(
                t, 
                tt.want,
                tt.n.String()
            ) 
        })
    }
}
```

> 💡 Do not ignore `require` in testify package to ensure yourself
that some field is not nil pointer
or the implementation must have some functionality

### Separate test packages

Add suffix `_test` to the name of the package you test.
It obligates you to import the implementation
and you have to declare a constructor for the type you test.

**❌ Bad:**

```go
package file

import (
    "testing"

    "github.com/stretchr/testify/assert"
)

func TestName_String(t *testing.T) {
    t.Parallel()
    tests := []struct {
        name string
        n    Name
        // ...
    }{
        {
            name: "some case",
            n: Name{
                value: "example.txt",  
            },
            // ...
        }
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            // ...
        })
    }
}
```

**✅ Good:**

```go
package file_test

import (
    "testing"

    "github.com/you/repo/file"
)

func TestName_String(t *testing.T) {
    t.Parallel()
    tests := []struct {
        name string
        n    file.Name
        // ...
    }{
        {
            name: "some case",
            n: NewName("example.txt"),
            // ...
        }
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
           // ...
        })
    }
}
```

### Structs in tests

Create the structs to justify bootraping the cases in your tests.
It improves declaration and understafing by reading of your test cases.

**❌ Bad:**

```go
package config

import "testing"

func TestParseConfig(t *testing.T) {
    tests := []struct {
        name    string
        fname   string
        want    Config
        wantErr bool
    }{
        {
            name:    "ok",
            fname:   "path/to/config",
            // ...
            wantErr: false,
        },
        {
            name:    "failed to parse",
            fname:   "path/to/config",
            // ...
            wantErr: true,
        },
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got, gotErr := ParseConfig(tt.fname)
            assert.Equal(
                t,
                tt.want,
                got,
            )
            if tt.wantErr {
                assert.Error(t, gotErr)
            } else {
                assert.NoErrorf(
                    t,
                    gotErr,
                    "unexpected error: %v",
                    gotErr,
                )
            }
        })
    }
}
```

**✅ Good:**

```go
package config_test

import (
    "testing"

    impl "github.com/you/repo/config"
)

func TestParseConfig(t *testing.T) {
    type args struct{
        fname string
    }
    type want struct {
        config  impl.Config
        errored bool
    }
    tests := []struct {
        name string
        args args
        want want
    }{
        {
            name: "ok",
            args: args{
                fname: "path/to/file",
            }
            want: want{
                config:  impl.NewConfig(
                    // ...
                ),
                errored: false,
            }
        },
        {
            name: "failed to parse",
            args: args{
                fname: "path/to/file",
            }
            want: want{
                config:  impl.Config{},
                errored: true,
            }
        },
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got, gotErr := impl.ParseConfig(tt.args.fname)
            assert.Equal(
                t,
                tt.want.config,
                got,
            )
            if tt.want.errored {
                assert.Error(t, gotErr)
            } else {
                assert.NoErrorf(
                    t,
                    gotErr,
                    "unexpected error: %v",
                    gotErr,
                )
            }
        })
    }
}
```

**⭐️ Better:**

```go
package config_test

import (
    "testing"

    impl "github.com/you/repo/config"
)

func TestParseConfig(t *testing.T) {
    type args struct{
        fname string
    }
    type want struct {
        config  impl.Config
        err error
    }
    tests := []struct {
        name string
        args args
        want want
    }{
        {
            name: "ok",
            args: args{
                fname: "path/to/file",
            }
            want: want{
                config: impl.NewConfig(
                    // ...
                ),
                err:    nil,
            }
        },
        {
            name: "failed to parse",
            args: args{
                fname: "path/to/file",
            }
            want: want{
                config:  impl.Config{},
                errored: impl.ErrNotFound,
            }
        },
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got, gotErr := impl.ParseConfig(tt.args.fname)
            assert.Equal(
                t,
                tt.want.config,
                got,
            )
            assert.ErrorIs(
                t,
                gotErr,
                tt.want.err,
            )
        })
    }
}
```

That way you bring declarative style to describe the test cases
and the code supposed to be more readable and understable.

## No newlines in functions

Avoid unnecessary newlines within function bodies to maintain readability and compactness.

**✅ Good:**

```go
func Add(a int, b int) int {
    return a + b
}
```

**❌ Bad:**

```go
func Add(a int, b int) int {
    return a + b
}
```
