___
# Hardware Cache-Switching with Operating System Context Switches
___

## Introduction

Caches are used to improve the memory access time using temporal and spatial locality. Also, memory accesses increase the power consumption.When An operating system performs a context switch,it suspends one kernel-level thread and activates a different thread.Normally this process needs to flush the data stored in cache memory and load the data needs for the activated thread. Since flushing and loading takes much  cpu cyles ,memory acessing time and more energy consumption,Operating System Context Switching decrese the overall performance of the processor.This project aims to explore the advantages of maintaining multiple small "cache-storage-cores" and switching to the appropriate one during a context switch. We will use a RISC-V CPU with a embedded operating system and a custom-built cache controller and cache core system for the FPGA-based experiments.
