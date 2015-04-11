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

    public function test()
    {
        // starts PHP server in background
        $this->taskServer(8000)
            ->host('localhost')
            ->background()
            ->dir('game')
            ->run();

        // starts Selenium for mac in background
        $this->taskExec('./start_selenium mac')
            ->background()
            ->run();

        // runs Behat tests
        $this->taskExec('./bin/behat --tags @start')
            ->run();

        // runs Behat tests
        $this->taskExec('./bin/behat --tags @play')
            ->run();

    }

}