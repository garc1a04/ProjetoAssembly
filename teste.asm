.data
	testezin: .asciiz "isso � um teste"

.text
	la	$a0,testezin
	li	$v0,4
	syscall