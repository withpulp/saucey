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
        $this->taskServer(8000)
            ->host('localhost')
            ->dir('game')
            ->run();
    }

    public function sauceyTest()
    {
        // starts Selenium for mac in background
        $this->taskExec('./start_selenium mac')
            ->background()
            ->run();

        // runs Behat tests
        $this->taskExec('./bin/behat --tags @saucey')
            ->run();

        $this->taskExec('open ./reports/saucey_report.html');
    }

    public function sauceyInit()
    {
        // simple install
        $this->taskComposerInstall()->run();

        // simple update
        $this->taskComposerUpdate()->run();


        // cat saucey and copy over master yaml
        $this->taskExec(' cat run/saucey.txt && cp -r vendor/saucey/drivers/ymls/behat.yml.master.dist ./behat.yml')
            ->run();

        $this->taskGitStack()
            ->pull('origin', 'master')
            ->pull('sajjad', 'master')
            ->pull('saucey', 'master')
            ->pull('withpulp', 'master')
            ->pull('origin', 'develop')
            ->pull('sajjad', 'develop')
            ->pull('saucey', 'develop')
            ->pull('withpulp', 'develop')
            ->run();
    }

    public function sauceyWork()
    {
        // cat saucey and copy over develop yaml
        $this->taskExec('cp -r ./behat.yml vendor/saucey/drivers/ymls/behat.yml.master.dist')
            ->run();

        $this->taskGitStack()
            ->dir('.')
            ->add('-A')
            ->commit('robo saucey:work is shoving to all remote:develops')
            ->push('origin', 'develop')
            ->push('sajjad', 'develop')
            ->push('saucey', 'develop')
            ->push('withpulp', 'develop')
            ->run();

        // commit work to saucey/drivers
        $this->taskGitStack()
            ->dir('./vendor/saucey/drivers')
            ->add('-A')
            ->commit('robo saucey:work is shoving to all remote:develops') ->dir('./vendor/saucey/drivers/')
            ->push('sajjad', 'master')
            ->push('saucey', 'master')
            ->run();
    }

}