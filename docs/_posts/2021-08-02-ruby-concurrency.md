---
layout: post
title:  "On Ruby Concurrency"
date:   2021-8-2 01:00:00 -0000
author: Thai Vu
---
### The concurrent landscape.

To be clear, we will be doing a brief overview on Ruby concurrency, not parallelism.
Parallelism is when you can do multiple things at the same time,
while concurrency is when you also can do multiple things,
not at once but one by one. Both are always nice to have,
but concurrency is more preferable for heavy I/O-bound settings - like in a web application.

Along the same lines with other programming languages, there exists many implementations of Ruby itself. 
The Ruby MRI (Matz's Ruby Interpreter, or CRuby), while being the _de facto_ implementation,
suffers from a limitation: it enforces a lock called GVL (Global Virtual Machine Lock) that prevents
multiple threads within a process from running Ruby code simultaneously. For those who are not familiar with the context,
the role of the Ruby VM is to turn interpreter-generated instructions into CPU instructions.
As the Ruby VM is not thread-safe, the GVL was introduced so that only one thread can access it at the
same time, thus prevent undesired complications from clashing threads.

This kind of locking mechanism is actually
not exclusive to Ruby, as interpreters from other dynamic languages like Python's CPython and JavaScript's V8
also employ the strategy as one of their design decisions.
For an interesting practical visualisation on this matter, please check out this
[blog post](https://johnleach.co.uk/posts/2012/10/15/visualising-the-ruby-global-vm-lock) by
John Leach from 2012. Some other Ruby implementations
overcome this limitation by trying to achieve thread-safety without having to introduce GVL by design,
e.g. [JRuby](https://github.com/jruby/jruby) (based on the Java Virtual Machine)
and [TruffleRuby](https://github.com/oracle/truffleruby) (based on Oracle's GraalVM, hence practically
JRuby's sibling), but we will not cover them within the scope of this article. With the GVL in mind,
in the next sections we are going to take a look at how Rails handles concurrency by default, the alternative
models and the prospects.

### Thread-based concurrency
Rails use [Puma](https://github.com/puma/puma) as its default web server. Being multi-threaded, Puma handles
a new HTTP request by utilising the [thread pool](https://en.wikipedia.org/wiki/Thread_pool) from each of its forked process.
Threads work fine in most cases because each request can be handled
in a separate thread and usually resources are not needed to be shared between the requests.
[Sidekiq](https://github.com/mperham/sidekiq) - your favourite job execution gem -
also employs multiple threads for doing background processing.
Apart from its apparent offerings, the use of threads also brings out some concerns that are not easy to be addressed:
- Threads in CRuby are OS-native ones, which are expensive to create and manage.
- While multi-threading in CRuby still helps with concurrency in general, threads are not truly parallel, due to the GVL. 
- Executions in each thread are intrinsically non-deterministic. A single thread, without manual
interference or an effective scheduler, can get stuck and hold the GVL indefinitely, thus blocks other threads.

The CRuby's maintainers have been attempting to tackle the above downsides by introducing non-thread models
for achieving concurrency, namely an interface for scheduling Ruby fibers and an Actor-like abstraction named Ractor.
We will do an overview of both shortly.

### What are fibers
[Fibers](https://ruby-doc.org/core-3.0.2/Fiber.html) are blocks of code that can be _paused_ and _resumed_,
similar to threads in that sense, though the point of fibers is that they are executed one by one within a same thread.
They stem from the [green threads](https://en.wikipedia.org/wiki/Green_threads)
model, in which each thread is scheduled by a runtime library (like Go's goroutines) or a VM (like Erlang VM's
processes) instead of natively by the OS itself. 
I was surprised to find out that fibers were actually introduced since CRuby 1.9 in 2007, which
felt like a lifetime ago.
Prior to that, CRuby actually employed green threads to handle concurrency, the change to use native threads
instead was probably due to the more efficient scheduling mechanisms the OS-es offered.

So what do fibers bring to the table? There are a few key points:
- Fibers are lightweight, being just a data structure holding a call stack.
Creating new fibers or switching between fibers does not require a context switch and has low overhead.
Creating, running, and destroying large numbers of fibers is cheap, especially compared to OS threads.
Think of millions of fibers versus only thousands of threads.
- Most operating systems implement _preemptive_ multitasking,
where the OS allows each thread to run for a period of time,
and then preempts it, temporarily pausing that thread and switching to another.
Fibers, on the other hand, implement _cooperative_ multitasking,
in which a fiber is allowed to run until it yields,
indicating to the scheduler that it cannot currently continue executing.
When a fiber yields, the scheduler switches to executing the next fiber.
- Fibers are traditionally blocking, but are now non-blocking by default (more on that later).
Typically, when an OS thread sleeps, waits for I/O data or synchronises with another thread, it blocks,
allowing the OS to schedule another thread.
When a fiber cannot continue executing, it must yield control to other fibers instead, allows
the scheduler to handle waiting and resuming the fiber when it can proceed.

Fibers can be spawned and yielded in a lightning fast manner:
```ruby
X = 10_000_000
f = Fiber.new do
  loop { Fiber.yield }
end

t0 = Time.now
X.times { f.resume }
dt = Time.now - t0
puts "#{(X / dt.to_f).to_i} per second"

# 7439030 per second
```

Non-blocking fibers has a caveat: they need to be orchestrated by a scheduler, which the CRuby team only provides an
[interface](https://ruby-doc.org/core-3.0.2/Fiber/SchedulerInterface.html)
for, thus shifts the responsibility of implementing it to the hands of the developers.
Writing a proper scheduler is not easy, but there are several 3rd-party gems for doing so that are
under active development, namely
[Async](https://github.com/socketry/async/blob/main/lib/async/scheduler.rb),
[libev_scheduler](https://github.com/digital-fabric/libev_scheduler) and
[evt](https://github.com/dsh0416/evt).

One more concern
not only regarding fibers but about cooperative multitasking in general is that when a fiber
runs a heavy computational task, it can hog the resources for itself and will not yield on time,
blocking other fibers. One approach might be to make fibers work preemptively by introducing
a mechanism similar to Erlang VM's [reduction counting](http://erlang.org/pipermail/erlang-questions/2001-April/003132.html),
but I am not aware of such libraries for Ruby at the point of writing.

### Ractors
[Ractors](https://ruby-doc.org/core-3.0.2/Ractor.html)
(initially known as Guilds) are fully-isolated (without sharing GVL) alternative to threads.
The GVL is now held per ractor instead, so ractors are performed in parallel without locking each other.
To achieve thread-safety without global locking, ractors, in general, cannot access each other's or main program's data.
To share data with each other, ractors rely on message passing/receiving mechanism,
also known as the [Actor model](https://en.wikipedia.org/wiki/Actor_model) (hence the name - Ruby actor).
The idea of applying actor model to Ruby is actually not something new, as libraries like 
[Celluloid](https://github.com/celluloid/celluloid) or
[concurrent-ruby](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Actor.html)
have delivered their own implementations, however with little success for different reasons -
one of them being the omnipresence of the GVL.

Here is an example of using ractors with a [supervisor](https://doc.akka.io/docs/akka/2.5.32/general/supervision.html)
(copied directly from its
[documentation](https://github.com/ruby/ruby/blob/master/doc/ractor.md)):
```ruby
def make_ractor r, i
  Ractor.new r, i do |r, i|
    loop do
      msg = Ractor.receive
      raise if /e/ =~ msg
      r.send msg + "r#{i}"
    end
  end
end

r = Ractor.current
rs = (1..10).map{|i|
  r = make_ractor(r, i)
}

msg = 'e0' # error causing message
begin
  r.send msg
  p Ractor.select(*rs, Ractor.current)
rescue Ractor::RemoteError
  r = rs[-1] = make_ractor(rs[-2], rs.size-1)
  msg = 'x0'
  retry
end

#=> [:receive, "x0r9r9r8r7r6r5r4r3r2r1"]
```

In theory, ractors can be _the_ perfect answer for Ruby concurrency, with a model where one process spawns multiple
ractors, each ractor spawns multiple threads, and each thread multiple fibers.
However, as ractors are new and unstable, they currently serve as a primer for what is going
to come in the future from Matz and the CRuby team.
As ractors cannot access each other's data, one challenging design decision from ractors 
is the introduction of the immutability concept into the
language itself, which can prove to be really hard to achieve since practically
everything in Ruby is mutable by default. We will see.

### What's next?
I believe leveraging fibers is the way forward for Ruby to stay strong in the concurrency game.
If you want to try out a fiber-based web server, [Falcon](https://github.com/socketry/falcon)
should be a great starting point - it can even replace your current Rails app's Puma
since it is Rack-compatible. Another solid library that may catch your attention is
[Polyphony](https://github.com/digital-fabric/polyphony),
though it does not support Rails for now and probably in the future as well.
Polyphony also provides tons of example for you to play with, including an interesting
[thread-vs.-fiber](https://github.com/digital-fabric/polyphony/blob/master/examples/performance/thread-vs-fiber/compare.rb)
comparison.
Ractor as its current state is pretty limited by what it can offer, but there will definitely be
more changes coming from the CRuby team and we will for sure, observe.

Stay safe folks!
