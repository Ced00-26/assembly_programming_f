# Add: EFLAGS Analysis

This folder contains programs that use `add` (and one also uses `adc`).
I analyzed flags immediately after the `add` instruction.

## Program 1: add1.asm (8-bit)

Instruction: `add al, [num2]` with `al = 120 (0x78)` and `[num2] = 10 (0x0A)`
Result: `al = 130 (0x82)`

| Flag | State | Why |
|---|---|---|
| CF | 0 (cleared) | Unsigned 120 + 10 = 130 fits in 8 bits (no carry out of bit 7). |
| OF | 1 (set) | Signed positive + positive produced a negative 8-bit result (`0x82`), so signed overflow occurred. |
| ZF | 0 (cleared) | Result is not zero. |
| SF | 1 (set) | Bit 7 of `0x82` is 1. |
| PF | 1 (set) | Low byte `0x82` (`10000010`) has 2 one-bits (even parity). |
| AF | 1 (set) | Low nibble `0x8 + 0xA = 0x12` carries from bit 3 to bit 4. |

## Program 2: add2.asm (16-bit)

Instruction: `add ax, [num2]` with `ax = 32000 (0x7D00)` and `[num2] = 500 (0x01F4)`
Result: `ax = 32500 (0x7EF4)`

| Flag | State | Why |
|---|---|---|
| CF | 0 (cleared) | Unsigned 32000 + 500 = 32500 fits in 16 bits. |
| OF | 0 (cleared) | Signed 32000 + 500 = 32500 still fits in signed 16-bit range. |
| ZF | 0 (cleared) | Result is not zero. |
| SF | 0 (cleared) | Bit 15 of `0x7EF4` is 0. |
| PF | 0 (cleared) | Low byte `0xF4` (`11110100`) has 5 one-bits (odd parity). |
| AF | 0 (cleared) | Low nibble addition `0x0 + 0x4` does not carry into bit 4. |

## Note on add3.asm

`add3.asm` demonstrates carry chaining with `add` followed by `adc`. If you inspect flags, make sure you read EFLAGS right after `add` and again right after `adc`, because each instruction updates flags.
