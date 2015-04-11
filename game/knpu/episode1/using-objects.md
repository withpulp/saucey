# Using Objects

This `play.php` file is cute, but it's not our real application. we *did* make 
this nice `Ship` class, so let's use. It'll clean up our code and give us more 
power. Sounds good to me!

## Moving Ship into Ship.php

But first, the `Ship` class lives inside `play.php`, and this is just a garbage
file we won't use anymore. Usually, a class will live all alone in its own
file. Create a `lib/` directory, and a file called `Ship.php`. There's no
technical reason why I called the directory `lib/`, it just sounds nice. And
the same goes for the filename - we could call it anything. But to keep my
sanity, putting the `Ship` class inside `Ship.php` makes a lot more sense
than putting it inside of a file called `ThereIsDefinitelyNotAShipClassInHere.php`.
So even though nothing technical forces us to do this, put one class per file,
and then go celebrate how clean things look.

Go copy the `Ship` class, and put it into `Ship.php`:

[[[ code('4656a7ab2e') ]]]

Don't put a closing PHP tag, because you don't need it. PHP will reach the
end of the file, and close it automatically.

I'll head back to `play.php`, just like when you have functions in an external
file you have to require that file to have access to it. So we'll
`require once __DIR__'/lib/Ship.php'`:

[[[ code('93530591f0') ]]]

The `__DIR__` is a constant that points to this directory. So this makes
sure that we're requiring exactly `/lib/Ship.php` relative to this file.

### Get rid of requires?

If you're familiar with modern apps you'll notice that they don't have this 
`require` statement, we'll talk about that in the future. There is a way called
`autoloading` to not even need require statements. But for now we do need it.

So now that we've moved that out let's refresh. Well look at that, it still works!

## Creating Ship Objects... for Real

So now that we have this `Ship` class inside of a `Ship.php` file we can
start using it from within our real application. From our `get_ships()` function,
I don't want to return this array inside of an array thing anymore. I want
to do awesome things like return objects.

We'll start with adding our require statement:

[[[ code('41506ec9ea') ]]]

Next, let's transform our brave starfighter into a `Ship` object. We do that
with `$ship = new Ship();` and then we'll just start setting the details:
`name = 'Jedi Starfighter'`, `weaponPower` of 5, `jediFactor` of 15 and
`strength` of 30:

[[[ code('535275f541') ]]]

Perfect!

I'm commenting out this bottom array, we're not going to use that at all anymore.
Instead we're going to return an array with just this one ship in it, we'll add
more to our fleet later.

Remember, we're calling this back in `index.php`, in that file we call `get_ships();`
that *use* to return an array of ship arrays. Now it returns an array of
`Ship` objects, of which there will only be the one starfighter. Let's `var_dump`
this to see what it looks like:

[[[ code('2ef30eecbb') ]]]

Take off the file name, so we load `index.php`:

    http://localhost:8000

And there it is! We have an array with one item in it which is our `Ship`
object. Look at those sweet spaceship stats.

## Treat that Object like an Object (->)

Let's take that `var_dump` off and see what that does to our app. When we
refresh we see an exciting error that tells us we cannot use object of type
`Ship` as array on line 68. This is an error that you might see, so let's
see what's happening on line 68:

[[[ code('8e3d803be4') ]]]

Ok, we're using `$ship['name']`. Before when each ship was an array, that
made sense, now we know when you reference an object you need to use an arrow.
So if you do have an object and you try to use the square bracket syntax
that is the error that you will see. Lucky you!

I don't want to keep seeing errors so let's fix the other ones as well:

[[[ code('2c8bfb5944') ]]]

Awesome!

Head back to the browser and refresh and things are looking kinda better!
Sweet! Well, at least we have a different fatal error in our dropdown here,
cannot use object of type `Ship` as array, we'll fix that in a second. 

Back in our editor, because this is an object we can use our methods on it.
In our `Ship` class we have this `getName()` method:

[[[ code('fac062048c') ]]]

Down here let's switch out name for `getName();`

[[[ code('7c439f7297') ]]]

When we refresh, we see it does the exact same thing.

Now, let's fix this little error we have in the select menu. In `index.php`
you can see it's the same thing as before, we're using the `$ship` like an
array, so change this to use `getName();` here and down there as well:

[[[ code('14f6add05e') ]]]

Refresh, and now things look just fine!

We have this `getNameAndSpecs()` function, so perhaps when I'm choosing a
ship I might want to see its important stats since I'm going to use it to
save the day:

[[[ code('eb6accfb4e') ]]]

So instead of `getName()` I'll use `getNameAndSpecs()`. First, I'm going
to make the short format an optional argument so we don't always have to
fill that in:

[[[ code('a6366d6443') ]]]

Let's make these updates in `index.php` and now refresh the browser:

[[[ code('2a903d1397') ]]]

We see our specs format in the select menu -- cool! 

And that's it, switching to an object is not that big of a deal. Next we'll
talk about what these public things in `Ship` are doing inside of here and
what else we can have.
