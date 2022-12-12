# Getting started with Spectre v1 attack and baseline defense on RISC-V
**Total completion time**:  15 minutes

In this tutorial you will recreate Spectre v1 attack on RISC-V and run a baseline Cache Flush defense

## Table of Contents

* [Prerequisites](#prerequisites)
* [Cloning the Repo](#cloning-the-repo)
* [Build Unmodified gem5 Executable](#build-unmodified-gem5-executable)
* [Build gem5 Executable with Cache Flush defense](#build-gem5-executable-with-cache-flush-defense)
* [Build gem5 Executable with Cache Flush defense](#build-gem5-executable-with-cache-flush-defense)
* [Build RISC-V Cross Compiler](#build-riscv-cross-compiler)
* [Compile Spectre v1 attack code](#compile-spectrev1-attack-code)
* [Run Spectre v1 attack on unmodified RISC-V OoO core](#run-spectre-v1-attack-on-unmodified-risc-v-ooo-core)
* [Run Spectre v1 attack on RISC-V OoO core with Cache Flush defense](#run-spectre-v1-attack-on-risc-v-ooo-core-with-cache-flush-defense)

## Prerequisites

* Python 3.6 or higher
* Pc or virtual machine running Ubuntu 18.04 or higher
* Root access

Run the following command from v1_attack folder to compile the attack code
```console
riscv64-unknown-linux-gnu-gcc spectre_working.c -o spectre_working  -static
```
