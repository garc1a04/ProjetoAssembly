.data
	testezin: .asciiz "testandooooooooooooo"

.text
	la	$a0,testezin
	li	$v0,4
	syscall
