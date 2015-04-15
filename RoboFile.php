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
        // starts PHP server in background
        // $this->taskServer(8000)
        //    ->host('localhost')
        //    ->dir('game')
        //    ->run();
    }

    public function sauceyInit()
    {
        //Install the dependancies/requirements through composer
        $this->taskComposerInstall('./composer.phar')
            ->run();

        //Update the dependancies/requirements through composer
        $this->taskComposerUpdate('./composer.phar')
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
        $this->taskExec('cat ./run/saucey.txt')
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

        $this->taskExec('open ./reports/saucey_report.html')
            ->run();
    }


    public function sauceyDrunk($env)
    {
        //Starts behat with $tags $browser
        $this->taskExec('sh ./run/saucey.sh drunk')
            ->args($env)
            ->run();

        $this->taskExec('open ./reports/saucey_report.html')
            ->run();
    }


    public function sauceyPush($msg)
    {
        //Copy over development yaml
        $this->taskExec('cp -r ./behat.yml vendor/saucey/framework/ymls/behat.yml.master.dist')
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

        //Push to remote frameworks
        $this->taskGitStack()
            ->dir('./vendor/saucey/framework')
            ->add('-A')
            ->commit('robo saucey:work is shoving to all remote:masters:')
            ->push('origin', 'master')
            ->run();

        //Pull wiki
        $this->taskGitStack()
            ->dir('./saucey.wiki/')
            ->pull('origin', 'master')
            ->run();

        //Push wiki
        $this->taskGitStack()
            ->dir('./saucey.wiki/')
            ->add('-A')
            ->commit('robo saucey:wiki is shoving to all remote:masters:wikis')
            ->push('origin', 'master')
            ->run();

    }

}