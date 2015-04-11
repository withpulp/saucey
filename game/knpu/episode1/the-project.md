# The Project

Welcome KnpU Peeps! I am *so* glad you're here today - I am *not* kidding -
because we're intro'ing into one of my absolute favorite topics: object-oriented
programming. This is what gets me up in the morning, excited to go to work,
this is why I love to code. And I hope, you'll be as geeked about these
new tools as I am.

Like always, we're going to learn this stuff by building a real app! Don't
be lazy - code along with me to really get the feel for this stuff. Go to
the screencast page and click to download the code. Unzip that file - you'll
see a "start" directory. I'll rename this to `oo` and move it into a `Sites/`
directory in my Home folder.

There's not much going on yet guys - just 3 PHP files and some CSS and JS
files. That's it. Let's take the app for a test drive!

You can of course use a web server like Apache and setup a Virtual Host,
but I perfer the built-in PHP web server. Open up a terminal. Move into the
`oo` directory. From here, to start the built-in web server you can call
php with the `-S` option and pass it an address:

```
cd ~/Sites/oo
php -S localhost:8000
```

It'll hang there, and that means it's working: we instantly have a web server
at the address that's serving from our directory. Let's go to the browser
and try it out:

    http://localhost:8000

Voilà! Welcome to OO Battleships of Space! This awesome app does one
important thing: it lets you fight one ship against another. We have 4 ships,
each has a "weapon power", which is your offense, "strength", which is your
defense and "Jedi Factor". This last one randomly causes one ship to go all
"Luke-Skywalker" on another and and destroy it instantly.

Ok, let's put 4 "Jedi Starfighters" against 1 giant "Super Star Destroyer".
A Super Star Destroyer is a lot more powerful, so it'll probably win.

Stunning upset! The Jedi Starfighters won! Probably they used their Jedi
ways to find some crazy weakness. Of course, we can go back and do a re-match:
4 Jedi Starfighters against another Super Star Destroyer, and now the Destroyer
wins.

How the App Works
-----------------

Behind this, we have exactly 3 PHP files. First is `index.php`, which is
the homepage. It requires `functions.php` and calls `get_ships()` from it:

[[[ code('6f6a8a9827') ]]]

All that does is create this nice associative array of 4 ships. Each has
`name`, `weapon_power`, `jedi_factor` and `strength` keys:

[[[ code('f57d724456') ]]]

Back in `index.php`, we use those below in a `foreach` to create a table:

[[[ code('6c01d3bc34') ]]]

And we use it again to create the options in the select drop-downs:

[[[ code('cf4918d2cc') ]]]

When we submit, it POST's to `battle.php`. That *also* calls `get_ships()`,
reads some `$_POST` data to figure out which ships are fighting and how many,
and eventually calls a `battle()` function that finds the winnner. I'll show
you that later:

[[[ code('a9013ff5cf') ]]]

Then we use that `$outcome` to show a status report below:

[[[ code('32bd888ea1') ]]]

There's our app! It's got no object-oriented code yet. And you know what?
That makes me sad. Time to fix it!
