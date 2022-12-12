# Getting started with Spectre v1 attack and baseline defense on RISC-V
**Total completion time**:  15 minutes

In this tutorial you will recreate Spectre v1 attack on RISC-V and run a baseline Cache Flush defense

## Table of Contents

* [Prerequisites](#prerequisites)
* [Cloning the Repo](#cloning-the-repo)
* [Install gem5 dependencies](#install-gem5-dependencies)
* [Build Unmodified gem5 Executable](#build-unmodified-gem5-executable)
* [Build gem5 Executable with Cache Flush defense](#build-gem5-executable-with-cache-flush-defense)
* [Build RISC-V Cross Compiler](#build-riscv-cross-compiler)
* [Compile Spectre v1 attack code](#compile-spectrev1-attack-code)
* [Run Spectre v1 attack on unmodified RISC-V OoO core](#run-spectre-v1-attack-on-unmodified-risc-v-ooo-core)
* [Run Spectre v1 attack on RISC-V OoO core with Cache Flush defense](#run-spectre-v1-attack-on-risc-v-ooo-core-with-cache-flush-defense)

## Prerequisites

* Python 3.6 or higher
* PC or virtual machine running Ubuntu 20.04 or higher
* Root access

## Cloning the Repo
Clone the following repo to download all sample code

To clone the repo, run the following command:

```shell
git clone --recursive https://github.com/sumukhmarathe/RISCV-Spectre-Attack-and-Defense.git
```

## Install gem5 dependencies
Run the following command to install gem5 dependencies

```shell
sudo apt install build-essential git m4 scons zlib1g zlib1g-dev \
    libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
    python3-dev python libboost-all-dev pkg-config
```

Run the following command from v1_attack folder to compile the attack code
```console
riscv64-unknown-linux-gnu-gcc spectre_working.c -o spectre_working  -static
```
