# Design and Implementation of High-Performance Multi-Depth Dual-Port FIFO Buffer

## Overview

This project presents the design and implementation of a parameterized dual-port FIFO (First-In, First-Out) buffer using Verilog/SystemVerilog.

The FIFO is designed for efficient data buffering and supports independent read and write operations. The design is parameterized to allow configurable data width, address width, and FIFO depth, making it suitable for different VLSI and digital system applications.

## Features

- Parameterized data width
- Configurable FIFO depth
- Independent read and write enable controls
- Full and empty status flags
- Synchronous read/write operation
- Reset functionality
- Memory-based FIFO architecture
- RTL design suitable for simulation and synthesis

## Design Parameters

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| DATA_WIDTH | 8 | Width of data in bits |
| ADDR_WIDTH | 4 | Address width |
| DEPTH | 16 | Number of FIFO locations |

## Input and Output Signals

| Signal | Direction | Description |
|--------|-----------|-------------|
| clk | Input | Clock signal |
| rst | Input | Reset signal |
| wr_en | Input | Write enable |
| rd_en | Input | Read enable |
| wr_data | Input | Data written into FIFO |
| rd_data | Output | Data read from FIFO |
| full | Output | Indicates FIFO is full |
| empty | Output | Indicates FIFO is empty |

## Project Structure

```text
Dual-Port-FIFO-Verilog/
│
├── README.md
│
├── rtl/
│   └── multi_depth_dual_port_fifo.sv
│
└── testbench/
    └── fifo_tb.sv
