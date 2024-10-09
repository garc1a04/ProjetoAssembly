.data
	testezin: .asciiz "isso é um teste"

.text
	la	$a0,testezin
	li	$v0,4
	syscall