Few scripts that i use when debugging performance issues for a live jvm process
# JVM Heap Histogram Sampler
This scripts runs `jmap -histo pid` at the requested interval.
Useful for analyzing jvm heap growth and object allocation

The output is better analyzed with something such as [jcha](https://github.com/trivago/jcha)


# JVM Thread Dump Sampler
Captures jvm Thread Dumps at requested interval.
The output archieve can be used with [fastthread.io](http://fastthread.io)