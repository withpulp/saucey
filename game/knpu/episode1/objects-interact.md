# Objects Interact

Since the goal of our app is to let two ship's fight each other, things
are getting interesting. For example, we could fight `$myShip` against `$otherShip`
and see who comes out as the winner.

But first, let's imagine we want to know whose strength is higher. Of course, 
we could just write an `if` statement down here and manually check `$myShip`'s 
strength against `$otherShip`.

But we could also add a new method inside of the `Ship` class itself. Let's
create a new method that'll tells us if one Ship's strength is greater than
anothers. We'll call it: `doesGivenShipHaveMoreStrength()`. And of course,
it needs a Ship object as an argument:

[[[ code('20a5ad9c35') ]]]

So just like with our `printShipSummary()` function, when we call this function,
we'll pass it a `Ship` object. What I want to do is compare the Ship object
being passed to whatever Ship object we're calling this method on. Before
I fill in the guts, I'll show you how we'll use it: if `$myShip->doesGivenShipHaveMoreStrength()`
and pass it `$otherShip`. This will tell us if `$otherShip` has more strength
than `$myShip` or not. If it does, we'll echo `$otherShip->name` has more
strength. Else, we'll print the same thing, but say `$myShip` has more strength.

[[[ code('13d2b9a47c') ]]]

Inside of the `doesGivenShipHaveMoreStrength()`, the magic `$this` will refer
to the `$myShip` object, the one whose name is `Jedi Starship`. So all we
need to do is return `$givenShip->strength` greater than my strength:

[[[ code('a0e8698a9d') ]]]

Ok, let's try it! When we refresh, we see that the Imperial Shuttle has more
strength. And that makes sense: the Imperial Shuttle has 50 compared with
0 for `$myShip`, because it's using the default value.

Let me add another separator and let's double-check to see if this is working
by setting the strength of `$myShip` to 100.

Ok, refresh now! Now the Jedi Starship is stronger. Undo that last change.

So how cool is this? Not only can we have multiple objects, but they can
interact with each other through methods like this one. I'll show you more
of this later.
