<?php
/**
 * This is project's console commands configuration for Robo task runner.
 *
 * @see http://robo.li/
 */

use Robo\Common\TaskIO;
use Robo\Output;

class RoboFile extends \Robo\Tasks
{
    /**
     * Displays the introduction, more information and welcome ascii art
     */
    function info()
    {
        //Cat run/saucey.txt
        $this->taskExec('cat ./run/saucey.txt')
            ->run();
    }

    /**
     * Starts apps/get.saucey.io in foreground at http://127.0.0.1:9987, kill with 'Control + C'
     *
     * @param string $app Directory from apps/ to serve
     */
    public function serve($app)
    {
        //Serve app/$app
        $this->taskServer(9987)
            ->host('127.0.0.1')
            ->dir("./apps/{$app}")
            ->run();
    }

    /**
     * Initializes saucey project via Composer install/update, npm global installs, and copying over behat.yml from vendor/saucey/framework
     */
    public function init()
    {
        //Install the dependancies/requirements through composer
        $this->taskComposerInstall('./composer.phar')
            ->run();

        //Update the dependancies/requirements through composer
        $this->taskComposerUpdate('./composer.phar')
            ->run();

        //Install Wienre globally via npm
        $this->taskExec('sudo npm -g install weinre')
            ->run();

        //Install PhantomJS globally via npm
        $this->taskExec('sudo npm -g install phantomjs')
            ->run();

        //Copy over behat.yml.master.dist to root as behat.yml
        $this->taskExec('cp -r ./vendor/saucey/framework/ymls/behat.yml.master.dist ./behat.yml')
            ->run();

        //Copy over bin from vendor/saucey/framework
        $this->taskExec('cp -R ./vendor/saucey/framework/bin/* ./bin/')
            ->run();

        //Pull develop and master
        $this->taskGitStack()
            ->pull('origin', 'master')
            ->pull('origin', 'develop')
            ->run();

        //Make directory for reports
        $this->taskFileSystemStack()
            ->mkdir('reports')
            ->run();

        //View saucey introduction
        $this->taskExec('cat ./run/saucey.txt')
            ->run();
    }

    /**
     * Runs Composer update, refreshes bin/ and vendor/
     */
    public function update()
    {
        //Update the dependancies/requirements through composer
        $this->taskComposerUpdate('./composer.phar')
            ->run();

    }

    /**
     * Starts Winery (Weinre) in foreground, at $host $port
     */
    public function winery()
    {
        $host = $this->ask('What host?');
        $port = $this->ask('What port?');
        //Starts winery (weinre) in foreground, at $host $port
        $this->taskExec("weinre --verbose true --debug true --boundHost {$host} --httpPort {$port}")
            ->run();
    }

    /**
     * Starts Selenium for mac in foreground, at default http://localhost:4444/wd/hub/static/resource/hub.html
     */
    public function seleniumStart()
    {
        //Starts Selenium
        $this->taskExec('sh ./run/start_selenium.sh')
            ->arg('mac')
            ->run();
    }

    /**
     * Kills Selenium at default http://localhost:4444/wd/hub/static/resource/hub.html
     */
    public function seleniumKill()
    {
        //Kills Selenium
        $this->taskExec("open http://localhost:4444/selenium-server/driver/?cmd=shutDownSeleniumServer")
            ->background()
            ->run();
    }

    /**
     * Starts PhantomJS for mac in foreground, at default http://localhost:4444/wd/hub/static/resource/hub.html
     *
     * * @param int $port Port for PhantomJS
     */
    public function phantomjs($port)
    {
        //Starts PhantomJS for mac
        $this->taskExec("/usr/local/bin/phantomjs --webdriver={$port}")
            ->run();
    }


    /**
     * Asks for and obtains $folder, $project, $feature, and $shortName. Makes directories, copies and touches files.
     *
     * @internal param string $folder
     * @internal param string $project
     * @internal param string $feature
     * @internal param string $robo
     */
    public function sauceyBundle()
    {
        /**
         * @var string $folder
         */
        $folder = $this->ask("Which folder will this test(s) reside in? [string]");
        /**
         * @var string $project
         */
        $project = $this->ask("What is the name of the project? [string]");
        /**
         * @var string $feature
         */
        $feature = $this->ask("What is the name of the feature file? [string]");
        /**
         * @var string $shortName
         */
        $shortName = $this->ask("What is the short name for your robo function? [string]");

        //Makes directories in feature/ and touches feature file
        $this->taskFileSystemStack()
            ->mkdir("./features/{$folder}")
            ->mkdir("./features/{$folder}/{$project}")
            ->mkdir("./reports/{$folder}/{$project}")
            ->touch("./features/{$folder}/{$project}/{$feature}.feature")
            ->run();

        //Copies over Reporting/Run scripts
        $this->taskExec("sleep 10 && cp -R ./config/ ./features/{$folder}/{$project}/")
            ->run();

        //Removes Services
        $this->taskExec("rm -rf ./features/{$folder}/{$project}/service.json")
            ->run();

        //Replaces items in Reporting.php
        $this->taskReplaceInFile("./features/{$folder}/{$project}/Reporting.php")
            ->from('project')
            ->to($project)
            ->from('feature')
            ->to($feature)
            ->run();

        //Replaces items in Run.sh
        $this->taskReplaceInFile("./features/{$folder}/{$project}/Run.sh")
            ->from('function')
            ->to($shortName)
            ->run();
    }

    /**
     * Asks for and obtains $project, $feature, and $number to update the Run.sh in feature directory. INIT, initializes script. RUN, runs script.
     *
     * @internal param string $folder
     * @internal param string $project
     * @internal param string $feature
     * @internal param string $number
     */
    public function sauceyOverdose()
    {
        $action = $this->ask("Would you like to init or run overdose? You have to init before running! [init | run]");
        $folder = $this->ask("Which folder does the test live in? [string]");
        $project = $this->ask("Which project? [string]");
        $number = $this->ask("How many times do you want to run this test? [int]");

        if ($action == 'init') {
            //Replaces number value in Run.sh
            $this->taskReplaceInFile("./features/{$folder}/{$project}/Run.sh")
                ->from('((n=0;n<1;n++))')
                ->to("((n=0;n<{$number};n++))")
                ->run();
        }
        if ($action == 'run') {
            $confirm = $this->ask("Are you sure you want to run your suite {$number} times? [y | n]");
            if ($confirm == 'y') {
                //Confirm then run
                $this->taskExec("sh ./features/{$folder}/{$project}/Run.sh")
                    ->run();
            }
            if ($confirm == 'n') {
                //Confirm
                $this->taskExec("exit")
                    ->run();
            }

        }
    }

    /**
     * Asks and obtains $project, $feature, $browser and $isMetrics status to run Behat, Reporting, Weinre, Selenium and PhantomJS
     *
     * @internal param string $folder
     * @internal param string $project
     * @internal param string $feature
     * @internal param string $isMetrics
     */
    public function tipsyTest()
    {
        $project = $this->ask("What is the name of the parent folder in which this test resides? [string]");
        $feature = $this->ask("What is the '@tag' for feature? [string -- without '@']");
        $browser = $this->ask("Which browser is this to be test this in? [string]");
        $isMetrics = $this->ask("Is metrics testing involved? [y | n]");

        //Starts PhantomJS
        $this->taskExec("/usr/local/bin/phantomjs --webdriver=8643")
            ->background()
            ->run();

        //Starts Selenium
        $this->taskExec("sh ./run/start_selenium.sh mac")
            ->background()
            ->run();

        //Starts drivers, tests in parallel
        if ($isMetrics == 'y') {
            $metrics = $this->ask("What is the '@tag' for metrics? [string]");
            $host = $this->ask("What host? [string]");
            $port = $this->ask("What port? [string]");

            //Starts Winery
            $this->taskExec("weinre --verbose true --debug true --boundHost {$host} --httpPort {$port}")
                ->background()
                ->run();

            //Starts tests in parallel
            $this->taskParallelExec()
                ->process("sh ./run/saucey.sh tipsy '{$metrics} chrome'")
                ->process("sh ./run/saucey.sh tipsy '{$feature} {$browser}'")
                ->idleTimeout(10)
                ->run();

            $this->taskExec("open http://localhost:4444/selenium-server/driver/?cmd=shutDownSeleniumServer")
                ->background()
                ->run();

            $this->taskExec("mv ./reports/saucey_report.html ./reports/{$project}/{$feature}.html")
                ->background()
                ->idleTimeout(10)
                ->run();

            $this->taskExec("php ./feature/{$project}/{$feature}/Reporting.php")
                ->background()
                ->idleTimeout(10)
                ->run();
        }

        if ($isMetrics == 'n') {
            $this->taskParallelExec()
                //->process('sh ./run/start_selenium.sh mac')
                ->process("sh ./run/saucey.sh tipsy '{$feature} {$browser}'")
                ->idleTimeout(10)
                ->run();

            $this->taskExec("open http://localhost:4444/selenium-server/driver/?cmd=shutDownSeleniumServer")
                ->background()
                ->run();

            $this->taskExec("mv ./reports/saucey_report.html ./reports/{$project}/{$feature}.html")
                ->background()
                ->idleTimeout(10)
                ->run();

            $this->taskExec("php ./feature/{$project}/{$feature}/Reporting.php")
                ->background()
                ->idleTimeout(10)
                ->run();
        }
    }

    /**
     * Asks and obtains $project, $feature, $env and $browser to run Behat, Reporting and SauceLabs
     *
     * @internal param string $folder
     * @internal param string $project
     * @internal param string $env
     * @internal param string $browser
     */
    public function drunkTest()
    {
        $project = $this->ask("What is the name of the parent folder in which this test resides? [string]");
        $feature = $this->ask("What is the '@tag' for feature? [string -- without '@']");
        $env = $this->ask("What environment is this to be test this on? [string]");
        $browser = $this->ask("Which browser is this to be test this in? [string]");

        //Starts tests in parallel
        $this->taskParallelExec()
            ->process("sh ./run/saucey.sh drunk '{$feature} {$env} {$browser}'")
            ->idleTimeout(10)
            ->run();

        $this->taskExec("mv ./reports/saucey_report.html ./reports/{$project}/{$feature}.html")
            ->background()
            ->idleTimeout(10)
            ->run();

        $this->taskExec("php ./feature/{$project}/{$feature}/Reporting.php")
            ->background()
            ->idleTimeout(10)
            ->run();
    }

    /**
     * Connects instance of sauce_connect to SauceLabs API, requires api_key and username
     *
     * @internal param string $un
     * @internal param string $key
     */
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

    /**
     * Starts a Sauce Tunnel, allowing testing on the local host against hosted selenium, with all SauceLabs functions
     *
     * @internal param string $un
     * @internal param string $key
     */
    public function sauceyTunnel()
    {
        $un = $this->ask("What is your username?");
        $key = $this->ask("What is your api-key?");
        $un_key = "{$un} {$key}";

        $this->taskExec('./vendor/sauce/connect/bin/sauce_connect')
            ->arg($un_key)
            ->run();
    }

    /**
     * For saucey developers, push and pull from framework GitHub with this task command
     *
     * @internal param string $un
     * @internal param string $key
     */
    public function sauceyShove($msg)
    {
        //Copy over development yaml
        $this->taskExec('cp -r ./behat.yml vendor/saucey/framework/ymls/behat.yml.master.dist')
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

        //Pull from remotes for saucey/framework
        $this->taskGitStack()
            ->dir('./vendor/saucey/framework/')
            ->pull('origin', 'master')
            ->run();

        //Push to remotes for saucey/framework
        $this->taskGitStack()
            ->dir('./vendor/saucey/framework/')
            ->add('-A')
            ->commit($msg)
            ->push('origin', 'master')
            ->run();

        //Pull from remotes for saucey/wiki
        $this->taskGitStack()
            ->dir('./docs/saucey.wiki/')
            ->pull('origin', 'master')
            ->run();

        //Push to remotes for saucey/wiki
        $this->taskGitStack()
            ->dir('./docs/saucey.wiki/')
            ->add('-A')
            ->commit($msg)
            ->push('origin', 'master')
            ->run();
    }

    # ADCADE TASKS

    /**
     * Tests against campaign: tor_fragrance_2015
     */
    public function adcadeCampaign()
    {
        // Tests Metrics by testing the app locally and verifying metrics locally
        $this->taskParallelExec()
            ->process('./bin/behat --tags "@Regression_TOR_Fragrance_APR15"')
            ->process('./bin/behat --tags "@Regression_TOR_Fragrance_APR15_Metrics" -p local_chrome')
            ->printed(true)
            ->run();

        // Tests against ie8 for Backup image
        $this->taskExec('./bin/behat --tags "@IE_Backup_TOR_Fragrance_APR15" -p sauce_windows_ie8')
            ->printed(true)
            ->run();

        // Tests against Windows Chrome
        $this->taskExec('./bin/behat --tags "@Compatibility_TOR_Fragrance_APR15" -p sauce_windows_chrome')
            ->printed(true)
            ->run();

        // Tests against i
        $this->taskExec('./bin/behat --tags "@IE_Backup_TOR_Fragrance_APR15" -p sauce_windows_ie8')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@Compatibility_TOR_Fragrance_APR15" -p sauce_windows_chrome')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@Compatibility_TOR_Fragrance_APR15" -p sauce_windows_firefox')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@Compatibility_TOR_Fragrance_APR15" -p sauce_mac_safari')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@Compatibility_TOR_Fragrance_APR15" -p sauce_mac_chrome')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@TOR_Fragrance_1032x1100_Tablet" -p sauce_ios_tablet_landscape')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@TOR_Fragrance_1032x1100_Tablet" -p sauce_android_tablet_landscape')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@TOR_Fragrance_1032x1100_Tablet" -p sauce_ios_tablet')
            ->printed(true)
            ->run();

        $this->taskExec('./bin/behat --tags "@TOR_Fragrance_1032x1100_Tablet" -p sauce_android_tablet')
            ->printed(true)
            ->run();
    }

    /**
     * Tests against ADSCR-726, tnbr_pushdown_marquee
     */
    public function adcadeADSCR726()
    {
        // Tests Metrics by testing the app locally and verifying metrics locally
        $this->taskParallelExec()
            ->process('./bin/behat --tags "@ADSCR_726_Desktop" -p local_chrome && sleep 3')
            ->process('./bin/behat --tags "@ADSCR_726_Desktop_Metrics" -p local_chrome')
            ->printed(true)
            ->run();

        // Moves file over and renames with timestamp
        $this->taskExec('php ./features/adcade/ADSCR_726/Reporting.php')
            ->run();
    }

    /**
     * Runs ADSCR-726 suite +10,000 times
     */
    public function adcadeADSCR726Overdose()
    {
        // Runs overdose.sh for ADSCR_726
        $this->taskExec('sh ./features/adcade/ADSCR_726/Run.sh')
            ->printed(true)
            ->run();
    }

    /**
     * Tests HelpCenter against local browsers
     */
    public function adcadeHelpCenterLocal()
    {
        // Tests HelpCenter Locally
        $this->taskExec('./bin/behat --suite=help_center')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();
    }

    /**
     * Tests HelpCenter against SauceLabs browsers and environments
     */
    public function adcadeHelpCenterCloud()
    {
        // Tests HelpCenter against Mac, Chrome
        $this->taskExec('./bin/behat --suite=help_center -p sauce_mac_chrome')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();

        // Tests HelpCenter against Mac, Safari
        $this->taskExec('./bin/behat --suite=help_center -p sauce_mac_safari')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();

        // Tests HelpCenter against Windows, IE9
        $this->taskExec('./bin/behat --suite=help_center -p sauce_windows_ie9')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();

        // Tests HelpCenter against Windows, Firefox
        $this->taskExec('./bin/behat --suite=help_center -p sauce_windows_firefox')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();

        // Tests HelpCenter against iOS, Safari, Landscape
        $this->taskExec('./bin/behat --suite=help_center -p sauce_ios_tablet_landscape')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();

        // Tests HelpCenter against Android, Native, Landscape
        $this->taskExec('./bin/behat --suite=help_center -p sauce_android_tablet_landscape')
            ->printed(true)
            ->run();

        // Moves Report
        $this->taskExec('php ./features/adcade/Help_Center/Reporting.php')
            ->run();
    }

}