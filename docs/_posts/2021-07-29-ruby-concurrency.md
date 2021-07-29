---
layout: post
title:  "On Ruby Concurrency"
date:   2021-07-29 08:00:00 -0000
author: Thai Vu
---

### The concurrent landscape.

Along the same lines with other programming languages, there exists many implementations of Ruby itself. 
The Ruby MRI (Matz's Ruby Interpreter, or CRuby), while being the _de facto_ implementation,
suffers from a limitation: it enforces a lock called GVL (Global Virtual Machine Lock) that prevents
multiple threads within a process from running Ruby code simultaneously. For those who are not familiar with the context,
the role of the Ruby VM is to turn interpreter-generated instructions into CPU instructions.
As the Ruby VM is not thread-safe, the GVL was introduced so that only one thread can access it at the
same time, thus prevent undesired complications from clashing threads. This kind of locking mechanism is actually
not exclusive to Ruby, as interpreters from other dynamic languages like Python's CPython and JavaScript's V8
also employ the strategy as one of their design decisions.

As mentioned above, the use of GVL prevents the "true parallelism" attainable
through concurrency of a single process with multiple threads. Please check out this
[blog post](https://johnleach.co.uk/posts/2012/10/15/visualising-the-ruby-global-vm-lock) by
John Leach from 2012 for a practical visualisation on this matter. Some other Ruby implementations
overcome this limitation by trying to achieve thread-safety without having to introduce GVL by design,
e.g. [JRuby](https://github.com/jruby/jruby) (based on the Java Virtual Machine)
and [TruffleRuby](https://github.com/oracle/truffleruby) (based on Oracle's GraalVM, hence practically
JRuby's sibling), but we will not cover them within the scope of this article. With the MRI's GVL in mind,
in the next sections we are going to take a look at how Rails handles concurrency by default, the alternative
models and the prospects.

### Threading and the Rails concurrency model

Rails use [Puma](https://github.com/puma/puma) as its default web server. Being multi-threaded, Puma handles
a new HTTP request by utilising the [thread pool](https://en.wikipedia.org/wiki/Thread_pool) from each of its forked process.
Threads work fine in most cases because each request can be handled
in a separate thread and usually resources are not needed to be shared between the requests.
[Sidekiq](https://github.com/mperham/sidekiq) - your favourite job execution gem -
also employs multiple threads for doing background processing.
Apart from its apparent offerings, the use of threads also brings out some concerns that are not easy to be addressed:

- Threads in MRI are OS-native ones, which are expensive to create and manage.
- While multi-threading in MRI still helps with concurrency in general, threads are not truly parallel, due to the GVL. 
- Executions in each thread are intrinsically non-deterministic. A single thread, without manual
interference or an effective scheduler, can get stuck and hold the GVL indefinitely, thus blocks other threads.

The Ruby MRI's maintainers have been attempting to tackle the above downsides by introducing non-thread models
for achieving concurrency, namely an interface for scheduling Ruby fibers and an Actor-like abstraction named Ractor.
We will do an overview of both shortly.

### What are fibers
I was surprised to find out that fibers were actually introduced since the MRI 1.9 in 2007, which in retrospective
felt like a lifetime ago. By [definition](https://ruby-doc.org/core-3.0.2/Fiber.html), fibers are "primitives for 
implementing light weight cooperative concurrency in Ruby."

#### Fiber scheduler

```ruby
start = Time.now

Thread.new do # in this thread, we'll have non-blocking fibers
  Fiber.set_scheduler Scheduler.new

  %w[2.6 2.7 3.0].each do |version|
    Fiber.schedule do # Runs block of code in a separate Fiber
      t = Time.now
      # Instead of blocking while the response will be ready, the Fiber
      # will invoke scheduler to add itself to the list of waiting fibers
      # and transfer control to other fibers
      Net::HTTP.get('rubyreferences.github.io', "/rubychanges/#{version}.html")
      puts '%s: finished in %.3f' % [version, Time.now - t]
    end
  end
end.join # At the END of the thread code, Scheduler will be called to dispatch
         # all waiting fibers in a non-blocking manner

puts 'Total: finished in %.3f' % (Time.now - start)
# Prints:
#  2.6: finished in 0.139
#  2.7: finished in 0.141
#  3.0: finished in 0.143
#  Total: finished in 0.146
```

### Ractor
