.section .data

input_prompt:    .asciz "Input a string: "
input_spec:      .asciz "%[^\n]"
palindrome_spec: .asciz "String is a palindrome (T/F): %c\n"

.section .text
.global main
.extern printf
.extern scanf

main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #256
    mov x19, sp

    ldr x0, =input_prompt
    bl printf

    ldr x0, =input_spec
    mov x1, x19
    bl scanf

    mov x0, x19
    bl strlen_custom
    mov x20, x0

    cmp x20, #0
    bne proceed_check
    mov w0, #1
    b print_result

proceed_check:
    mov x1, #0
    sub x2, x20, #1
    mov x0, x19
    bl is_palindrome

print_result:
    cbz w0, not_palindrome
    ldr x0, =palindrome_spec
    mov w1, #'T'
    bl printf
    b exit_program

not_palindrome:
    ldr x0, =palindrome_spec
    mov w1, #'F'
    bl printf

exit_program:
    add sp, sp, #256
    ldp x29, x30, [sp], #16
    b exit

is_palindrome:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #16

    str x1, [sp, #0]
    str x2, [sp, #8]

    cmp x1, x2
    bge base_case

    add x3, x0, x1
    ldrb w4, [x3]
    add x5, x0, x2
    ldrb w6, [x5]

    cmp w4, w6
    bne not_palindrome_recursive

    add x1, x1, #1
    sub x2, x2, #1
    bl is_palindrome

    ldr x1, [sp, #0]
    ldr x2, [sp, #8]
    cbz w0, not_palindrome_recursive
    mov w0, #1
    b end_recursion

base_case:
    mov w0, #1
    b end_recursion

not_palindrome_recursive:
    mov w0, #0

end_recursion:
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

strlen_custom:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x1, #0

strlen_loop:
    add x2, x0, x1
    ldrb w2, [x2]
    cbz w2, strlen_done
    add x1, x1, #1
    b strlen_loop

strlen_done:
    mov x0, x1
    ldp x29, x30, [sp], #16
    ret

exit:
    mov x0, #0
    mov x8, #93
    svc #0
