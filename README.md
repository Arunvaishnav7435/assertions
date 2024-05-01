# assertions
## Introduction
This code demonstrates the usage of systemverilog assertions.

### Assertions used:
* Immediate assertion
* Concurrent assertions

### Operators
- Assertion is bound to DUT using *bind* keyword.
- Overlapping and non overlapping implication operators are used.

### DUT
- An RTL code is written for a BCD counter.

### Result
- The immediate assertion fails twice before the DUT is reset.
- All the concurrent assertions succeed.
