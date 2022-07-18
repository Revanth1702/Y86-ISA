# Y86-ISA
This is a processor architecture design based on Y86-ISA using Verilog.
The repositary consists code for both sequential and 5- stage pipeline design.


## Instructions
The following instructions have been implemented in the processor
```
halt 
nop
rrmovq
vmovle
cmovl
cmove
cmovne
cmovge
cmovg
irmovq
rmmovq
mrmovq
addq
subq
andq
xorq
jmp
jle
jl
je
jne
jge
jg
call 
ret
pushq
popq
```
Here is the link for report [Project Report](https://github.com/Revanth1702/Y86-ISA/blob/6872e4c7fda7389e6b11cbf5ad704bf7520f14bc/Final%20Report.pdf)


## Contents
The following shows a tree representaion of contents in this repo.
```bash
├── ALU
│   ├── ALU.v
│   ├── Add.v
│   ├── And.v
│   ├── Xor.v
│   ├── Sub.v
│   ├── test_ADD.v
│   ├── test_AND.v
│   ├── test_Alu.v
│   ├── test_SUB.v
│   ├── test_XOR.v
│   ├── Report.pdf

├── pipeline
│   ├── decode.v
│   ├── execute.v
│   ├── fetch.v
│   ├── memory.v
│   ├── pipeline.v
│   ├── processor.v

├── sequential
│   ├── decode.v
│   ├── decode_tb.v
│   ├── execute.v
│   ├── execute_tb.v
│   ├── fetch.v
│   ├── fetch_tb.v
│   ├── memory.v
│   ├── pc_update.v
│   └── processor.v
├── Final Report.pdf
├── License
└── readme.md

```

## Run Instructions

The **sequential** and **pipeline** folders must consist of the ALU folder so as to perform the required arithmetic operations.

For sequential part
```
cd seq
iverilog -o seq processsor.v
vvp seq
```

For the pipeline part
```
cd pipe
iverilog -o pipe processor.v
vvp pipe
```