@echo on
rem *******************************************************
rem composer.phar.install.bat
rem Command Line install the latest version of composer
rem *******************************************************
@echo off

php.exe -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php.exe -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php.exe composer-setup.php
php.exe -r "unlink('composer-setup.php');"

echo The end of the Script $0

