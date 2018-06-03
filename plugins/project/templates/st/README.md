# System-tests for RESTful Web Services

This project contains a template for writing system-test for RESTful Web Services.
Systems-tests are run in a docker-environment, defined via docker-compose.

## Preparation

This project needs to know the path of the main project that is to be tested.
This is to allow mounting the Gradle build-folder containing the WAR/EAR directly to the autodeploy folder of the application-server running inside Docker.
For this, both projects should be located next to each other.

## Usage

The task systemTestInDockerEnv will start the Docker Compose environment and run the system-tests against it:

~~~
./gradlew systemTestInDockerEnv
~~~

In case you want to manually start the Docker Compose environment, run

~~~
docker-compose up
~~~

Now you can execute the system-tests via

~~~
./gradlew systemTest
~~~

## Performance Tests

### Apache Bench

```
ab -n 1000 -c 5 http://localhost/myapp/resources/APPNAME
```

### JMeter

```
jmeter -n -t stress.jmx
```