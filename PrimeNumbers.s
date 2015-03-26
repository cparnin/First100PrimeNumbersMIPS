# Title: First 100 Prime Numbers	Filename: PrimeNumbers.s
# Author: Chad Parnin			Date: 3/6/2015

# Description:  Compute and print out the first 100 prime numbers

# Input:	None
# Output:	First 100 prime numbers
######################  data segment  #######################

.data
message:       .asciiz "\nThe first 100 prime numbers are: " #strings to print
newline:       .asciiz "\n"
######################  code segment  #######################

.text
.globl main
main:	# main program entry
	li	$v0, 4	
	la	$a0, message
	syscall			# print message
      	
      	addi	$a0, $0, 2	# n = 2
      	add	$t0, $0, $0	# count = 0
      	
      	
count:	slti    $t1, $t0, 100	# while (count < 100), store in t1
	beq	$t1, $0, exit	# we are done
	jal 	tp		# call test_prime(n)
return:	bne	$v0, $0, print	# print if it's prime
	addi	$a0, $a0, 1	# n++
	j	count
print:	add	$t8, $a0, $0	# store prime number to print
	li	$v0, 4		# we need to print a newline
	la	$a0, newline
	syscall			# print newline
	add	$a0, $t8, $0	# get number back in a0 to print
	li	$v0, 1
	syscall			# print n
	addi	$t0, $t0, 1	# count++
	addi	$a0, $a0, 1	# n++
	j	count		# test again with next number
	       	
tp:	addi 	$t2, $0, 2	# j = 2
loop:	mul	$t3, $t2, $t2	# store j*j in t3 for "while loop"
	slt	$t4, $a0, $t3	# while (n < j*j)
	bne	$t4, 0, rett	# return true if while condition is false (prime)
	div	$a0, $t2
	mfhi	$t5		# t5 = n % j
	beq	$t5, $0, retf	# return false if no remainder (not prime)
	addi 	$t2, $t2, 1	# j++
	jal	loop		# test again with next higher number (3, 4, 5, ... ,n<j*j)
	
rett:	addi	$v0, $0, 1	# return true (found a prime)
	jal	return		# jump back
retf:	add	$v0, $0, $0	# return false (not prime)
	jal	return		# jump back
	
exit:	add	$0, $0, $0	#nop (done)