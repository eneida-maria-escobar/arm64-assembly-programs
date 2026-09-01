# ARM64 Assembly Programs

Two AArch64 assembly programs developed for **CDA 3101: Computer Organization** at the University of Florida in Gainesville, Florida (September–October 2024). Together, they demonstrate low-level control flow, register use, memory addressing, procedure calls, stack-frame management, recursion, and C library interoperability. Both submissions earned **100/100** and passed every Gradescope test.

## Programs

### Integer Calculator

[`src/calculator.s`](src/calculator.s) reads two signed decimal integers and an arithmetic operator, dispatches to the matching ARM64 instruction, and reports invalid operators and division by zero.

### Recursive Palindrome Checker

[`src/palindrome.s`](src/palindrome.s) reads a full line, computes its length without a library string routine, and recursively compares characters from the outside inward. The implementation manages its own stack frames and preserves recursion state explicitly.

## Build and run

These programs target **AArch64 Linux** and call `printf` and `scanf` from the C standard library. On an ARM64 Linux system with GCC installed:

```bash
gcc -o calculator src/calculator.s
./calculator

gcc -o palindrome src/palindrome.s
./palindrome
```

On an x86-64 machine, use an AArch64 cross-compiler and QEMU or an ARM64 virtual machine.

## Skills demonstrated

- AArch64 arithmetic, comparison, branch, load, and store instructions
- Register-level input processing and error handling
- ABI-aware calls to `printf` and `scanf`
- Manual string traversal and byte addressing
- Recursive procedure design and stack-frame management

## Academic context

The repository preserves the submitted algorithms while improving label names and spacing and correcting the calculator's operator buffer size for safe null termination. Assignment specifications and instructor-provided test materials are not included.
