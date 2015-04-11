# A Class and an Object

Let's create a fresh file that we can play around with - call it `play.php`.
Now we can warn the rebels that It's a TRAAAP!

[[[ code('03f3146a85') ]]]

Put `play.php` in the URL...
and there it is! We've conquered the echo statement!

## Creating a Class

Now to the cool stuff! The first super-important big awesome-crazy thing
in object-oriented programming is.... a class! To create one, write the keyword
`class` then the name of it - this name can be almost anything alphanumeric.
Finish things off with an open curly brace and a close curly brace. Nice work.

[[[ code('8c256fa244') ]]]

Don't worry about *what* this "class" thing is yet. But if you refresh, you
can see that creating a class doesn't actually *do* anything.

## Creating an Object

Creating a class, check! And with that, we can see the second super-important
big awesome-crazy thing in object-oriented programming: an object! Once you
have a class, you can instantiate a new *object* from that class, and it
looks like this.

Create a variable called `$myShip` and then use the `new` keyword, followed
by the name of the class, then open parenthesis, close parenthesis:

[[[ code('c435e86b7c') ]]]

It kind of looks like we're calling a function called `Ship()`, except for
the `new` keyword in front that tells PHP that `Ship` is a class, and we're
instantiating a new object from it.

Before we explain any of this - refresh again. Still no changes. We have
this new thing called an object that's set to `$myShip`, but it doesn't cause
anything to happen.

## The Skinny on Classes and Objects

Ok, let me explain this class and object stuff. When this stuff finally
"clicks", you'll know that you really *get* object-oriented programming.
So listen carefully, and I'll come back to this later as we add more stuff.

### Class: A Worksheet with Labels and Blank Lines

Pretend with me: you're the manager of a shipping-dock on the Deathstar.
To avoid any force-choking, when each ship lands, you need to take an inventory
of it: what's its name, size, does it have a warp drive, what's the fuel
level, weapon power, defense strength and other stuff. And also imagine,
that even though you're in a flying space death machine, you don't have computers:
you track everything by making copies of a template worksheet you designed
in Excel.

A class is like that empty template, with blank lines for the ship's name
and size, a yes/no option for warp drive and blanks for fuel-level, weapon
power and defense strength. It's not actually a ship of course, but it defines
all the properties that a ship might have.

### Object: A Completed Worksheet

Ok, I think you've got the gist on classes, now let's go over objects.
This is where I'm supposed to tell you to think of an object like a *real*
ship that's landed in our dock. That's correct, but I think it's closer to
think of an object like a completed worksheet that we've filled out for a
ship: complete with its name, weapon details, strength and fuel-levels.

If 10 ships land, then we'll print out 10 blank worksheets and fill each
in with different details. If we re-fuel one of those ships, we'll update
the fuel level on its worksheet.

But each ship is using the same template, or class. If we wanted to also
track a ship's weight, we'd need to go back to the template and add a field
for it there.

Right now, our class is empty. That's like a template with no blank fields
to fill in. Not helpful - time to fix that!

## Objects are like Uptight (Structured) Arrays

Ok, clear your mind quickly and think about arrays. An array holds data on
keys: we choose a key - like `hasWarpDrive` - then put something there. Simple.

An object works *exactly* like an array, except instead of calling these
storage spaces keys, we call them properties. But basically, they work the
same way.

There is one big difference between an array and an object. With an array,
you can just invent a new key and set data on it. But with an object, you
need to pre-register the possible properties it might have in its class.

Back at our loading dock, this means an array is like a template where each
line has two blanks: one for the value and one for what that value is. We
might fill in a line with the ship's name, but not the fuel level. And maybe
we'll write down the color of the ship on another line, and because I don't
really like my job, I'll put my current favorite song on the last line.
If I give 10 sheets to my manager, they'll have no guarantee *what* data
I may or may not have recorded. Simple, but unstructured.

But an object is like the sheets we were talking about earlier: it has a
list of exactly what we want to track with a blank next to each for that
value. So if we want to be able to store the name of each ship, we'll need
to add a spot for it on the template. In object-oriented land, we need to
add a `name` property to our `Ship` class.

### Adding a Property to a Class

Let's do it! Say `public` then `$`, then the name of your property. In
this case, our name is actually `name`:

[[[ code('396303d088') ]]]

This doesn't do anything, but now `Ship` objects are allowed to hold data
on a `name` property. And how do we set that? We do it with this syntax here:

[[[ code('076465fd0b') ]]] Setting the property

Now we can read the data from that property using the same syntax:

[[[ code('686f0a321f') ]]]

Try it out! It's working great.

Does this feel familiar? It works *exactly* like an array, except instead
of the square-bracket syntax, we use this dash, greater-than syntax, let's 
call that an "arrow".

The *real* difference between an object and an array is that an object has
a class that defines all possible properties that it can hold, instead of
being able to store any random keys you dream up, like an array.

**TIP** Technically, you can set a property (e.g. `$myShip->weight = 100`)
on an object without creating a property for it in the class. But this is
frowned upon, and not seen commonly in higher-quality code. So don't do it!

## Classes: Data Structure Docs

And with this simple difference, you get a *huge* benefit. A class is like
programmer documentation. If I give you an array, you have no idea what data
is on it. You can `var_dump` it to see, then just hope that it'll always
have the same keys in the future.

But if I hand you a `Ship` object, you *know* something about it. You know
that it will *always* have a `name` property, and it'll never have `email`
or `phone` properties: because they're not in the class. The class gives
us a skeleton and some rules we know it'll follow.

Now let's talk about something even better than this: methods.
