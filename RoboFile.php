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
        $this->taskExec('npm install phantomjs')
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

        //Make directory for ADSCR726
        $this->taskExec('mkdir reports/ADSCR726/')
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
        $this->taskExec(' /usr/local/bin/phantomjs --webdriver=8643')
            ->run();
    }

    public function test()
    {
        //Start server in background
        $this->taskServer(9987)
            ->dir('app')
            ->host('127.0.0.1')
            ->background()
            ->run();

        //Start Selenium
        $this->taskExec('sh ./run/start_selenium.sh')
            ->arg('mac')
            ->background()
            ->idleTimeout(10)
            ->run();

        //Starts Weinre for mac in background, @http://127.0.0.1:7890
        $this->taskExec('weinre --boundHost 127.0.0.1 --httpPort 7890')
            ->background()
            ->idleTimeout(10)
            ->run();

        //Starts tests in parallel
        $this->taskParallelExec()
            ->process('./bin/behat --tags "@metrics" -p local_chrome')
            ->process('./bin/behat --tags "@initial"  -p local_chrome')
            ->idleTimeout(10)
            ->run();

        //Copy and move over report
        $this->taskExec('mv ./reports/saucey_report.html ./reports/saucey_report_basic_test.html && open ./reports/saucey_report_basic_test.html')
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

    public function sauceyDrunk($envBrowser)
    {
        //Starts behat with $tags $browser
        $this->taskExec('sh ./run/saucey.sh drunk')
            ->args($envBrowser)
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
            ->commit('robo saucey:work is shoving to all remote:master:framework')
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
            ->commit('robo saucey:wiki is shoving to all remote:master:wiki')
            ->push('origin', 'master')
            ->run();
    }

}