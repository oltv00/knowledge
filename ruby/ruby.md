# Ruby

* [Ruby basics](#ruby-basics)
  * [Puts](#puts)
  * [Multiple strings](#multiple-strings)
  * [`BEGIN` statement](#begin-statement)
  * [`END` statement](#end-statement)
  * [Comments](#comments)
* [Classes and Objects](#classes-and-objects)
  * [Defining a Class](#defining-a-class)
  * [Variables in Class](#variables-in-class)
  * [Creating objects using `new` method](#creating-objects-using-new-method)
  * [Custom method to create objects](#custom-method-to-create-objects)
  * [Member functions in Class](#member-functions-in-class)
* [Variables, Constants and Literals](#variables-constants-and-literals)
  * [`Global` variables](#global-variables)

## Ruby basics

put it in header of every .rb file

```bash
#!/usr/bin/ruby -w
```

-w - verbose mode. If program file not specified, reads from STDIN.

### Puts

Print some text.

Syntax:

```ruby
puts "<some text>";
```

Example:

```ruby
puts "Some text"
```

### Multiple strings

```ruby
print <<EOF # multiple line string
  This is the first way of creating
  here document ie. multiple line string.
EOF
```

```ruby
print <<"EOF" # same as above
EOF
```

```ruby
print<<`EOC` # execute commands
  echo hi there
  echo lo there
EOC
```

```ruby
print <<"foo", <<"bar" # you can stack them
  I said foo.
foo
  I said bar.
bar
```

### `BEGIN` statement

Declares code to be called before the program is run.

Syntax:

```ruby
BEGIN {
  code
}
```

Example:

```ruby
#!/usr/bin/ruby
puts "This is main Ruby Program"

BEGIN {
  puts "Initializing Ruby Program"
}
```

Result:

```ruby
Initializing Ruby Program
This is main Ruby Program
```

### `END` statement

Declares code to be called at the end of the program.

Syntax:

```ruby
END {
  code
}
```

Example:

```ruby
#!/usr/bin/ruby
puts "This is main Ruby Program"

END {
  puts "Terminating Ruby Program"
}
BEGIN {
  puts "Initializing Ruby Program"
}
```

Output:

```ruby
Initializing Ruby Program
This is main Ruby Program
Terminating Ruby Program
```

### Comments

```ruby
# This is comment.
puts "Some code" # This is again comment.

= begin
This is a comment.
This is a comment, too.
= end
```

## Classes and Objects

### Defining a Class

Syntax:

```ruby
class <class_name>
end
```

### Variables in Class

* `Local` Variables
  * Defined in a method. Local variables are not available outside the method.
  * Local variables begin with a lowercase letter or _.
* `Instance` Variables
  * Instance variables are available across methods for any particular instance or object.
  * Instance variables are preceded by th at sign (@) followed by the variable name.
* `Class` Variables
  * Class variables are available across different objects.
  * They are preceded by the sign @@ and are followed by the variable name.
* `Global` Variables
  * The global variables are always preceded by the dollar sign ($).

Example:

```ruby
class Customer
  @@no_of_customers = 0
end
```

### Creating objects using `new` method

Syntax:

```ruby
<variable_name> = <class_name>.new
```

Example:

```ruby
foo = Foo.new
```

### Custom method to create objects

You can pass parameters to method new and those parameters can be used to initialize class variables.

Example:

```ruby
class Foo
  def initialize(foo, bar, baz)
    @foo = foo
    @bar = bar
    @baz = baz
  end

  foo = Foo.new("value_1", "value_2", "value_3")
  bar = Foo.new("value_1", "value_2", "value_3")
end
```

### Member functions in Class

Syntax:

```ruby
class <class_name>
  def <function_name>
  end
end
```

Example:

```ruby
#!/usr/bin/ruby

class Foo
  def hello
    puts "Hello Ruby!"
  end
end

# Now using above class to create objects
foo = Foo.new
foo.hello
```

Output:

```ruby
Hello Ruby!
```

## Variables, Constants and Literals

### `Global` variables

* Global variables begin with $
* Uninitialized global variables have the value nil and produce warnings with the -w option.

Example:

```ruby
#!/usr/bin/ruby

$global_variable = 10

class Foo
  def print_global
    puts "Global variable in Foo is #$global_variable"
  end
end

class Bar
  def print_global
    puts "Global variable in Bar is #$global_variable"
  end
end

foo_obj = Foo.new
foo_obj.print_global

bar_obj = Bar.new
bar_obj.print_global
```

NOTE - In Ruby, you CAN access value of any variable or constant by putting a hash (#) character just before that variable or constant.

Result:

```ruby
Global variable in Foo is 10
Global variable in Bar is 10
```
