# Type Hinting?!

When we submit the form it goes to `battle.php` and we see this nasty error:

    Argument 1 passed to battle() must be of the type array, object given

It comes from `functions.php` on line 74 and called on `battle.php` on line
29. Let's start with `battle.php`, sure enough we can see the problem is
with the battle function, let me show you why. But first, let's dump `$ship1`
and `$ship2`:

[[[ code('dab7435f40') ]]]

Let's see here, up top we call `getShips()` which returns an array of objects.
Then we read the `$_POST` data to figure out which two ships are fighting. 
Then, down here, we get the ship objects off this array:

[[[ code('0f49f0a977') ]]]

So this should dump two objects. And it does: we have the Jedi Starfighter
and the Super Star Destroyer. 

## What is Type-Hinting?

Next, let's look in the `battle()` function which lives in `functions.php`:

[[[ code('05529d0890') ]]]

Here's the issue the `$ship1` and `$ship2` arguments have "array" in front
of them. This tells PHP that this argument must be an array and if someone
passes something other than an array, I want you to throw a huge error. So
let's see that error again, it says:

    Argument 1 passed to battle() must be of the type array, object given

since we're passing it a ship object. This is called a type hint and the
only purpose of a type hint in PHP is to get better errors: it doesn't change
the behavior. We can just take the type hint off like this and that will
fix the error:

[[[ code('026294638c') ]]]

And down here, knowing that `$ship1` is actually an object, instead of using
the array syntax we can call the `getStrength()` method. Let's go ahead and
dump `$ship1Health` to make sure it's working:

[[[ code('5f39230a17') ]]]

Just by removing the type hint it tells PHP to stop making sure it's an array,
just let anything in and be ok with it. Refresh! This time it's printing
out 60 which means it's printing out the ship's mighty strength correctly.

## Type-Hinting Saves your Butt

The type hint is a useful thing, not from a functionality standpoint, but
for knowing when you're doing something wrong. Let's go back to `battle.php`
and pretend that something went wrong here by changing our object `$ship1`
to the string `foo`:

[[[ code('365639b046') ]]]

When we refresh this time, we get this really weird error:

    Call to a member function getStrength() on a non-object

You're going to see this error a lot and it's coming from line 76:

[[[ code('5f39230a17') ]]]

It happens whenever you use the arrow syntax on something that isn't an object.
It's a fatal error and PHP just dies immediately. We know because I just
passed `foo`, that `$ship1` is no longer an object, it's just a string. And
when we call this on it, everything dies. The issue is that from the error
message, it isn't exactly clear where the mistake is. It's telling us that
the problem is on line 76 in `functions.php`. And sure, that is where the
error occurred. But the real problem is in `battle.php` where we are passing
in a bad value to the `battle()` function. 

## Type-Hinting with a Class

So in addition to type-hinting with the array, when we use objects we can
type hint with the class name. This means we can actually type `Ship` here
and we can do that here as well:

[[[ code('9a7a782809') ]]]

That is the exact same thing. It says, "Hey, PHP, if something is passed
to this argument that's not a `Ship` objec, I want you to throw a very clear
error." So let's go see this new error! Refresh and there it is:

    Argument 1 passed to battle() must be an instance of Ship, string given
    on line 29 `battle.php`

This time it's very clear: it says it should have been a `Ship` object, but
you're passing a string and it points us to the exact right spot. So type-hinting
is optional, but it's a really good idea because it will make your code easier
to debug later. It also has a second benefit: as soon as I type hinted this
`$ship1` variable here, all of a sudden my editor knew what type of object
`$ship1` was and offered me autocomplete. So it knows about `getStrength()`
and all the other methods on that object. 

Now that we know that these are objects, let's fix this method for all the array
syntaxes. Let's see here we have a few more:

[[[ code('532d77ff4d') ]]]

And then down here, which is called from above we have one more:

[[[ code('504dd3b30a') ]]]

And notice that this one is not giving me autocomplete because it's being
type hinted as an array. This function is called all the way up here, it's
passing a `$ship1` and `$ship2`, so it's passing a ship object:

[[[ code('edddddc838') ]]]

Let's change that type hint to be a `Ship` instead of an `array`:

[[[ code('8f59010991') ]]]

And now we will get that nice autocompletion which will make sure the object
is being passed there. Awesome, this function looks good!

Let's go back and refresh. And of course I get that same error because I forgot
to go back and put `$ship1` here:

[[[ code('a8c146f257') ]]]

## Fixing the Objects inside $outcome

Let's try that again. We still get an error, but if you look closely you'll
see that it is happening farther down the page. The battle function is being
called  and it's all working. This new error is from line 61, at this point
you can probably even spot what that is:

    Cannot use object of type Ship as an array

That's another syntax thing that we need to change.

So, let's go down to line 61 and sure enough there it is:

[[[ code('424bcf4f66') ]]]

We'll call `getName()` on our `$ship1` and `$ship2` objects:

[[[ code('040dbe5506') ]]]

Now, real quick back up on `battle()`, what it returns is this `$outcome`
variable, and I'm going to show you what that actually is. Down here, let's
do a `var_dump()` on `$outcome`, put a `die` statement and refresh:

[[[ code('59705d262e') ]]]

So the `battle()` function returns an array with three different keys on
it: `winning_ship` which is a `Ship` object, `losing_ship` which is a `Ship`
object and whether or not Jedi powers were used to have a really awesome
comeback win (`used_jedi_powers`).

The important part is that `winning_ship` and `losing_ship` are `Ship` objects.
Let's just remove this `var_dump` real quick. Down here, when we reference
`$outcome['winning_ship']` we know that this is an object:

[[[ code('c645790e00') ]]]

And we want to call `getName()` on it. The same thing here. And then we'll 
do the same thing here as well:

[[[ code('d041417df0') ]]]

We're converting from that array syntax to the object syntax. 

Moment of truth, do we have a working battle page? SUCCESS! Super Star Destoyer
won. Let's try it again. We'll throw 10 Jedi Star Ships at our one Super
Star Destroyer and it wins again. Come one Jedi's get it together! If you
try enough times the Jedis do come out with a victory.

The key take away here is because we have a `Ship` class, when we have a
`Ship` object, we know exactly what we can do with it. This is cool because
whenever we pass around a `Ship`, object we can type hint it with `Ship`
and our editor instantly knows what that is and what methods we can call
on it. We're giving definition to our data instead of passing around arrays
which have unknown and probably inconsistent keys. 
