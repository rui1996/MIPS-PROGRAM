#MIPS
#QIAN RUI	
	.data
s:      
	.asciiz "\r\nSuccess! Location: "
f:      
	.asciiz "\r\nFail!\r\n"
switch_line:      
	.asciiz "\r\n"
	
string: .space 100

            .text
main:       
	la $a0, string
	la $a1, 100
	li $v0, 8
	syscall

input:  
	li $v0, 12
	syscall
	addi $t7, $v0, 0 
	subi $t6, $v0, 63
	beqz $t6, exit
	addi $v0, $t7, 0
	add $t0, $0, $0
	la $s1, string

loop:  
	lb $s0, 0($s1)
	sub $t1, $v0, $s0
	beq $t1, $0, success
	addi $t0, $t0, 1
	addi $t4, $t0, 0
	subi $t3, $t0, 100
	beqz $t3, fail
	addi $t0, $t4, 0
	addi $s1, $s1, 1
	j loop

success:   
	la $a0, s
	li $v0, 4 
	syscall
	addi $a0, $t0, 1
	li $v0, 1
	syscall
	la $a0, switch_line
	li $v0, 4
	syscall
	j input

fail:       
	la $a0,f
	li $v0,4
	syscall
	j input

exit:       
	li $v0, 10
	syscall
