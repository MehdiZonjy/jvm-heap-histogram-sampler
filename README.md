# JVM Heap Histogram Sampler
This scripts runs `jmap -histo pid` at the requested interval.
Useful for analyzing jvm heap growth and object allocation

The output is better analyzed with something such as [jcha](https://github.com/trivago/jcha)
