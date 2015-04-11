# The Constructor!

Here's the next challenge, sometimes I want my ships to be broken. So when
a ship comes in it might be able to fight or it might be under repair. This
is a property on a `Ship`, a `Ship` could be under repair or not. So I'll
add this as a new private property that has a boolean which can be true or
false:

[[[ code('596111b92d') ]]]

The challenge is that whenever we create our objects inside of `functions.php`,
I want to randomly set a `Ship` to be under repair or not under repair, and
I want it to happen automatically. So just by creating a `Ship`, I want it
to internally figure out if it is under repair or not. 

## public function __construct

This is where the idea of a constructor comes in. Whenever you create an
object, you can actually hook into that process and say: "Hey whenever a
`Ship` is created, call this function so I can set some stuff up." The way
you do this is by creating a very special public function inside of your
class called `__construct()`:

[[[ code('330a2c780b') ]]]

The magic here is that name: it must be `__construct`. And just by having
this it should be called everytime we say `new Ship()`. 

Let's try it, refresh! And that's it: it's called four times, once for each
of our ships. And it's called right when you say `new Ship()`, so if I throw
in a `die()` statement right after creating a `Ship`, we're still going to
see one of those called. 

## Setting up Data in __construct

Now we have a really powerful way to set up our data. Internally we can determine
whether or not the `Ship` is under repair. We'll use `$this- underRepair = mt_rand(1, 100) < 30;`:

[[[ code('8289eb218d') ]]]

This gives each ship a 30% chance of being broken...maybe a wing fell off!

To see this in action, let's cheat real quick and `var_dump` the `$ships`
array. When we refresh we can see the first two ships are ready for action
but the third one isn't. Refresh again and they're all ready to fly. And
a third time shows that the first two are busted and the other two are 
battle worthy. So that's working already!

## Don't Create a Getter Function

Next, let's go into `index.php` and up top we have our table information.
Let's include status which will tell us if our ship is under repair or not:

[[[ code('bddc5128b4') ]]]

Now so far, we don't have a way to access that new property. It's private
and we don't have a getter or a setter and you don't necessarily need to
create these. In fact, we don't want a setter: it's being set automatically
inside of the class itself. But I *do* want to figure out if this `Ship` is
functional or not. So what I'll do is create a new public
function and I'll call it `isFunctional()`:

[[[ code('51efa19b7c') ]]]

This will be the opposite of the `underRepair` value. If it is `underRepair`,
then it is not functional and if it is functional then it is not `underRepair`.
For the outsider whose going to be calling this function, they don't care
what we're doing internally to figure that out.

Let's go back to `index.php` and create a nice if statement. If `$ship` is
functional, `else`, and we'll put some adorable icons:

[[[ code('e9c312ec1b') ]]]

A sunshine for functional and a sad cloud for not functional.

Refresh and try it out, four sunshines and one cloud. Awesome! 

## Leveraging isFunctional() Like a Boss

Now it's really easy to do the next step. If a `Ship` is under repair, I
don't want it to show up in this select menu. It's easy because we can just
call `isFunctional` and it will take care of all the internal stuff for us.
Down here we only want to print this out if the ship is in working order.
And the same thing down here:

[[[ code('ec8a5a82f9') ]]]

Cool! Refresh, all sunshines. Refresh again -- there's a cloud. It looks
like we're missing the Cloakshape Fighter due to repairs. And when you check
the list, it isn't there! Perfect!

## Adding Arguments to __construct

The `__construct()` function is something you are going to see a lot but
it's a really easy idea. It just says if you have a function called `__construct()`,
then it's automatically going to be called when you instantiate your object.

There is one other thing you can do: like most functions, it can have an
argument. Let's put a `$name` argument here:

[[[ code('99f80c0cbb') ]]]

I'm not going to use it yet because I'm going to show you what happens when
we do that. 

Go back to `functions.php`. You can see that my editor is angry because it
says required parameter `$name` missing:

[[[ code('8a7c7cd8c9') ]]]

So, you notice whenever we create a new `Ship` object, it's always `Ship()`,
but you never pass anything in there. When you create an object, the stuff
that goes in between the parenthesis are arguments that are passed to your
`__construct()` function, if you have one. Because we have a `$name` argument
here, now we need to pass a name there, just like that:

[[[ code('d63a0b3c31') ]]]

Now you can see that it is happy. 

And what we can do inside of `Ship.php` is say, ok whatever `$name` they
pass in, let's just set that to the `name` property:

[[[ code('a0b55f13d0') ]]]

In `functions.php`, we don't have to call `setName()` anymore: we're passing
it into the constructor and the name is being set that way. Let's update
the other ones as well:

[[[ code('8c6ea6bc73') ]]]

And we're good to go!

### When to Pass Values to __construct

So, why would you do this? Why would you add a `$name` argument to the Ship's
constructor and force it to be passed in versus the setter? It's really up
to you. In our case, it doesn't make sense to have a `Ship` without a name.
And before, that would have been possible had we just instantiated a new
`Ship` and forgotten to call `setName()`. Then we would have been running
around with a `Ship` object that had absolutely no name. How embarrasing.

Sometimes, when you have required information, you might choose to set them
up as arguments to your constructor. It says "Hey, when you create a `Ship`,
you have to pass me a name." We're not forcing the user to pass a `weaponPower`,
`jediFactor` or `strength`, because those all have a nice default value of
0. So it makes sense not to force those, but we do force the name.

When you back up I just want you to realize that the `__construct` function
is just like any other function. But if you give it that special name, it
is automatically called and the arguments are passed to it.

And guess what! You just learned the fundamentals of object-oriented programming.
Classes, check! Objects, super check! Methods, privacy, type-hinting, constructor
and other stuff - all old news now. And there's even more great stuff to
learn, like service classes, dependency injection, inheritance and interfaces.
These will make you even more dangerous, and will also help you understand
the outside libraries you use everyday. So keep going, and join us for episode
2.

Seeya next time!
