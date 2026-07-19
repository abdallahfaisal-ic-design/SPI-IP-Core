# Parameterized SPI Master/Slave IP Core

A fully synthesizable, flexible SPI (Serial Peripheral Interface) IP Core modeled in Verilog HDL. Designed for high-speed synchronous serial communication, this core enables seamless data exchange between a host processor (Master) and various peripheral devices (Slaves) with full control over transmission modes and word sizing.

## Key Technical Features
* **Full SPI Mode Support:** Fully programmable Clock Polarity (`CPOL`) and Clock Phase (`CPHA`), supporting all four standard SPI transmission modes (Mode 0, 1, 2, and 3).
* * **Parameterized Architecture:** Configurable data word width (`DATA_WIDTH`) to accommodate standard 8-bit, 16-bit, or custom-length stream transmissions.
* * **Dual-Role Capabilities:** Modular Verilog modeling including independent, fully-featured `SPI_Master` and `SPI_Slave` core controllers.
* * **Slave Select Control:** Integrated multi-slave control logic within the Master core to drive independent peripheral device lines smoothly.
* * **Synchronous Bit-Shifting:** Efficient Shift Register architecture handling simultaneous transmission (MOSI) and reception (MISO) on edge-aligned clock cycles.
       
* ## Architecture & Core Modules
* * **SPI Master Controller:** Generates the serial clock (`SCLK`) and manages the active-low Slave Select (`SS`) lines and data flow.
* * **SPI Slave Controller:** Syncs with external clock edges to sample incoming bits and shift out response packets.
* * **Clock Divider / Prescaler:** Configurable internal logic to scale the primary system clock down to target SPI baud rates.
             
* ## Simulation & Verification
* * **HDL Language:** Verilog HDL
* * **Verification Tool:** ModelSim SE
* * **Testbench Methodology:** Complete Master-to-Slave loopback testbench validating data bus integrity across all 4 combinations of CPOL/CPHA, multi-byte transactions, and high-frequency timing alignment.
