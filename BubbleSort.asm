.data
	diretorio: .asciiz "C:\\Users\\guiga\\Desktop\\Assembly\\lista.txt"
	salvarArq: .asciiz "C:\\Users\\guiga\\Desktop\\Assembly\\listaTeste.txt"
	
	conteudo: .space 1024
	
	vetorInteiro: 	.align 2
			.space 1024
	
	string: .align 0
	.space 4
		
	vetorString: .align 0 
	.space 1024
	
.text
	li 	$v0, 13 	#Solicitando abertura do arquivo.
	#Passando os argumentos de abertura.
	la 	$a0, diretorio 	#Informando o diretorio do arquivo.
	li 	$a1, 0 		#Informando o modo em que o arquivo serï¿½ lido, nesse caso, modo de leitura.
	syscall
	
	move 	$s0, $v0 	#Passa uma cï¿½pia do arquivo para um resgitrador de armazenamento.
	
	move 	$a0, $s0 	#Passa a cï¿½pia do arquivo para um registrador de endereï¿½o para ser usado como argumento para leitura do conteï¿½do do arquivo aberto.
	li 	$v0, 14  	#Funï¿½ï¿½o de leitura do arquivo.
	
	#Passando os argumentos de leitura.
	la 	$a1, conteudo 	#Carregando endereï¿½o do buffer que armazena o conteï¿½do.
	li 	$a2, 1024 	#Informando o tamanho do arquivo.
	syscall
	
	move	 $s1, $a1 	#Armazenando o conteï¿½do do arquivo em um registrador de armazenamento.
	li $v0, 16 #Funï¿½ï¿½o de fechamento do arquivo.
	move $a0, $s0 #Movendo o diretorio do arquivo para o registrador a0.
	syscall
	
	move $t0, $s1		#passando p/ t1 o conteudo da string
	
	move $t3, $zero 	#Zerando registrador que vai armazenar o nï¿½mero inteiro.
	move $t4, $zero 	#Zerando registrador que vai armazenar o indice do vetor.
	addi $t6, $zero, 1  	#Criando a flag para definir o sinal.
	
	percorrendoString:
		lb $t1, 0($t0)		#t1 armazena o caractere
		beq $t1, $zero, pularUm #Checando se acabou a string
		beq $t1, '-', negativo #Checando se o nï¿½mero serï¿½ negativo
		beq $t1, ',', pularUm #Checando se hï¿½ virgula
		
		converterInteiro:
			move $t2, $t1 #Passa o char lido do vetor para um registrado auxiliar.
			subi $t2, $t2, 48 #Convertendo no registrador $t2 o valor do nï¿½mero de ASCII para inteiro.
			mul $t3, $t3, 10 #Multiplicando por 10 o registrador que armazena o valor final para poder adicionar a proxima unidade.
			add $t3, $t3, $t2 #Adicionando a proxima unidade para o registrador que armazena o valor final.
			
			addi $t0, $t0, 1 #Incrementando o endereï¿½o da string para ir ao prï¿½ximo valor (i++)
			j	percorrendoString #Voltando para o comeï¿½o do loop
			
		negativo:
			addi $t6, $zero, -1 #Setando a flag para negativa
			addi $t0, $t0, 1 #Incrementando o endereï¿½o da string para ir ao prï¿½ximo valor (i++)
			j	percorrendoString #Voltando para o comeï¿½o do loop
		
		pularUm:
			mul $t3, $t3, $t6 #Multiplicando o valor inteiro sem sinal pela flag
			sw $t3, vetorInteiro($t4) #Armazenando no vetor o valor final
			
			move $t3, $zero #Zerando registrador que vai armazenar o nï¿½mero inteiro.
			addi $t6, $zero, 1  #Criando a flag para definir o sinal.
			addi $t0, $t0, 1 #Incrementando o endereï¿½o da string para ir ao prï¿½ximo valor (i++)
			addi $t4, $t4, 4 #Pulando de 4 em 4 pois cada espaï¿½o do vetor equivale a 4 bytes.
			beq $t1, $zero, finalizar #Checando se acabou a string
			
			j	percorrendoString
	finalizar:
	
		move $s2, $t4 	#Salvando em um registrador o indice do ultimo valor do vetor
	
	#---------------- Ordenacao do vetor Bubble sort ------------------------------------#	
	move	$t0,$zero
	move	$t1,$zero
	move	$t2,$zero
	move	$t3,$zero
	move	$t4,$zero
	move	$t5,$zero
	move	$t6,$zero
	move	$t7,$zero
	
	add 	$t7, $zero, $s2 
	
	ordenar:
		beq 	$t0,$t7,seguirEmFrente		# if(indexAtual == tamanhoVetor);
		
		move	$t2,$zero			# coloca o registrador t2 como 0
		add	$t6,$t2,4			# indexNova = index+1
		loop:
			beq	$t6,$t7,continuar2	# if(segundaIndex == tamanhoVetor);
			
			lw 	$t1, vetorInteiro($t2)  # pegar o valor do vetor(index) e coloca no t1
			lw	$t3, vetorInteiro($t6)	# pegar o valor do vetor(index+1) e coloca no t3
			
			bgt 	$t1,$t3,troca  		# if(vetor(index) > vetor(index+1));
			
			continuar:
				add 	$t2,$t2,4	# concatena+1 na index
				add	$t6,$t6,4	# concatena+1 na indexNova
			j	loop
		
		continuar2:
			add	$t0,$t0,4		# indexAtual+=tamanho	
			j	ordenar
			
	#Troca de valores
	troca:
		lw	$t4, vetorInteiro($t2)	# pega valor do Vetor	
		lw	$t5, vetorInteiro($t6)	# pega valor do Vetor+1
		
		sw	$t4, vetorInteiro($t6)
		sw	$t5, vetorInteiro($t2)	#troca...
		j	continuar
	
	#Continua para impressao
	seguirEmFrente:
	
	#-------------------------------------------------TRANSFORMAR INTEIRO PARA STRING-----------------------------------------------#
		
	#passar para STRING
	li	$t6,0			# variavel para o vetorString.(Por algum motivo ele consome o valor da STRING por isso comeï¿½a com 4...)
	li	$t0,0			# variavel para o vetorInteiro.
	passarString:
		li	$t4,0			#Zerar String
		j	limparString
	manter:
		lw 	$t1,vetorInteiro($t0) 	#pega o valor dentro do vetor e passa para t1
		li	$t5, 3		# j = 3 -> variavel para a String.
		bltz	$t1,definir	#if(vetor(I) < 0) coloco o negativo no primeiro vetor da String
		j	conversao	# Vou para a conversao
	continua:
		addi 	$t0,$t0,4	#i = i+1
		beq $t0, $s2 ,fim2 	#if(i == 16) break;
		
		li	$t3,44			#Valor do "," na tabela ASCII
		sb 	$t3,vetorString($t6) 	#adiciona a virgula
		addi 	$t6,$t6, 1		#incremento a variavel da string total
		
		j 	passarString
	limparString:	
		beq	$t4,4,manter		
		li	$t3, 0
		sb 	$t3, string($t4)	# Coloca todos os valores como 0
		addi 	$t4,$t4,1
		j	limparString
		
	definir:
		li	$t4,45			#Valor do "-" na tabela ASCII
		sb 	$t4, string($zero)	#Coloca o negativo na STRING
		mul	$t1, $t1,-1		
		j	conversao
		
	conversao:
		beqz  	$t1, colocarNoVetor 	#if(t1 == 0)
		li 	$t3, 10	
		div	$t1,$t3 		#divide o valor do vetor por 10
		
		mflo 	$t1 			#pega o quociente
		mfhi 	$t3 			#Pega o resto
		add	$t3,$t3,48		#Somo o valor do resto por 48, para dar o valor na tabela ASCII
		
		sb 	$t3, string($t5)	#Coloco de tras para frente no vetor
		addi 	$t5,$t5,-1		# j = j-4
		j	conversao
	
	colocarNoVetor:
		beq    	$t1, 4 ,continua 
		
		lb 	$t3, string($t1) 	# pega o valor dentro do vetor e passa para t3
		addi 	$t1, $t1,1
		
		beqz	$t3,colocarNoVetor	 #if(T1 == 0) significa q o primeiro valor ï¿½ positivo
		
		sb	$t3, vetorString($t6) # pego o valor lido e coloco no vetor
		addi 	$t6,$t6,1 # k++
		
		beq    	$t1, 4 ,continua
		j	colocarNoVetor
	fim2:
		li $v0, 13
		la $a0, salvarArq
		li $a1, 1
		syscall
		
		move $s3, $v0
		
		li $v0, 15
		move $a0, $s0
		la $a1, vetorString
		move $a2, $t6
		syscall
		
		li $v0, 16 #Função de fechamento do arquivo.
		move $a0, $s3 #Movendo o diretorio do arquivo para o registrador a0.
		syscall