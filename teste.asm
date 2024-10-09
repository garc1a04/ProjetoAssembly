.data
	testezin: .asciiz "t"

.text
	la	$a0,testezin
	li	$v0,4
	syscall
