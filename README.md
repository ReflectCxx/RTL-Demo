# RTL-Demo

A minimal, self-contained demonstration of the
**Reflection Template Library (RTL)** for C++.

This repository showcases RTL’s core capabilities using a simple, focused project setup.

---

## ▶ Try It in Your Browser

Run the demo instantly using GitHub Codespaces:

[Open Demo Environment](https://github.com/codespaces/new?repo=ReflectCxx/RTL-Demo&quickstart=1)

> The first launch may take a minute while GitHub prepares the environment and builds the demo.

After the environment loads, open the terminal and run:

```bash
./bin/RTLDemoApp
```
---

## What This Demo Shows

* Registering C++ types at runtime
* Discovering constructors and methods by name
* Creating objects dynamically via reflection
* Invoking member functions safely and type-correctly

All without compile-time coupling to the concrete types being used.

---

## What You Will See

When the demo runs, it will:

1. Register the `Person` type with RTL
2. Discover its constructors and methods by name
3. Construct an instance dynamically
4. Invoke member functions via reflection
5. Print the results to the console

This demonstrates real, type-safe runtime reflection in modern C++.

---

## Local Build

If you prefer to run the demo locally:

```bash
cmake -S . -B build
cmake --build build
./bin/RTLDemoApp
```

---

## Main RTL Project

The full Reflection Template Library, including advanced features, benchmarks, and tests, is available here:

[https://github.com/ReflectCxx/ReflectionTemplateLibrary-CPP](https://github.com/ReflectCxx/ReflectionTemplateLibrary-CPP)

---

MIT License
