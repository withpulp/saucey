<?php
/**
 * This is project's console commands configuration for Robo task runner.
 *
 * @see http://robo.li/
 */
class RoboFile extends \Robo\Tasks
{
    function hello($opt = ['silent|s' => false])
    {
        if (!$opt['silent']) $this->say("Hello, world");
    }

    public function serve()
    {
        //Starts app in background
        $this->taskServer(9987)
            ->host('127.0.0.1')
            ->dir('app')
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

        //Install wienre
        $this->taskExec('sudo npm -g install weinre')
            ->run();

        //Copy over master yaml
        $this->taskExec('cp -r ./vendor/saucey/framework/ymls/behat.yml.master.dist ./behat.yml')
            ->run();

        //Copy over bin
        $this->taskExec('cp -R ./vendor/saucey/framework/bin/ ./bin/')
            ->run();

        //Pull develop and master
        $this->taskGitStack()
            ->pull('origin', 'master')
            ->pull('origin', 'develop')
            ->run();

        //View saucey introduction
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

        //Opens http://127.0.0.1:7890
        $this->taskExec('open http://127.0.0.1:7890')
            ->run();
    }

    public function wineryTest()
    {
        //Start server in background
        $this->taskServer(9987)
            ->dir('app')
            ->background()
            ->run();

        //Start selenium
        $this->taskExec('sh ./run/start_selenium.sh')
            ->arg('mac')
            ->background()
            ->idleTimeout(10)
            ->run();

        //Starts Weinre for mac in background, @http://127.0.0.1:7890
        $this->taskParallelExec()
            ->process('weinre --verbose true --debug true --boundHost 127.0.0.1 --httpPort 7890')
            ->process('./bin/behat --tags "@metrics" -p local_chrome --rerun')
            ->process('./bin/behat --tags "@initial" -p local_chrome --rerun')
            ->process('./bin/behat --tags "@adcade"')
            ->idleTimeout(10)
            ->run();

        //Save report
        $this->taskExec("mv ./reports/saucey_report.html ./reports/saucey_report_winery_test.html && open ./reports/saucey_report_winery_test.html")
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

        //Starts Weinre for mac in background, @http://127.0.0.1:7890
        $this->taskParallelExec()
            ->process('weinre --verbose true --debug true --boundHost 127.0.0.1 --httpPort 7890')
            ->process('./bin/behat --tags "@metrics" -p local_chrome')
            ->process('./bin/behat --tags "@initial"  -p local_chrome')
            ->idleTimeout(10)
            ->run();

        //Copy and move over report
        $this->taskExec('mv ./reports/saucey_report.html ./reports/saucey_report_basic_test.html && open ./reports/saucey_report_basic_test.html')
            ->run();
    }

    public function sauceyTest()
    {
        //Starts Selenium for mac in background, with default to Firefox, can use Chrome & Safari with '-p local_chrome' and '-p local_safari' respectively
        $this->taskExec('sh ./run/start_selenium.sh mac')
            ->background()
            ->run();

        //Runs tag
        $this->taskExec('./bin/behat --tags @saucey')
            ->run();

        //Opens reports/saucey_report.html
        $this->taskExec('open ./reports/saucey_report.html')
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

    public function sauceyDrunk($env)
    {
        //Starts behat with $tags $browser
        $this->taskExec('sh ./run/saucey.sh drunk')
            ->args($env)
            ->run();

        //Opens reports/saucey_report.html
        $this->taskExec('open ./reports/saucey_report.html')
            ->run();
    }

    public function sauceyIo($msg)
    {
        //Copy over development yaml
        $this->taskExec('cp -r ./behat.yml vendor/saucey/framework/ymls/behat.yml.master.dist')
            ->run();

        //Push to remote frameworks
        $this->taskGitStack()
            ->dir('./vendor/saucey/framework')
            ->add('-A')
            ->commit('robo saucey:work is shoving to all remote:master:')
            ->push('origin', 'master')
            ->run();

        //Pull from remotes
        $this->taskGitStack()
            ->pull('origin', 'master')
            ->pull('origin', 'develop')
            ->run();

        //Push to remotes
        $this->taskGitStack()
            ->dir('.')
            ->add('-A')
            ->commit($msg)
            ->push('origin', 'develop')
            ->run();
    }

    public function sauceyFramework()
    {
        //Copy over development yaml
        $this->taskExec('cp -r ./behat.yml vendor/saucey/framework/ymls/behat.yml.master.dist')
            ->run();

        //Push to remote frameworks
        $this->taskGitStack()
            ->dir('./vendor/saucey/framework')
            ->add('-A')
            ->commit('robo saucey:work is shoving to all remote:master:')
            ->push('origin', 'master')
            ->run();
    }

    public function sauceyWiki()
    {
        //Pull wiki
        $this->taskGitStack()
            ->dir('./saucey.wiki/')
            ->pull('origin', 'master')
            ->run();

        //Push wiki
        $this->taskGitStack()
            ->dir('./saucey.wiki/')
            ->add('-A')
            ->commit('robo saucey:wiki is shoving to all remote:master:wiki')
            ->push('origin', 'master')
            ->run();
    }

    public function sauceyADSCR726()
    {
        //Starts Weinre for mac in background, @http://127.0.0.1:7890
        $this->taskParallelExec()
            ->process('weinre --verbose true --debug true --boundHost 127.0.0.1 --httpPort 7890')
            ->process('sh ./run/start_selenium.sh mac')
            ->process('./bin/behat --tags @adscr736Metrics -p local_chrome --rerun')
            ->process('./bin/behat --tags @adscr736')
            ->run();

        $t=time();

        //Opens reports/saucey_report.html
        $this->taskExec("mv ./reports/saucey_report.html ./reports/saucey_report_{$t}.html")
            ->run();
    }

}