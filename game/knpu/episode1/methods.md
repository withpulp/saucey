# Class Methods

Arrays and objects have a lot in common: arrays have keys while objects have 
properties, but both store data.

Objects have one other big, incredible, mind-blowing advantage: methods.
A method is a fancy word for a function, and we're all comfortable with those.
The difference is that a method lives *inside* of a class.

To create a method, start with `public function`. After this, it looks like
a normal function - let's call ours `sayHello`, and add the normal parenthesis
and curly braces stuff. Inside, we can do anything - so let's echo `Hello`:

[[[ code('10b5da3cba') ]]]

To call the method, let's use our object "arrow" syntax. Let's add an `<hr/>`
so I don't confuse myself, then `$myShip`, then arrow, then `sayHello()`:

[[[ code('c29be467bc') ]]]

The only difference between accessing a property and a method is the open
parenthesis and close parenthesis, so don't forget that. And a method is
*just* like a traditional function, except it lives inside of the class,
so you have to call it on the object. And when we refresh, success!

This is kind of *amazing* because we have little packages of data that
can now perform actions and *do* things through methods. Arrays can't do
*anything* like that.

## Referencing Properties from Inside a Class

So let's add another - a `getName()` method. Remember how functions can return
a value? Sure, methods can do that too. Let's not *actually* return the name
of *this* ship yet, let's fake it:

[[[ code('993cb59a6b') ]]]

Down below, we call it the exact same way, except we can echo what it returns:

[[[ code('00e766afc5') ]]]

Now refresh! There's our fake name. Of course, what I *really* want to do
is return the name of the ship that I'm calling this method on. I know, not
the most interesting function, but it gives us a new problem. When we have
the `$myShip` variable, we *know* how to access a property - just use the
arrow syntax on it. But when we're *inside* of the class, how can we get
the value of the `name` property?

The answer is with a very special variable called `$this`:

[[[ code('68d2dd95e1') ]]]

Here's the rule: when you're inside of a method, you magically have access
to a variable called `$this`. And `$this` is whatever `Ship` object that
we're calling the method on, in our case our favorite `$myShip` object whose
name is "Jedi Starship". In *all* cases, the variable is called `$this`,
that's just what the PHP Jedi elders decided this magic name should be.

When we refresh, hey - there's our ship's *real* name!

## Adding more Properties

Our `Ship` class has just one property. Let's go back and look at the `get_ships()`
function I wrote before we started. Here, each ship has a key for `name`,
`weapon_power`, `jedi_factor` and `strength`. Let's add three more properties
to *our* class: `weaponPower`, `jediPower` and `strength`. I camel-cased
`weaponPower` and `jediPower` - that's kind of a standard, but you can do
whatever you want:

[[[ code('af12d12d9f') ]]]

### Default Property Values

You can also give a property a default value. So if you create a new `Ship`
object and we never set the `weaponPower`, let's default its value to zero.
Let's do that for `jediFactor` and `strength` too.

[[[ code('fc6ebd1126') ]]]

These new properties aren't special, so we can use them like before. Let's
`var_dump` the `weaponPower` property:

[[[ code('ea0a7d3dec') ]]]

When we refresh, it dumps zero. Cool! That's using our default value because
we never actually set the `weaponPower`. Let's set it now - `$myShip->weaponPower = 10;`:

[[[ code('f0bc0f5ccb') ]]]

Now we see 10. Awesome!
