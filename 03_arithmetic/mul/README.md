# Mul: EFLAGS Analysis

`mul` uses implicit accumulator operands and stores a double-width product.
For unsigned `mul`, only `CF` and `OF` are defined:
- `CF = OF = 0` when upper half is zero
- `CF = OF = 1` when upper half is nonzero

`SF`, `ZF`, `AF`, and `PF` are undefined after `mul`.

## Program 1: mul1.asm (8-bit)

Instruction: `mul byte [num2]` with `al = 25`, `[num2] = 10`
Result: `ax = 250 (0x00FA)`

| Flag | State | Why |
|---|---|---|
| CF | 0 (cleared) | Upper half (`AH`) is zero, so result fits in low half. |
| OF | 0 (cleared) | Same rule as CF for `mul`. |
| SF, ZF, AF, PF | undefined | Intel does not define these flags for `mul`. |

## Program 2: mul2.asm (16-bit)

Instruction: `mul word [num2]` with `ax = 3000`, `[num2] = 200`
Result: `dx:ax = 600000 = 0x0009:0x27C0`

| Flag | State | Why |
|---|---|---|
| CF | 1 (set) | Upper half (`DX = 0x0009`) is nonzero, so product does not fit in 16 bits. |
| OF | 1 (set) | Same rule as CF for `mul`. |
| SF, ZF, AF, PF | undefined | Intel does not define these flags for `mul`. |

## Optional extra case

`mul3.asm` is a 32-bit multiply (`EDX:EAX = EAX * r/m32`) and follows the same CF/OF rule based on whether `EDX` is zero.
