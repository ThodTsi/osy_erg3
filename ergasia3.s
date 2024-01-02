#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    # Name : Styliani Moumtzi | Theodwros Tsirikolias
    # Am   : p3220127         | p3220215
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    .text
    .globl main

main:
    
    main_loop:
        jal readOption #op=readOption()
        sw $v0,op

        lw $t0,op   #$t0=op

        blt $t0,1,exit  #elegxos while
        bgt $t0,8,exit

        case_1:
            bne $t0,1,case_2    #if(op!=1)

            la $a0,c1   #printStr
            li $v0,4
            syscall

            la $a0,pinA  #readPin(pinA)
            jal readPin
            move $t1,$v0    #$t1=pinA (base register)

            j read_op
        case_2:
            bne $t0,2,case_3    #if(op!=2)

            la $a0,c2   #printStr
            li $v0,4
            syscall

            la $a0,pinB    #readPin(pinB)
            jal readPin
            move $t2,$v0    #$t2=pinB (base register)

            j read_op
        case_3:
            bne $t0,3,case_4    #if(op!=3)

            la $a0,c3   #printStr
            li $v0,4
            syscall

            la $a0,pinA    #createSparse(int[] pinA, int[] SparseA)
            la $a1,SparseA
            jal createSparse

            move $t3,$v0    #$t3 = SparseA (base register)
            sw $v1,mikosA   #mikosA = createSparse(int[] pinA, int[] SparseA)

            lw $t4,mikosA   #$t4 = mikosA

            div $t4,$t4,2   #printInt
            move $a0,$t4
            li $v0,1
            syscall

            la $a0,values   #printStr
            li $v0,4
            syscall

            j read_op
        case_4:
            bne $t0,4,case_5    #if(op!=4)

            la $a0,c4   #printStr
            li $v0,4
            syscall

            la $a0,pinB    #createSparse(int[] pinB, int[] SparseB)
            la $a1,SparseB
            jal createSparse

            move $t5,$v0    #$t5 = SparseB (base register)
            sw $v1,mikosB   #mikosB = createSparse(int[] pinB, int[] SparseB)

            lw $t6,mikosB   #$t6 = mikosB

            div $t6,$t6,2   #printInt
            move $a0,$t6
            li $v0,1
            syscall

            la $a0,values   #printStr
            li $v0,4
            syscall


            j read_op
        case_5:
            bne $t0,5,case_6    #if(op!=5)

            la $a0,c5   #printStr
            li $v0,4
            syscall

            la $a0,SparseA  #addSparse(SparseA, mikosA, SparseB, mikosB, SparseC)
            lw $a1,mikosA
            la $a2,SparseB
            lw $a3,mikosB
            sub $sp,$sp,4
            la $t9,SparseC
            sw $t9,0($sp)
            jal addSparse

            add $sp,$sp,4

            move $t7,$v0    #$t7 = SparseC
            sw $v1,mikosC   #mikosC = addSparse(SparseA, mikosA, SparseB, mikosB, SparseC)

            lw $t8,mikosC   #$t8 = mikosC

            div $t8,$t8,2   #printInt
            move $a0,$t8
            li $v0,1
            syscall

            la $a0,values   #printStr
            li $v0,4
            syscall

            j read_op
        case_6:
            bne $t0,6,case_7    #if(op!=6)

            la $a0,c6   #printStr
            li $v0,4
            syscall

            j read_op
        case_7:
            bne $t0,7,case_8    #if(op!=7)

            la $a0,c7   #printStr
            li $v0,4
            syscall

            j read_op
        case_8:
            bne $t0,8,read_op   #if(op!=8)

            la $a0,c8   #printStr
            li $v0,4
            syscall

            j read_op
        read_op:
            j main_loop

exit:
    la $a0,w    #printStr
    li $v0,4
    syscall

    li $v0,10   #exit
    syscall

readOption:     #readOption()
#-----------printing choices--------------------------------------------------
    la $a0,line
    li $v0,4
    syscall

    la $a0,d1
    li $v0,4
    syscall

    la $a0,d2
    li $v0,4
    syscall

    la $a0,d3
    li $v0,4
    syscall

    la $a0,d4
    li $v0,4
    syscall

    la $a0,d5
    li $v0,4
    syscall

    la $a0,d6
    li $v0,4
    syscall

    la $a0,d7
    li $v0,4
    syscall

    la $a0,d8
    li $v0,4
    syscall

    la $a0,d0
    li $v0,4
    syscall

    la $a0,line
    li $v0,4
    syscall

    la $a0,ch
    li $v0,4
    syscall

    li $v0,5    #readInt
    syscall

    jr $ra  #back to main

readPin:    #readPin(int[] pin)

    li $s0,0    #counter i
    lw $s2,pinlen   
    move $s1,$a0    #$s1=pinA (base register)
        
    readPinLoop:
        bge $s0,$s2,endRP   #if(i>=pin.length)

        la $a0,pos  #printStr
        li $v0,4
        syscall

        move $a0,$s0    #printInt
        li $v0,1
        syscall

        la $a0,sem  #printStr
        li $v0,4
        syscall 

        li $v0,5    #readInt
        syscall

        sw $v0,($s1)    #pin[i] = nextInt 
        add $s1,$s1,4   #nextInt
        add $s0,$s0,1   #i++
        j readPinLoop  

    endRP:
        move $v0,$s1    #back to main
        jr $ra
    
createSparse:   #createSparse(int[] pin, int[] Sparse)
    
    li $s0,0    #k=0
    li $s1,0    #i=0
    lw $s2,pinlen
    move $s3,$a0    #$s3 = pin (base register)
    move $s4,$a1    #$s4 = sparse (base register)

    createSparseLoop:

        bge $s1,$s2,endCS   #if(i>=pin.length)
        lw $s5,($s3)    #$s5 = pin[i]
        beq $s5,0,equal    #if(pin[i]==0)

        sw $s1,($s4)    #sparse[k++]=i
        add $s0,$s0,1   #k++
        add $s4,$s4,4   #next int in sparse

        sw  $s5,($s4)   #sparse[k++]=pin[i]
        add $s0,$s0,1   #k++
        add $s3,$s3,4   #next int in pin

        add $s1,$s1,1   #i++

        j createSparseLoop

    equal:

        add $s1,$s1,1
        add $s3,$s3,4   #next int in pin
        j createSparseLoop

    endCS:

        move $v0,$s4    #back to main
        move $v1,$s0
        jr $ra
               
addSparse:  #addSparse(int [] SparseA, int mikosA, int [] SparseB, int mikosB, int [] SparseC)

    lw $s7, 0($sp)  #$s7 = SparseC (base register)
    move $s0,$a0  #$s0 = SparseA (base register)
    move $s1,$a1  #$s1 = mikosA
    move $s2,$a2  #$s2 = SparseB (base register)
    move $s3,$a3  #$s3 = mikosB
    li $s4,0    #a = 0
    li $s5,0    #b = 0
    li $s6,0    #c = 0

    for1:

        bge $s4,$s1,for2   #if(a >= mikosA)
        bge $s5,$s3,for2   #if(b >= mikosB)

        lw $t1,($s0)
        lw $t2,($s2)
        bge $t1,$t2,else_if    #if(SparseA[a] >= Sparse[b])

        sw $s0,($s7)    #SparseC[c++] = SparseA[a++]
        add $s6,$s6,1
        add $s4,$s4,1
        add $s7,$s7,4
        add $s0,$s0,4

        sw $s0,($s7)    #SparseC[c++] = SparseA[a++]
        add $s6,$s6,1
        add $s4,$s4,1
        add $s7,$s7,4
        add $s0,$s0,4

        j for1
    
    else_if:

        lw $t1,($s0)
        lw $t2,($s2)
        ble $t1,$t2,else    #if(SparseA[a] <= Sparse[b])

        sw $s2,($s7)    #SparseC[c++] = SparseB[b++]
        add $s6,$s6,1
        add $s5,$s5,1
        add $s7,$s7,4
        add $s2,$s2,4

        sw $s2,($s7)    #SparseC[c++] = SparseB[b++]
        add $s6,$s6,1
        add $s5,$s5,1
        add $s7,$s7,4
        add $s2,$s2,4

        j for1

    else:

        sw $s0,($s7)    #SparseC[c++] = SparseA[a++]
        add $s6,$s6,1
        add $s4,$s4,1
        add $s7,$s7,4
        add $s0,$s0,4

        add $s5,$s5,1   #b++

        add $t2,$s0,$s2    #SparseC[c++] = SparseA[a++] + SparseB[b++]
        sw $t2,($s7)
        add $s6,$s6,1
        add $s4,$s4,1
        add $s5,$s5,1
        add $s7,$s7,4
        add $s0,$s0,4
        add $s2,$s2,4

        j for1

    for2:

        bge $s4,$s1,for3   #if(a >= mikosA)

        sw $s0,($s7)    #SparseC[c++] = SparseA[a++]
        add $s6,$s6,1
        add $s4,$s4,1
        add $s7,$s7,4
        add $s0,$s0,4

        sw $s0,($s7)    #SparseC[c++] = SparseA[a++]
        add $s6,$s6,1
        add $s4,$s4,1
        add $s7,$s7,4
        add $s0,$s0,4

        j for2

    for3:

        bge $s5,$s3,endAS   #if(b >= mikosB)

        sw $s2,($s7)    #SparseC[c++] = SparseB[b++]
        add $s6,$s6,1
        add $s5,$s5,1
        add $s7,$s7,4
        add $s2,$s2,4

        sw $s2,($s7)    #SparseC[c++] = SparseB[b++]
        add $s6,$s6,1
        add $s5,$s5,1
        add $s7,$s7,4
        add $s2,$s2,4

        j for3

    endAS:

        move $v0,$s7    #back to main
        move $v1,$s6
        jr $ra



.data
    op: .space 4
    mikosA: .space 4
    mikosB: .space 4
    mikosC: .space 4
    w: .asciiz "ou mpoi"
    c1: .asciiz "Reading array A \n"
    c2: .asciiz "Reading array B \n"
    c3: .asciiz "Creating sparse array A \n"
    c4: .asciiz "Creating sparse array B \n"
    c5: .asciiz "Creating sparse array C = A + B \n"
    c6: .asciiz "Displaying sparse array A \n"
    c7: .asciiz "Displaying sparse array B \n"
    c8: .asciiz "Displaying sparse array C \n"
    d1: .asciiz "1. Read array A \n"
    d2: .asciiz "2. Read array B \n"
    d3: .asciiz "3. Create sparse array A \n"
    d4: .asciiz "4. Create sparse array B \n"
    d5: .asciiz "5. Create sparse array C = A + B \n"
    d6: .asciiz "6. Display sparse array A \n"
    d7: .asciiz "7. Display sparse array B \n"
    d8: .asciiz "8. Display sparse array C \n"
    d0: .asciiz "0, Exit \n"
    line: .asciiz "\n-----------------------------\n"
    ch: .asciiz "Choice? \n"
    pos: .asciiz "Position "
    sem: .asciiz ": "
    values: .asciiz " values"
    pinA: .space 40    #pinA[10]
    pinB: .space 40    #pinB[10]
    pinlen: .word 10    #pin.length = 10
    pinlenC: .word 20   #pin.length = 20
    SparseA: .space 80  #sparseA[20]
    SparseB: .space 80  #sparseB[20]
    SparseC: .space 80  #sparseC[20]
    sparselen: .word 20    #sparse.length = 20