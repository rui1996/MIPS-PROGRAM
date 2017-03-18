#MIPS
#QIAN RUI
	.data 

#list upper word
up_words: .asciiz 
	"Alpha","Bravo","China","Delta","Echo",
	"Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mary",
	"November","Oscar","Paper","Quebec","Research","Sierra",
	"Tango","Uniform","Victor","Whisky","X-ray","Yankee","Zulu"	

#list lower word
low_words:.asciiz 
	"alpha","bravo","china","delta","echo",
	"foxtrot","golf","hotel","india","juliet","kilo","lima","mary",
	"november","oscar","paper","quebec","research","sierra",
	"tango","uniform","victor","whisky","x-ray","yankee","zulu"

#word index	
word_index:.word
	0,6,12,18,24,
	29,37,42,48,54,61,66,
	71,76,85,91,97,104,113,
	120,126,134,141,148,154,161

#list numbers
number:.asciiz 
	"zero","First","Second","Third","Fourth",
	"Fifth","Sixth","Seventh","Eighth","Ninth"

#list number index
number_index:.word 
	0,5,11,18,24,
	31,37,43,51,58

#upper and lower bounds for word and number
num_ascii_s: .word 48
num_ascii_e: .word 57
up_ascii_s: .word 65
up_ascii_e: .word 90
low_ascii_s: .word 97
low_ascii_e: .word 122

	.text 
main: 
	li $v0, 12
	syscall 
	beq $v0, 63, exit #if it is "?" just exit

	# if it is number
	lw $t1, num_ascii_s
	lw $t2, num_ascii_e
	sle $t3, $t1, $v0
	sle $t4, $v0, $t2
	and $t5, $t3, $t4
	beq $t5, 1, print_number

	# if it is up_word
	lw $t1, up_ascii_s
	lw $t2, up_ascii_e
	sle $t3, $t1, $v0
	sle $t4, $v0, $t2
	and $t5, $t3, $t4
	beq $t5, 1, print_up
	
	# if it is low_word
	lw $t1, low_ascii_s
	lw $t2, low_ascii_e
	sle $t3, $t1, $v0
	sle $t4, $v0, $t2
	and $t5, $t3, $t4
	beq $t5, 1, print_low	
	
	j default  #else jump to default

print_number:  
	sub $t0, $v0,48   #calculate offset
	sll $t0, $t0, 2   #offset * 4
	la $t1, number_index 
	add $t1, $t1, $t0 #calcute address
	lw $t2, ($t1)
	la $t3, number
	add $a0, $t2, $t3
	li $v0, 4
	syscall 
	j main
	
print_up: 
	sub $t0, $v0, 65  #calculate offset
	sll $t0, $t0, 2   #offset * 4
	la $t1, word_index
	add $t1, $t1, $t0 #calcute address
	lw $t2, ($t1)     
	la $t3, up_words
	add $a0, $t2, $t3
	li $v0, 4
	syscall
	j main
	
print_low:
	sub $t0, $v0, 97  #calcute offset
	sll $t0, $t0, 2   #offset * 4
	la $t1, word_index
	add $t1, $t1, $t0 #calcute address
	lw $t2, ($t1)
	la $t3, low_words
	add $a0, $t2, $t3
	li $v0, 4
	syscall
	j main

default:
	li $a0, 42
	li $v0, 11
	syscall
	j main
	
exit:   
	li $v0, 10
	syscall


	


	