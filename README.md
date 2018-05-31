# JEEEZ

JEEEZ (short: jz) is a simple command-line scaffolding tool that gets you started on developing a Java EE application in seconds.
It's just a Bash-script; so it should be running on most flavors of Linux, Unix, MacOSX and for Windows under Cygwin or MSYS.
Assuming you have Docker installed, it will even get your application deployed in seconds.

The tool is very very simple and optionated to serve my needs in demos and trainings.
It was mainly created due to the non-existing scaffolding/archetype-mechanism in Gradle.

## Installation

~~~
$ git clone https://github.com/38leinaD/jeeez.git
$ echo "alias jz='$(pwd)/jeeez/jz'" >> .bashrc
~~~

## Usage

Run the tool without any argument to get some help about the usage:

~~~
$ jz
Usage: jz [groupid.]artifactid [options]
 
     --jee-version: default: 7
 
 Example: jz de.dplatz.myapp
     This will use the defaults and create a project that...
     - is Java EE 7-compliant,
     - packages as a WAR archive,
     - has group-id "de.dplatz",
     - has artifact-id "myapp",
     - and builds with Gradle and Maven.
~~~

Now, lets deploy a Java EE app:

~~~
$ jz de.dplatz.myapp
Created project with artifact-id 'myapp' and group-id 'de.dplatz' from template 'st'.
Build & run it with 'cd myapp; ./run_docker.sh'.
Open http://localhost/myapp/resources/health after the sever is started.
$ cd myapp; ./run_docker.sh
~~~