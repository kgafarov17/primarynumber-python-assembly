.data
prompt:     .asciiz     "\nEnter an upper bound > "
primes1:     .asciiz    "\nPrime numbers between 2 and "
primes2:    .asciiz     " are: "
nl:         .asciiz     "\n"
comma:      .asciiz     ", "


.text
main:
    li      $v0     4                   # Load print string opcode
    la      $a0     prompt              # Load prompt
    syscall                             # Print prompt

    li      $v0     5                   # Load read opcode
    syscall                             # Read input
    move    $s0     $v0                 # Store user input in $s0

    mul     $a0     $s0     4           # Get the number of bytes to allocate
    li      $v0     9
    syscall                             # Allocate space on the heap
    move    $s1     $v0                 # Move the array of booleans


    # Initialize the boolean array to False
    li      $s2     0                   # Initialize counter

    bool_loop:
    sb      $zero,    0($s1)            # Set it to False
    beq     $s0     $s2     endbool     # If the max number has been reached
    addi    $s1     $s1     1           # Increase array pointer
    addi    $s2     $s2     1           # Increase counter
    j       bool_loop                   # Repeat the initialization loop

    endbool:


    li      $s2     1                   # Initialize counter

    outer_loop:
    addi    $s2     $s2     1           # Increase counter
    mult    $s2     $s2                 # Square counter
    mflo    $s3                         # Store squared counter
    bgt     $s3     $s0     exit        # If counter is greater than the user input

                                        # `if prime[counter] == 0`
    lb      $s4     0($s1)              # Load the current index of the boolean array
    bnez    $s4     outer_loop          # So nothing if the value is not 0
    mul     $s5     $s2     $s2         # Initialize inner counter to outer counter squared

    inner_loop:
    bgt     $s5     $s0     outer_loop  # Finish loop if the inner counter passes the user input
    add     $s6     $s5     $s1         # Calculate the current index of the bool array
    sb      $s2     0($s6)              # Set current index to anything not False
    add     $s5     $s5     $s2         # inner counter += outer counter     
    j       inner_loop                  # Redo inner loop


    j       outer_loop                  # Repeat the loop
    exit:

    li      $v0     4                   # Load the print string opcode
    la      $a0     primes1             # Load the prime display
    syscall                             # Print the display

    li      $v0     1                   # Load the print int opcode
    move    $a0     $s0                 # Load the user input
    syscall                             # Print the display

    li      $v0     4                   # Load the print string opcode
    la      $a0     primes2             # Load the prime display
    syscall                             # Print the display


    li      $s2     1                   # Initialize counter
    print:
    addi    $s2     $s2     1           # Increment boolean array
    bgt     $s2     $s0     done        # Exit if counter is greater than user input
    add     $s3     $s1     $s2         # Calculate boolean array offset
    lb      $s4     0($s3)              # Load current value in boolean array


    bnez    $s4     print               # Loop agai if current byte is not zero 
                                        # Else print the prime
    li      $v0     1                   # Load the print int opcode
    move    $a0     $s2                 # Load the current prime number
    syscall                             # Print the prime

    li      $v0     4                   # Load the print string opcode
    la      $a0     comma               # Load the comma and space
    syscall                             # Print `, `

    j print                             # Repeat the print loop

    done:

    li      $v0     4                   # Load the print string opcode
    la      $a0     nl                  # Load the newline
    syscall                             # Print `\n`

    li      $v0     10                  # Load exit opcode
    syscall