.eqv 	i $t0
.eqv	aux $t3
.eqv	i2 $t2
.eqv	atual $t1
.eqv	i3 $t6
.eqv	tamanho $t7
.eqv	incrementar $s0
.eqv    print $v0
.eqv	ler $v0

.data
	meuVetor:  
		.align 2
		.space 16 
		
	separador:
		.asciiz ", "
.text	
	add 	tamanho, $zero, 16 
	add	incrementar,$zero, 4
	
	li i,0
	#Leitura de dados
	lerVetor:
		li	ler,5
		syscall
		sw	ler,meuVetor(i)
	
		add 	i,i,incrementar
		blt	i,tamanho,lerVetor
	
	
	#ordenacao do vetor Bubble sort
	li i,0
	ordenar:
		beq i,tamanho,seguirEmFrente
		move	i2,$zero
		add	i3,i2,incrementar
		loop:
			beq	i3,tamanho,continuar2
			
			lw  	atual, meuVetor(i2) 
			lw	aux, meuVetor(i3)
			
			bgt 	atual,aux,troca  
			
			continuar:
				add i2,i2,incrementar
				add	i3,i3,incrementar
			j	loop
		
		continuar2:
			add	i,i,incrementar
			j	ordenar
	
	#Troca de valores
	troca:
		lw	$t4, meuVetor(i2)
		lw	$t5, meuVetor(i3)
		
		sw	$t4, meuVetor(i3)
		sw	$t5, meuVetor(i2)
		j	continuar

	
	#Continua para impressao
	seguirEmFrente:
	
	# While para imprimir os dados S2
	
	li i,0
	
	addi	$a0,$zero,'['
	li 	print,11
	syscall
	
	for:
		lw	aux, meuVetor(i)
		move	$a0,aux
		li	print,1
		syscall
		add	i,i,incrementar
		beq  	i,tamanho,Fim
		
		la	$a0, separador
		li 	print,4
		syscall
		j	for
		
	Fim:
		addi	$a0,$zero,']'
		li 	print,11
		syscall
		
		li	print,10
		syscall