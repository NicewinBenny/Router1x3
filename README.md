

### 🛠️ Router1x3 – Design and Verification

This project involves the RTL design and verification of a **Router1x3**, a digital data routing module that directs incoming packets to one of three output channels based on the address. The design is implemented using **Verilog HDL** and verified using **UVM** (Universal Verification Methodology).

#### 🔧 Key Features:
- **Modules Designed**: FIFO buffer, Synchronizer, Register, and FSM-based Controller.
- **Functionality**: Efficiently routes variable-length packets based on address decoding.
- **Verification**: 
  - UVM-based testbench for modular and reusable verification.
  - Constraint random stimulus generation.
  - Assertion-based verification for protocol checking.
  - Functional coverage analysis to ensure verification completeness.
  
#### 🧰 Tools Used:
- Xilinx Vivado for design simulation and synthesis.
- QuestaSim for UVM simulation and debugging.
