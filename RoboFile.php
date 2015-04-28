<?php
/**
 * This is project's console commands configuration for Robo task runner.
 *
 * @see http://robo.li/
 */
class RoboFile extends \Robo\Tasks
{
    function yo()
    {
        $this->taskExec('cat ./run/saucey.txt')
            ->run();
    }

    public function serve()
    {
        //Starts app/ in background
        $this->taskServer(9987)
            ->host('127.0.0.1')
            ->dir('get.saucey.io')
            ->run();

    }

    public function init()
    {
        //Install the dependancies/requirements through composer
        $this->taskComposerInstall('./composer.phar')
            ->run();

        //Update the dependancies/requirements through composer
        $this->taskComposerUpdate('./composer.phar')
            ->run();

        //Install Wienre
        $this->taskExec('sudo npm -g install weinre')
            ->run();

        //Install PhantomJS
        $this->taskExec('sudo npm -g install phantomjs')
            ->run();

        //Copy over master yaml
        $this->taskExec('cp -r ./vendor/saucey/framework/ymls/behat.yml.master.dist ./behat.yml')
            ->run();

        //Copy over bin
        $this->taskExec('cp -R ./vendor/saucey/framework/bin/* ./bin/')
            ->run();

        //Pull develop and master
        $this->taskGitStack()
            ->pull('origin', 'master')
            ->pull('origin', 'develop')
            ->run();

        //Make directory for reports
        $this->taskExec('mkdir reports/')
            ->run();

        //View saucey introduction
        $this->taskExec('cat ./run/saucey.txt')
            ->run();
    }

    public function winery()
    {
        //Starts Weinre for mac in background, @http://127.0.0.1:7890
        $this->taskExec('weinre --verbose true --debug true --boundHost 127.0.0.1 --httpPort 7890')
            ->run();
    }

    public function selenium()
    {
        //Starts Selenium for mac
        $this->taskExec('sh ./run/start_selenium.sh')
            ->arg('mac')
            ->run();
    }

    public function phantom()
    {
        //Starts PhantomJS for mac
        $this->taskExec('/usr/local/bin/phantomjs --webdriver=8643')
            ->run();
    }

    public function sauce()
    {
        $feature = $this->ask("What is the name of your feature?");

        //Start Selenium
        $this->taskExec(mkdir('./features'))
            ->arg('mac')
            ->background()
            ->idleTimeout(10)
            ->run();

    }

    public function tipsyTest()
    {
        $feature = $this->ask("What is the '@tag' for feature? [string]");
        $browser = $this->ask("Which browser is this to be test this in? [string]");
        $isMetrics = $this->ask("Is metrics testing involved? [y/n]");


        //Start server in background
        $this->taskServer(9987)
            ->dir('./apps/get.saucey.io')
            ->host('127.0.0.1')
            ->background()
            ->run();

        //Starts Selenium, tests in parallel
        if ($isMetrics == 'y') {
            $metrics = $this->ask("What is the '@tag' for metrics? [string]");
            $this->taskParallelExec()
                //->process('sh ./run/start_selenium.sh mac')
                ->process('weinre --boundHost 127.0.0.1 --httpPort 7890')
                ->process("./run/saucey.sh tipsy '{$metrics} chrome'")
                ->process("./run/saucey.sh tipsy '{$feature} {$browser}'")
                ->idleTimeout(10)
                ->run();

            $this->taskExec("mv ./reports/saucey_report.html ./reports/saucey_report_{$feature}.html && open ./reports/saucey_report_{$feature}.html")
                ->idleTimeout(10)
                ->run();

        }

        if ($isMetrics == 'n') {
            $this->taskParallelExec()
                //->process('sh ./run/start_selenium.sh mac')
                ->process("./run/saucey.sh tipsy '{$feature} {$browser}'")
                ->idleTimeout(10)
                ->run();

            $this->taskExec("mv ./reports/saucey_report.html ./reports/saucey_report_{$feature}.html && open ./reports/saucey_report_{$feature}.html")
                ->idleTimeout(10)
                ->run();

            $this->taskExec("curl -X GET 'http://localhost:4444/selenium-server/driver/?cmd=shutDownSeleniumServer'")
                ->run();

        }
    }

    public function sauceyConnect()
    {
        $un = $this->ask("What is your username?");
        $key = $this->ask("What is your api-key?");
        $unkey = "{$un}:{$key}";
        $un_key = "{$un} {$key}";

        $this->taskReplaceInFile('./vendor/saucey/framework/ymls/behat.yml.master.dist')
            ->from('username:api-key')
            ->to($unkey)
            ->run();

        $this->taskReplaceInFile('./behat.yml')
            ->from('username:api-key')
            ->to($unkey)
            ->run();

        $this->taskExec('./bin/sauce_config')
            ->arg($un_key)
            ->run();
    }


    public function sauceyTunnel()
    {
        $un = $this->ask("What is your username?");
        $key = $this->ask("What is your api-key?");
        $un_key = "{$un} {$key}";

        $this->taskExec('./vendor/sauce/connect/bin/sauce_connect')
            ->arg($un_key)
            ->run();
    }

    public function sauceyTipsy($browser)
    {
        //Starts Selenium for mac in background, with default to Firefox, can use Chrome & Safari with '-p local_chrome' and '-p local_safari' respectively
        $this->taskExec('sh ./run/start_selenium.sh mac')
            ->background()
            ->run();

        //Starts behat with $tags $browser
        $this->taskExec('sh ./run/saucey.sh tipsy')
            ->args($browser)
            ->run();

        //Opens reports/saucey_report.html
        $this->taskExec('open ./reports/saucey_report.html')
            ->run();
    }

    public function sauceyDrunk($environment)
    {
        //Starts behat with $tags $browser
        $this->taskExec('sh ./run/saucey.sh drunk')
            ->args($environment)
            ->run();

        //Opens reports/saucey_report.html
        $this->taskExec('open ./reports/saucey_report.html')
            ->run();
    }

    public function sauceyShove($msg)
    {
        //Copy over development yaml
        $this->taskExec('cp -r ./behat.yml vendor/saucey/framework/ymls/behat.yml.master.dist')
            ->run();

        //Push to remote for framework
        $this->taskGitStack()
            ->dir('./vendor/saucey/framework')
            ->add('-A')
            ->commit($msg)
            ->push('origin', 'master')
            ->run();

        //Pull from remotes for saucey
        $this->taskGitStack()
            ->dir('.')
            ->pull('origin', 'master')
            ->pull('origin', 'develop')
            ->run();

        //Push to remotes for saucey
        $this->taskGitStack()
            ->dir('.')
            ->add('-A')
            ->commit($msg)
            ->push('origin', 'develop')
            ->run();

        //Pull from remotes for wiki
        $this->taskGitStack()
            ->dir('./saucey.wiki')
            ->pull('origin', 'master')
            ->run();

        //Push to remotes for wiki
        $this->taskGitStack()
            ->dir('./saucey.wiki')
            ->add('-A')
            ->commit($msg)
            ->push('origin', 'master')
            ->run();

        $this->taskExec('cp -R ./saucey.wiki ./docs/github/')
            ->run();
    }

}