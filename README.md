# Introduction

This is a set of tools to probe jar file internals to identify potential
vulnerabilities such as duplicate classes. The tools are implemented
in Perl based on the CPAN module [Archive::Probe][1], which is capable
of probing deeply nested jar files.

This tools suite contains the follow utilities:

- check-dup.pl -- for duplicate class detection

## Setup

In order to install Archive::Probe, you need install unzip and bzip2.
It is highly recommended that you use cpan minus to install Perl modules.
With this tool, you can install Archive::Probe as simple as typing:

    cpanm Archive::Probe

Then you copy the *.pl files into any directory which is listed in PATH.
And make sure you make the *.pl files executable.

## Class duplication probe tool usage

You may use this tool as:

    cd <dir_where_your_jar_resides>
    check-dup.pl your-jar-file

This tool reports the list of classes which are contained in multiple
jar files. A sample output is as follows:

    02909 org.bouncycastle.pqc.jcajce.provider.rainbow.RainbowKeysToParams:
        01 /hippo-service.jar/lib/bcprov-jdk15on-1.51.jar
        02 /hippo-service.jar/lib/bcprov-jdk14-1.50.jar
    02910 org.bouncycastle.pqc.jcajce.provider.rainbow.SignatureSpi:
        01 /hippo-service.jar/lib/bcprov-jdk15on-1.51.jar
        02 /hippo-service.jar/lib/bcprov-jdk14-1.50.jar

## Build Docker image

To facillitate dependency management, this tool is also available as [Docker image][2]. You can use the docker image as follows:

- pull the docker image
- mount .jar file into the docker container and run the check-dup.pl

The following command sequence is a typical example for your reference:

    cd <dir_where_your_jar_resides>
    docker run                           \
        -it                              \
        --rm                             \
        -v $(pwd):/data                  \
        schnell18/jar-probe:1.0          \
        check-dup.pl /data/your-jar-file

If you wish to build the docker image from scratch, you may clone this repository and run the following command under the root directory of this repository:

    ./build.sh

[1]: https://metacpan.org/pod/Archive::Probe
[2]: https://hub.docker.com/r/schnell18/jar-probe/
