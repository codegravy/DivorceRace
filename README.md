# DivorceRace Remote Debugger
======

This branch is for running the debug instance on remote systems.  Since all clients
should be running the same instance, and using git to push files around can get tedious
and be prone to errors, this should allow using Godot's "Remote FS" feature.

You can use the godot cli to run different features for now, but a remote manager may be
in the works here soon, so stick around.

##Usage

Simple setup for basic debugging: `<Godot Executable> --remote-fs <host ip>:6010`

With profiling and collision debugging: `<Godot executable> --remote-fs <host ip>:6010 --profiling --debugging --debug-collisions`
