# Sub: EFLAGS Analysis

This folder contains programs that use `sub` (and one also uses `sbb`).
I analyzed flags immediately after the `sub` instruction.

## Program 1: sub1.asm (8-bit)

Instruction: `sub al, [num2]` with `al = 50 (0x32)` and `[num2] = 80 (0x50)`
Result: `al = -30` as 8-bit two's complement = `0xE2`

| Flag | State | Why |
|---|---|---|
| CF | 1 (set) | Unsigned borrow is needed because 50 < 80. |
| OF | 0 (cleared) | Signed subtraction does not overflow (`50 - 80 = -30` fits in signed 8-bit range). |
| ZF | 0 (cleared) | Result is not zero. |
| SF | 1 (set) | Bit 7 of `0xE2` is 1. |
| PF | 1 (set) | Low byte `0xE2` (`11100010`) has 4 one-bits (even parity). |
| AF | 0 (cleared) | Low nibble `0x2 - 0x0` needs no borrow from bit 4. |

## Program 2: sub2.asm (16-bit)

Instruction: `sub ax, [num2]` with `ax = 1000 (0x03E8)` and `[num2] = 2000 (0x07D0)`
Result: `ax = -1000` as 16-bit two's complement = `0xFC18`

| Flag | State | Why |
|---|---|---|
| CF | 1 (set) | Unsigned borrow is needed because 1000 < 2000. |
| OF | 0 (cleared) | Signed subtraction does not overflow (`1000 - 2000 = -1000` fits in signed 16-bit range). |
| ZF | 0 (cleared) | Result is not zero. |
| SF | 1 (set) | Bit 15 of `0xFC18` is 1. |
| PF | 1 (set) | Low byte `0x18` (`00011000`) has 2 one-bits (even parity). |
| AF | 0 (cleared) | Low nibble `0x8 - 0x0` needs no borrow from bit 4. |

## Note on sub3.asm

`sub3.asm` demonstrates borrow chaining with `sub` followed by `sbb`. For debugging, inspect flags after each arithmetic instruction separately.
