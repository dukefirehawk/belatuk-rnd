# Belatuk R&D

This repository contains projects developed as part of the research and development efforts to improve dart framework in order to bring it inline with the industry standard practise. Currently most are for improving Angel3 framework. Each of the projects are designed to better understand how a particular libraries or dart feature works. Once the behaviour and design patterns are crystalized, they will be incorporated into the framework as part of the refactoring and improvement process.

## Experiments

The following are a list of on going experiments.

### Container

This project is to explore the capabilities of `reflectable` package. The goal is to see if it can provide equivalent features to `dart:mirror`. The result shows that it does not cover all the use cases and generate code with incorrect syntax when it comes to `Angel3`. Requires further analysis to determine if a common code pattern that works can be found. 

### db

This project is to explore the supported SQL queries by `postgresql`, `mysql1` and `mysql_client` driver. This is mainly used in development of ORM to determine what input and output are to be expected by each of the drivers and development of custom data type mapper for them. i.e. datetime field with timezone and no timezone.

### logging

This project is to explore the logging capability of `logging` package. It will be used as the baseline for upgrading the debugging and usage metric in the dart framework.

### performance

This project is to explore the behaviour of using `isotype` in implementing concurrency in improving the sql execution query within ORM. It has shown a couple of bottleneck in the dart framework that could be improved for better performance.