# My Editor is Confused

But before we go on, we need to help my editor. It's confused. Inside `printShipSummary()`,
my editor doesn't seem to recognize the `sayHello()` method on `Ship`, it
thinks it doesn't exist. But down at the bottom of the file, when I call
`doesGivenShipHaveMoreStrength()`, it's not highlighted in yellow - that
means my editor *does* see that this method exists. So what gives? Why doesn't
it recognize the `sayHello()` function?

If you *just* look at the `printShipSummary()` function, all that my editor
knows is that we're passing in *some* argument called `$someShip`, but it
doesn't know *what* it is. Is it a string? A boolean? A `Ship` object? *We*
know that this will be a `Ship` object, because we're creating `Ship` objects
below and passing those as the argument. But our editor has no idea. And
for that reason, it doesn't know to look on the `Ship` class to see that there's
a `sayHello()` function.

You don't need to fix this, it's totally fine. But if you want to, you
can use PHP documentation to give your editor a little hint about what the
heck this `$someShip` variable is. By using this syntax, you can say this
this is a `Ship` object:

[[[ code('4dbf1dcbcc') ]]]

And as soon as I do that, those ugly yellow highlights go away, and I even
get auto-completion on new code I write.

As nice as this is, it makes no *functional* difference - your code isn't
behaving any different than before. This is *just* a "nice" thing you can
do to help you and your editor get along.
