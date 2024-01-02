#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    # Name : Styliani Moumtzi | Theodwros Tsirikolias
    # Am   : p3220127         | p3220215
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    .text
    .globl main

main:
    
    main_loop:
        jal readOption #op=readOption();
        sw $v0,op
        lw $t0,op

        blt $t0,1,exit  #elegxos while
        bgt $t0,8,exit

        case_1:
            bne $t0,1,case_2    #if(op!=1)

            la $a0,c1   #printStr
            li $v0,4
            syscall

            la $a0,pinA  #readPin(pinA)
            jal readPin
            move $t1,$a0

            j read_op
        case_2:
            bne $t0,2,case_3    #if(op!=2)

            la $a0,c2   #printStr
            li $v0,4
            syscall

            la $a0,pinB  #readPin(pinB)
            jal readPin
            move $t1,$a0

            j read_op
        case_3:
            bne $t0,3,case_4    #if(op!=3)

            la $a0,c3   #printStr
            li $v0,4
            syscall

            j read_op
        case_4:
            bne $t0,4,case_5    #if(op!=4)

            la $a0,c4   #printStr
            li $v0,4
            syscall

            j read_op
        case_5:
            bne $t0,5,case_6    #if(op!=5)

            la $a0,c5   #printStr
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

readOption:
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

    li $v0,5
    syscall

    jr $ra  #back to main

readPin:
    li $s0,0    #counter i
    lw $s2,pinlen
    move $s1,$a0    #$s1=pinA (base register)
        
    loop:
        bge $s0,$s2,end_r   #if(i>=pin.length)

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

        sb $v0,($s1)    #pin[i] = nextInt
        add $s1,$s1,4   #nextInt
        add $s0,$s0,1   #i++
        j loop  
    end_r:
        move $a0,$s1    #back to main
        jr $ra
    
test:
    la $a0,line
    li $v0,4
    syscall

    jr $ra

               

.data
    op: .space 4
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
    pinA: .space 40    #pinA[10]
    pinB: .space 40    #pinB[10]
    pinlen: .word 10    #pin.length = 10
    sparselen: .word 20    #sparse.length = 20
    pos: .asciiz "Position "
    sem: .asciiz ": "