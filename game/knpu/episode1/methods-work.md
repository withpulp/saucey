# Methods that Do work

Our two methods are simple. So now let's add something useful. We'll be printing
out the details of our ships all over the place, so I need a way to see the
`weaponPower`, the `strength` and the `jediFactor` all at once - like a little
summary. One handy way to do this is with a new method that creates that
summary string and returns it to us.

Make a new function `getNameAndSpecs()`. Let's use the nice `sprintf` function
with %s wildcards for the ship's name, followed by the `weaponPower`, `jediFactor`
and `strength`. Now, we need to pass it what to fill in for those `%s` placeholders.
To reference the name, use the magic `$this` variable: `$this->name`. Do
the same thing for `weaponPower`, `jediFactor` and `strength`:

[[[ code('d4492fb84f') ]]]

And of course, make sure you have a `return` statement in front of all of
this! Let's enjoy our hard work by echo'ing the method below: `$myShip`,
arrow, `getNameAndSpecs` then the open and close parenthesis so PHP knows
this is a method, not a property by that name.

[[[ code('d35f89acb5') ]]]

Ready to try it? Refresh! There's our weird-little summary. We can use this
across our app, and if we ever want to change how it looks, we only need
to update one spot.

### Method Arguments

Being PHP pro's, we of course know that functions can have arguments. Once
again, a method in a class is no different. Isn't that nice? Let's say that
sometimes we need an even *shorter* summary. Add an argument to the method
called `$useShortFormat`. Now, use an `if` statement to choose between two
different formats:

[[[ code('399e4c4de4') ]]]

We'll just take out the w, j and s and put slashes instead. Cool! Now my
editor is angry because `getNameAndSpecs()` requires an argument. So pass
`false` when we call it, then call it again and use `true`.

[[[ code('927f010e83') ]]]

Refresh, Perfect!
