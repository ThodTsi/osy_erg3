.text
    main:
        
        main_loop:
            jal read_option
            sw $v0,op
            lw $t0,op
            blt $t0,1,exit      #elegxos while
            bgt $t0,8,exit
            case_1:
                bne $t0,1,case_2
                la $a0,c1
                li $v0,4
                syscall
                j read_op
            case_2:
                bne $t0,2,case_3
                la $a0,c2
                li $v0,4
                syscall
                j read_op
            case_3:
                bne $t0,3,case_4
                la $a0,c3
                li $v0,4
                syscall
                j read_op
            case_4:
                bne $t0,4,case_5
                la $a0,c4
                li $v0,4
                syscall
                j read_op
            case_5:
                bne $t0,5,case_6
                la $a0,c5
                li $v0,4
                syscall
                j read_op
            case_6:
                bne $t0,6,case_7
                la $a0,c6
                li $v0,4
                syscall
                j read_op
            case_7:
                bne $t0,7,case_8
                la $a0,c7
                li $v0,4
                syscall
                j read_op
            case_8:
                bne $t0,8,read_op
                la $a0,c8
                li $v0,4
                syscall
                j read_op


            read_op:
                j main_loop


    exit:
        la $a0,w
        li $v0,4
        syscall
        li $v0,10
        syscall

    read_option:
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
        move $v0,$v0
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

