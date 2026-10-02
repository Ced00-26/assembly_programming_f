# Div: EFLAGS Analysis

`div` performs unsigned division:
- 8-bit form: `AX / r/m8 -> AL (quotient), AH (remainder)`
- 16-bit form: `DX:AX / r/m16 -> AX (quotient), DX (remainder)`
- 32-bit form: `EDX:EAX / r/m32 -> EAX (quotient), EDX (remainder)`

For `div`, arithmetic flags are undefined: `CF`, `OF`, `SF`, `ZF`, `AF`, `PF`.
So you should not assign meaning to those flag bits after the division instruction.

## Program 1: div1.asm (8-bit)

Instruction: `div bl` with `AX = 100`, `BL = 7`
Result: `AL = 14` (quotient), `AH = 2` (remainder)

| Flag | State |
|---|---|
| CF, OF, SF, ZF, AF, PF | undefined |

## Program 2: div2.asm (16-bit)

Instruction: `div bx` with `DX:AX = 0:50000`, `BX = 300`
Result: `AX = 166` (quotient), `DX = 200` (remainder)

| Flag | State |
|---|---|
| CF, OF, SF, ZF, AF, PF | undefined |

## Optional extra case

`div3.asm` computes `300000000 / 1000`, so `EAX = 300000` and `EDX = 0`. Flags remain undefined.

## Debug note

When stepping in GDB, read registers right after `div` to verify quotient/remainder, but avoid interpreting EFLAGS for this instruction.
