# RTL-Demo

[![License: MIT](https://img.shields.io/badge/License-MIT-2EA44F?logo=open-source-initiative&logoColor=white)](LICENSE)
&nbsp;
[![CMake](https://img.shields.io/badge/CMake-Enabled-064F8C?logo=cmake&logoColor=white)](https://cmake.org)
&nbsp;
[![C++20](https://img.shields.io/badge/C%2B%2B-20-00599C?logo=c%2B%2B&logoColor=white)](https://isocpp.org)

A minimal, self-contained demonstration of the
**[Reflection Template Library (RTL)](https://github.com/ReflectCxx/ReflectionTemplateLibrary-CPP)** along with **[clang-mirror](https://github.com/ReflectCxx/clang-mirror)** generated registration boiler-plate code, enabling run-time reflection for C++.

This repository showcases RTL's core capabilities using a simple, focused project setup.

## ▶ Try It in Your Browser

Run the demo using GitHub Codespaces: [Open Demo Environment](https://github.com/codespaces/new?repo=ReflectCxx/RTL-Demo&ref=clang-mirror-demo&quickstart=1)

> The first launch may take couple of minutes while GitHub prepares the environment and sets up the repo.

This demo contains two simple C++ domain classes:

* `Person`
* `Date`

These source files live under `src/` and are the inputs for registration code generation.

The files to be analyzed by `clang-mirror` are explicitly listed in:

```
registration_srcs.txt
```

This file defines which translation units will be reflected.

To generate the registration code, run:

```bash
./scripts/run_clang_mirror.sh
```

What this does:

* Reads the source file list from `registration_srcs.txt`
* Invokes `clang-mirror` on those files
* Generates reflection registration code inside:

```
RTLRegistration/
```

Once the registration code is generated, build the project using CMake:

```bash
cmake -S . -B build
cmake --build build
```
Once built, run the demo application:

```bash
./build/MyReflectionApp
```

# Experiment with Reflection

You are encouraged to modify and extend the demo to explore RTL more deeply.

## Option 1: Modify Existing Classes

* Add a new member function or overload one.
* Change constructors or add overloads.

After making changes:

```bash
./scripts/run_clang_mirror.sh
cmake --build build
```

Then access the new members or functions reflectively from `main.cpp` using RTL APIs.

## Option 2: Add a New Class

1. Create a new `.cpp` file under `src/`
2. Implement your class normally (no macros or annotations required)
3. Add the new source file path to: `registration_srcs.txt`

> The last step is mandatory. Only files listed in `registration_srcs.txt` are analyzed by `clang-mirror`.

Then regenerate and rebuild:

```bash
./scripts/run_clang_mirror.sh
cmake --build build
```

Once built, update `main.cpp` to construct, inspect, or invoke your new type via RTL reflection.

## Reflection Workflow Reminder

Whenever you modify or add a type or free-function:

1. Ensure the file is listed in `registration_srcs.txt`
2. Run `run_clang_mirror.sh`
3. Rebuild with CMake

Reflection metadata is regenerated from scratch each time.

## Main RTL Project

The full Reflection Template Library, including advanced features, benchmarks, and tests, is available here:

[https://github.com/ReflectCxx/ReflectionTemplateLibrary-CPP](https://github.com/ReflectCxx/ReflectionTemplateLibrary-CPP)



