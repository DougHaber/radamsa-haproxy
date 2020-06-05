# radamsa-haproxy

This provides a Dockerfile for load balancing multiple [Radamsa](https://gitlab.com/akihe/radamsa) servers under [HAProxy](http://www.haproxy.org/).

In situations where Radamsa is being used as a server and is a CPU bottleneck, this might be useful. Multiple independent servers are run, so it only makes sense when using Radamsa for non-deterministic fuzzing.

This was a quick solution for a very specific problem I encountered on a fuzzing project.  While not as elegant, it was a much simpler solution than modifying Radamsa itself. Since HAProxy provides a single port, applications that use a Radamsa server don't need any configuration change to use this instead.

## Usage Examples:

```sh
# Build a Docker image:
docker build -t radamsa-haproxy .

# Run on port 8888 with the directory "my-samples" containing input files
docker run \
    --rm \
	--init \
	-v `pwd`/my-samples:/samples \
	-p 8888:8888 \
	radamsa-haproxy
```

A directory must be mounted into `/samples` containing one or more files to use as input to the fuzzer.  In the example, `pwd` is used to insert the current working directory, since Docker requires absolute paths for mounts.

By default 4 Radamsa servers are started. The number can be changed by passing `NUM_SERVERS` into the container.
