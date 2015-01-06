sauce-connect-composer
======================

A Composer Package for Sauce Connect.

Sauce Connect is a special tunnel-creating binary application (see the [Sauce
Connect Docs](http://saucelabs.com/docs/connect)). It is bundled as a
composer package (`sauce/connect`), designed to accompany
[Sausage](http://github.com/jlipps/sausage) (`sauce/sausage`), which you can
add to your `composer.json` requirements:

```json
{
  "require": {
    "sauce/sausage": ">=0.6",
    "sauce/connect": ">=3.0"
  }
}
```

If you've already run `vendor/bin/sauce_config` or otherwise set your Sauce
credentials, starting sauce connect is as easy as:

    vendor/bin/sauce_connect

Or on Windows:

    vendor\bin\sauce_connect.bat

The script will start up the Sauce Connect Java binary behind the scenes. As
it's starting you'll see various messages letting you know the status of the
startup process (it usually takes about a minute). Once Sauce Connect is ready
to go, you'll get a prompt that allows you to hit enter to see more log
messages from the running Sauce Connect binary, or type 'q' and hit enter to
shut down the secure tunnel.

You'll be testing against your local test server in no time!
