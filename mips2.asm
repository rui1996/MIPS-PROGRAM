#MIPS
#QIAN RUI	
	.data
s:      
	.asciiz "\r\nSuccess! Location: "
f:      
	.asciiz "\r\nFail!\r\n"
switch_line:      
	.asciiz "\r\n"
	
string: .space 100  #set space for string

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
	beqz $t6, exit    #if input is "?",just exit
	addi $v0, $t7, 0  
	add $t0, $0, $0   #set t0 with 0
	la $s1, string

loop:  
	lb $s0, 0($s1)    
	sub $t1, $v0, $s0  #if two character is equal
	beq $t1, $0, success #jump to success
	addi $t0, $t0, 1   #increase t0 by 1
	addi $t4, $t0, 0  
	subi $t3, $t0, 100 #see whether t0 is equal to 100
	beqz $t3, fail     #if it is, it means failing to find it 
	addi $t0, $t4, 0  #reset t0
	addi $s1, $s1, 1  #increase s1
	j loop

success:    
	la $a0, s          #print success
	li $v0, 4 
	syscall
	addi $a0, $t0, 1  #update a0
	li $v0, 1
	syscall
	la $a0, switch_line  #use \r\n to switch line
	li $v0, 4
	syscall
	j input            #back to input

fail:       
	la $a0,f           #print fail
	li $v0,4
	syscall
	j input

exit:       
	li $v0, 10
	syscall
