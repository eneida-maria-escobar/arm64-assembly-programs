.section .data

input_prompt:          .asciz "Enter two decimal integers and an operator (+ - / *):\n"
invalid_operator_msg:  .asciz "Error: invalid operator\n"
divide_by_zero_msg:    .asciz "Error: divide by zero\n"
result_format:         .asciz "Result: %d\n"
input_format:          .asciz "%d %d %s"

first_integer:  .space 4
second_integer: .space 4
operator:       .space 2

.section .text
.global main
.extern printf
.extern scanf

main:
    ldr x0, =input_prompt
    bl printf

    ldr x0, =input_format
    ldr x1, =first_integer
    ldr x2, =second_integer
    ldr x3, =operator
    bl scanf

    ldr x1, =first_integer
    ldr x2, =second_integer
    ldr x3, =operator
    ldr w4, [x1]
    ldr w5, [x2]
    ldrb w6, [x3]

    cmp w6, #'+'
    beq add_numbers
    cmp w6, #'-'
    beq subtract_numbers
    cmp w6, #'*'
    beq multiply_numbers
    cmp w6, #'/'
    beq divide_numbers
    b invalid_operator_error

add_numbers:
    add w7, w4, w5
    b display_result

subtract_numbers:
    sub w7, w4, w5
    b display_result

multiply_numbers:
    mul w7, w4, w5
    b display_result

divide_numbers:
    cbz w5, divide_by_zero_error
    sdiv w7, w4, w5
    b display_result

invalid_operator_error:
    ldr x0, =invalid_operator_msg
    bl printf
    b exit

divide_by_zero_error:
    ldr x0, =divide_by_zero_msg
    bl printf
    b exit

display_result:
    ldr x0, =result_format
    mov w1, w7
    bl printf

exit:
    mov x0, #0
    mov x8, #93
    svc #0
