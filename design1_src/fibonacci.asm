ORG 100              ; Fibonacci sequence calculation

    Load    FibPrev    ; Load the previous Fibonacci number into AC
    Add     FibCurr    ; Add the current Fibonacci number
    Store   FibNext    ; Store the new Fibonacci number

    Load    FibCurr    ; Load the current Fibonacci number into AC
    Store   FibPrev    ; Update the previous Fibonacci number

    Load    FibNext    ; Load the new Fibonacci number into AC
    Store   FibCurr    ; Update the current Fibonacci number

    Load    Ctr        ; Load the loop control variable
    Add     Neg1       ; Decrement the loop control variable by one
    Store   Ctr        ; Store the new value of the loop control variable

    Skipcond  400       ; If the control variable = 0, skip next instruction to terminate the loop
    Jump    Loop       ; Otherwise, go to Loop

    Halt               ; Terminate program

FibPrev, Dec   0       ; Previous Fibonacci number (initialized to 0)
FibCurr, Dec   1       ; Current Fibonacci number (initialized to 1)
FibNext, Dec   0       ; Next Fibonacci number
Ctr,      Dec   10      ; Loop control variable (for the 11th Fibonacci number)
Neg1,     Dec   -1      ; Used to increment and decrement by 1
