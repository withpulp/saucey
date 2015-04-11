# Multiple Objects

This object-oriented, or OO, stuff gets *really* fun once we have multiple
objects. Afterall, it takes at least 2 ships to start a battle.

But first, let's summarize all of this printing stuff into a normal, traditional,
flat function called `printShipSummary()`. It'll take in a `Ship` object
as an argument, which I'll call `$someShip`. Now, copy all the echo stuff
into the function.

The argument to the function could be called anything. Since I chose to call
it `$someShip`, all of the `$myShip` variables below need to be updated to
`$someShip` also. This is just classic behavior of functions - nothing special.
I'll use a trick in my editor:

[[[ code('eaa832b8ec') ]]]

Ok, saving time!

Back at the bottom of the file, call this like any traditional function, and
pass it the `$myShip` variable, which we know is a `Ship` object:

[[[ code('bd04dc10b9') ]]]

So we're throwing around some objects, but this is just normal, flat, procedural
programming. When we refresh it's exactly the same.

## Create Another Ship

Now, to the good stuff! Let's create a *second* Ship object. The first is
called `Jedi Starship` and has 10 `weaponPower`. Let's create `$otherShip`.
And just like if 2 ships landed in your dock, one will have one name, and 
another will be named something different. Let's call this one: Imperial Shuttle.
Set its `weaponPower` to 5 and a strength of 50:

[[[ code('bebb12f475') ]]]

These two separate objects both have data inside of them, but they function
indepedently. The only thing they share is that they're both `Ship` objects,
which means that they both share the same rules: that they have these 4 properties
and these 3 methods. But the property *values* will be totally different between
the two.

This means that we can print the second Ship's summary and see its specs:

[[[ code('a3a91e5e96') ]]]

Now we get a print-out of two independent Ships where each has different
data.
