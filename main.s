	.file	"main.cpp"
	.text
	.align 2
	.p2align 4,,15
	.type	_ZN8BMP_file14sse_blend_withERKS_jj.constprop.21, @function
_ZN8BMP_file14sse_blend_withERKS_jj.constprop.21:
.LFB8664:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	20(%rsi), %eax
	movl	20(%rsi), %edx
	sarl	$31, %eax
	xorl	%eax, %edx
	subl	%eax, %edx
	movl	24(%rsi), %eax
	leal	100(%rdx), %r15d
	movl	24(%rsi), %edx
	movl	24(%rdi), %esi
	sarl	$31, %eax
	xorl	%eax, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	addl	$100, %eax
	testl	%esi, %esi
	movl	%eax, -12(%rsp)
	je	.L1
	movl	20(%rdi), %r10d
	xorl	%edx, %edx
	xorl	%r11d, %r11d
	movdqa	.LC0(%rip), %xmm5
	movq	%r13, %r14
	movdqa	.LC1(%rip), %xmm4
	movdqa	.LC2(%rip), %xmm3
	movdqa	.LC3(%rip), %xmm7
	movdqa	.LC4(%rip), %xmm6
	.p2align 4,,10
	.p2align 3
.L7:
	movl	%r10d, %ecx
	sarl	$31, %ecx
	movl	%ecx, %eax
	xorl	%r10d, %eax
	subl	%ecx, %eax
	cmpl	$4, %eax
	jle	.L8
	cmpl	$99, %r11d
	movl	$4, %r8d
	seta	%bl
	cmpl	%r11d, -12(%rsp)
	seta	%al
	andl	%eax, %ebx
	leal	-100(%r11), %eax
	movl	%eax, -16(%rsp)
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L5:
	movl	%ecx, %edx
	movl	%eax, %r8d
.L4:
	movl	%r10d, %r9d
	leal	4(%r8), %eax
	leal	4(%rdx), %ecx
	sarl	$31, %r9d
	movl	%r9d, %esi
	xorl	%r10d, %esi
	subl	%r9d, %esi
	cmpl	%esi, %eax
	jnb	.L24
	cmpl	$99, %r8d
	jbe	.L5
	cmpl	%eax, %r15d
	jbe	.L5
	testb	%bl, %bl
	je	.L5
	movq	152(%rdi), %r10
	movl	%ecx, %esi
	movq	152(%r14), %r9
	leal	6(%rdx), %r13d
	leaq	(%r10,%rsi,4), %rbp
	movl	-16(%rsp), %esi
	movd	(%r10,%r13,4), %xmm1
	imull	20(%r14), %esi
	movd	0(%rbp), %xmm0
	leal	-100(%r8,%rsi), %esi
	addq	$3, %rsi
	leaq	0(,%rsi,4), %r12
	movl	(%r9,%rsi,4), %esi
	movl	-4(%r9,%r12), %r8d
	movl	%r8d, -40(%rsp)
	movl	-8(%r9,%r12), %r8d
	movl	-12(%r9,%r12), %r9d
	leal	5(%rdx), %r12d
	addl	$7, %edx
	pinsrd	$1, (%r10,%rdx,4), %xmm1
	movd	-40(%rsp), %xmm2
	movl	-40(%rsp), %edx
	pinsrd	$1, (%r10,%r12,4), %xmm0
	movl	%r9d, -40(%rsp)
	shrl	$24, %r9d
	shrl	$24, %edx
	pinsrd	$1, %esi, %xmm2
	movl	%edx, %r12d
	shrl	$24, %esi
	notl	%r9d
	notl	%esi
	notl	%r12d
	movzbl	%r9b, %r10d
	punpcklqdq	%xmm1, %xmm0
	movq	%r10, %r9
	salq	$16, %r10
	orq	%r9, %r10
	movdqa	%xmm0, %xmm1
	pshufb	%xmm4, %xmm0
	salq	$16, %r10
	orq	%r9, %r10
	pshufb	%xmm5, %xmm1
	movdqa	%xmm0, %xmm9
	movd	-40(%rsp), %xmm0
	salq	$16, %r10
	pinsrd	$1, %r8d, %xmm0
	shrl	$24, %r8d
	orq	%r9, %r10
	notl	%r8d
	salq	$8, %r10
	movzbl	%r8b, %edx
	movq	%r10, -40(%rsp)
	movq	%rdx, %r8
	salq	$16, %rdx
	orq	%r8, %rdx
	punpcklqdq	%xmm2, %xmm0
	salq	$16, %rdx
	orq	%r8, %rdx
	salq	$16, %rdx
	movdqa	%xmm0, %xmm8
	orq	%r8, %rdx
	movzbl	%r12b, %r8d
	salq	$8, %rdx
	movq	%r8, %r12
	salq	$16, %r8
	movq	%rdx, -32(%rsp)
	movzbl	%sil, %edx
	orq	%r12, %r8
	movq	%rdx, %rsi
	salq	$16, %rdx
	salq	$16, %r8
	orq	%rsi, %rdx
	orq	%r12, %r8
	pmulhuw	-40(%rsp), %xmm1
	salq	$16, %rdx
	salq	$16, %r8
	orq	%rsi, %rdx
	movdqa	%xmm0, %xmm2
	salq	$16, %rdx
	orq	%r12, %r8
	orq	%rsi, %rdx
	salq	$8, %r8
	salq	$8, %rdx
	pshufb	%xmm5, %xmm8
	pshufb	%xmm4, %xmm2
	movq	%r8, -40(%rsp)
	movq	%rdx, -32(%rsp)
	movdqa	-40(%rsp), %xmm0
	paddq	%xmm8, %xmm1
	paddq	%xmm3, %xmm1
	pshufb	%xmm7, %xmm1
	pmulhuw	%xmm9, %xmm0
	paddq	%xmm2, %xmm0
	paddq	%xmm3, %xmm0
	pshufb	%xmm6, %xmm0
	por	%xmm1, %xmm0
	movups	%xmm0, 0(%rbp)
	movl	20(%rdi), %r10d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L24:
	movl	24(%rdi), %esi
.L3:
	leal	1(%rcx), %edx
	movl	%esi, %ecx
	addl	$1, %r11d
	sarl	$31, %ecx
	movl	%ecx, %eax
	xorl	%esi, %eax
	subl	%ecx, %eax
	cmpl	%r11d, %eax
	ja	.L7
.L1:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore_state
	movl	%edx, %ecx
	jmp	.L3
	.cfi_endproc
.LFE8664:
	.size	_ZN8BMP_file14sse_blend_withERKS_jj.constprop.21, .-_ZN8BMP_file14sse_blend_withERKS_jj.constprop.21
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"rb"
.LC6:
	.string	"No such file in the folder!\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC7:
	.string	"Type is wrong. Check out: it should be BMP-file!"
	.align 8
.LC8:
	.string	"Error! The file is damaged! The reserved bytes should contain only zero!"
	.align 8
.LC9:
	.string	"Expected '1' in bcPlanes in BMP picture!"
	.align 8
.LC10:
	.string	"Sorry! I know only 32-bit format!"
	.align 8
.LC11:
	.string	"The file is damaged! The field bV5Reserved should be equal 0!"
	.section	.rodata.str1.1
.LC12:
	.string	"Warning! %s\n"
	.text
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_file9load_fileEPKc
	.type	_ZN8BMP_file9load_fileEPKc, @function
_ZN8BMP_file9load_fileEPKc:
.LFB8083:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8083
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	.LC5(%rip), %rsi
	movq	%rdi, %rbx
	movq	%r12, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.LEHB0:
	call	fopen@PLT
.LEHE0:
	testq	%rax, %rax
	movq	%rax, %rbp
	je	.L78
	movq	%r12, %rdi
	call	strlen@PLT
	movq	%rax, %rdi
.LEHB1:
	call	_Znam@PLT
	movq	%rax, %rdi
	movq	%rax, 160(%rbx)
	movq	%r12, %rcx
	movq	$-1, %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__sprintf_chk@PLT
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$2, %esi
	movq	%rbx, %rdi
	call	fread@PLT
	movzwl	(%rbx), %eax
	cmpw	$16973, %ax
	je	.L27
	cmpw	$19778, %ax
	jne	.L79
.L27:
	leaq	4(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	8(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	movl	8(%rbx), %esi
	testl	%esi, %esi
	jne	.L80
	leaq	12(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	16(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	xorl	%r12d, %r12d
	cmpl	$12, 16(%rbx)
	leaq	20(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	setne	%r12b
	leaq	2(%r12,%r12), %r12
	movq	%r12, %rsi
	call	fread@PLT
	leaq	24(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movq	%r12, %rsi
	call	fread@PLT
	leaq	28(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fread@PLT
	cmpw	$0, 28(%rbx)
	je	.L81
	leaq	30(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fread@PLT
	cmpw	$32, 30(%rbx)
	jne	.L82
	cmpl	$12, 16(%rbx)
	jbe	.L34
	leaq	32(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	36(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	40(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	44(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	48(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	52(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	cmpl	$107, 16(%rbx)
	jbe	.L34
	leaq	56(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	60(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	64(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	68(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	72(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	76(%rbx), %r12
	leaq	112(%rbx), %r13
	.p2align 4,,10
	.p2align 3
.L33:
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	movq	%r12, %rdi
	call	fread@PLT
	addq	$4, %r12
	cmpq	%r12, %r13
	jne	.L33
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	movq	%r13, %rdi
	call	fread@PLT
	leaq	116(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	120(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	cmpl	$124, 16(%rbx)
	jne	.L34
	leaq	124(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	128(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	132(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	leaq	136(%rbx), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	movl	136(%rbx), %ecx
	testl	%ecx, %ecx
	jne	.L83
.L34:
	movl	12(%rbx), %esi
	movq	%rbp, %rdi
	xorl	%edx, %edx
	call	fseek@PLT
	movl	20(%rbx), %r12d
	imull	24(%rbx), %r12d
	movl	%r12d, %eax
	sarl	$31, %eax
	xorl	%eax, %r12d
	subl	%eax, %r12d
	movzwl	30(%rbx), %eax
	movl	%r12d, 140(%rbx)
	movslq	%r12d, %r12
	leaq	0(,%r12,4), %rdi
	shrw	$3, %ax
	movzwl	%ax, %eax
	movl	%eax, 144(%rbx)
	call	_Znam@PLT
	leaq	-1(%r12), %rdi
	cmpq	$-1, %rdi
	movq	%rdi, %rcx
	je	.L35
	cmpq	$2, %rdi
	jbe	.L49
	pxor	%xmm0, %xmm0
	movq	%r12, %rsi
	movq	%rax, %rcx
	shrq	$2, %rsi
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L37:
	addq	$1, %rdx
	addq	$16, %rcx
	movups	%xmm0, -16(%rcx)
	cmpq	%rsi, %rdx
	jb	.L37
	movq	%r12, %rdx
	movq	%rdi, %rcx
	andq	$-4, %rdx
	subq	%rdx, %rcx
	cmpq	%rdx, %r12
	leaq	(%rax,%rdx,4), %rsi
	je	.L35
.L36:
	testq	%rcx, %rcx
	movl	$0, (%rsi)
	je	.L35
	cmpq	$1, %rcx
	movl	$0, 4(%rsi)
	je	.L35
	movl	$0, 8(%rsi)
.L35:
	movl	140(%rbx), %edx
	movq	%rax, 152(%rbx)
	testl	%edx, %edx
	je	.L39
	xorl	%r12d, %r12d
	xorl	%r13d, %r13d
	.p2align 4,,10
	.p2align 3
.L42:
	leaq	(%rax,%r12), %rdi
	movq	%rbp, %rcx
	movl	$4, %edx
	movl	$1, %esi
	call	fread@PLT
	movq	152(%rbx), %rax
	movl	144(%rbx), %r14d
	leaq	(%rax,%r12), %rdi
	subl	$1, %r14d
	movzbl	3(%rdi), %r8d
	je	.L40
	movzbl	2(%rdi), %ecx
	movzbl	1(%rdi), %edx
	xorl	%r9d, %r9d
	movzbl	(%rdi), %r15d
	.p2align 4,,10
	.p2align 3
.L41:
	movzbl	%cl, %r11d
	movzbl	%dl, %r10d
	movzbl	%r15b, %esi
	addl	$1, %r11d
	addl	$1, %r10d
	addl	$1, %esi
	imull	%r8d, %r11d
	addl	$1, %r9d
	imull	%r8d, %r10d
	sarl	$8, %r11d
	imull	%r8d, %esi
	sarl	$8, %r10d
	movl	%r11d, %ecx
	movl	%r10d, %edx
	sarl	$8, %esi
	cmpl	%r14d, %r9d
	movl	%esi, %r15d
	jne	.L41
	movb	%r11b, 2(%rdi)
	movb	%r10b, 1(%rdi)
	movb	%sil, (%rdi)
	.p2align 4,,10
	.p2align 3
.L40:
	addl	$1, %r13d
	addq	$4, %r12
	cmpl	%r13d, 140(%rbx)
	ja	.L42
.L39:
	movq	%rbp, %rdi
	call	fclose@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L49:
	.cfi_restore_state
	movq	%rax, %rsi
	jmp	.L36
.L80:
	movl	$8, %edi
	leaq	.LC8(%rip), %rbx
	call	__cxa_allocate_exception@PLT
	leaq	_ZTIPKc(%rip), %rsi
	movq	%rbx, (%rax)
	xorl	%edx, %edx
	movq	%rax, %rdi
	call	__cxa_throw@PLT
.L79:
	movl	$8, %edi
	leaq	.LC7(%rip), %rbx
	call	__cxa_allocate_exception@PLT
	leaq	_ZTIPKc(%rip), %rsi
	movq	%rbx, (%rax)
	xorl	%edx, %edx
	movq	%rax, %rdi
	call	__cxa_throw@PLT
.LEHE1:
.L50:
.L44:
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L77
	call	__cxa_begin_catch@PLT
	leaq	.LC12(%rip), %rsi
	movq	%rax, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
.LEHB2:
	call	__printf_chk@PLT
	movq	%rbp, %rdi
	call	fclose@PLT
.LEHE2:
	popq	%rax
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	__cxa_end_catch@PLT
.L78:
	.cfi_restore_state
	movl	$8, %edi
	leaq	.LC6(%rip), %rbx
	call	__cxa_allocate_exception@PLT
	leaq	_ZTIPKc(%rip), %rsi
	movq	%rbx, (%rax)
	xorl	%edx, %edx
	movq	%rax, %rdi
.LEHB3:
	call	__cxa_throw@PLT
.LEHE3:
.L51:
	movq	%rax, %rbx
	call	__cxa_end_catch@PLT
	movq	%rbx, %rdi
.L77:
.LEHB4:
	call	_Unwind_Resume@PLT
.LEHE4:
.L82:
	movl	$8, %edi
	leaq	.LC10(%rip), %rbx
	call	__cxa_allocate_exception@PLT
	leaq	_ZTIPKc(%rip), %rsi
	movq	%rbx, (%rax)
	xorl	%edx, %edx
	movq	%rax, %rdi
.LEHB5:
	call	__cxa_throw@PLT
.L81:
	movl	$8, %edi
	leaq	.LC9(%rip), %rbx
	call	__cxa_allocate_exception@PLT
	leaq	_ZTIPKc(%rip), %rsi
	movq	%rbx, (%rax)
	xorl	%edx, %edx
	movq	%rax, %rdi
	call	__cxa_throw@PLT
.L83:
	movl	$8, %edi
	leaq	.LC11(%rip), %rbx
	call	__cxa_allocate_exception@PLT
	leaq	_ZTIPKc(%rip), %rsi
	movq	%rbx, (%rax)
	xorl	%edx, %edx
	movq	%rax, %rdi
	call	__cxa_throw@PLT
.LEHE5:
.L52:
	xorl	%ebp, %ebp
	jmp	.L44
	.cfi_endproc
.LFE8083:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
	.align 4
.LLSDA8083:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT8083-.LLSDATTD8083
.LLSDATTD8083:
	.byte	0x1
	.uleb128 .LLSDACSE8083-.LLSDACSB8083
.LLSDACSB8083:
	.uleb128 .LEHB0-.LFB8083
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L52-.LFB8083
	.uleb128 0x1
	.uleb128 .LEHB1-.LFB8083
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L50-.LFB8083
	.uleb128 0x1
	.uleb128 .LEHB2-.LFB8083
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L51-.LFB8083
	.uleb128 0
	.uleb128 .LEHB3-.LFB8083
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L50-.LFB8083
	.uleb128 0x1
	.uleb128 .LEHB4-.LFB8083
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB8083
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L50-.LFB8083
	.uleb128 0x1
.LLSDACSE8083:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref._ZTIPKc-.
.LLSDATT8083:
	.text
	.size	_ZN8BMP_file9load_fileEPKc, .-_ZN8BMP_file9load_fileEPKc
	.section	.rodata.str1.8
	.align 8
.LC13:
	.string	"Error! Wrong coordinates in 'fill_ARGB'!"
	.text
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_file10blend_withERKS_jj
	.type	_ZN8BMP_file10blend_withERKS_jj, @function
_ZN8BMP_file10blend_withERKS_jj:
.LFB8089:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	24(%rdi), %eax
	movq	152(%rdi), %r15
	movl	%eax, %r8d
	sarl	$31, %r8d
	movl	%r8d, %ebx
	xorl	%eax, %ebx
	subl	%r8d, %ebx
	testl	%eax, %eax
	movl	%ebx, -12(%rsp)
	je	.L84
	movl	20(%rdi), %r13d
	xorl	%r12d, %r12d
	xorl	%r10d, %r10d
	movl	%r13d, %eax
	sarl	$31, %eax
	movl	%eax, %r8d
	xorl	%r13d, %r8d
	subl	%eax, %r8d
	.p2align 4,,10
	.p2align 3
.L93:
	testl	%r13d, %r13d
	je	.L86
	movl	%r10d, %r14d
	xorl	%edi, %edi
	subl	%ecx, %r14d
	jmp	.L92
	.p2align 4,,10
	.p2align 3
.L87:
	addl	$1, %edi
	cmpl	%edi, %r8d
	je	.L86
.L92:
	cmpl	%edi, %edx
	ja	.L87
	movl	20(%rsi), %r9d
	movl	%r9d, %r11d
	sarl	$31, %r11d
	movl	%r11d, %eax
	xorl	%r9d, %eax
	subl	%r11d, %eax
	addl	%edx, %eax
	cmpl	%edi, %eax
	jbe	.L87
	cmpl	%r10d, %ecx
	ja	.L87
	movl	24(%rsi), %r11d
	movl	24(%rsi), %eax
	sarl	$31, %r11d
	xorl	%r11d, %eax
	subl	%r11d, %eax
	addl	%ecx, %eax
	cmpl	%r10d, %eax
	jbe	.L87
	imull	%r14d, %r9d
	movq	152(%rsi), %rax
	subl	%edx, %r9d
	addl	%edi, %r9d
	leaq	(%rax,%r9,4), %r11
	movl	(%r11), %eax
	movl	%eax, (%r15)
	leal	(%rdi,%r12), %eax
	movzbl	3(%r11), %ebx
	leaq	(%r15,%rax,4), %r9
	movzbl	3(%r9), %eax
	movl	%ebx, %ebp
	notl	%ebp
	imull	%ebp, %eax
	addl	%ebx, %eax
	testb	%al, %al
	movb	%al, 3(%r9)
	je	.L110
	movzbl	2(%r9), %eax
	movzbl	%bpl, %ebp
	movzbl	1(%r9), %ebx
	addl	$1, %edi
	imull	%ebp, %eax
	imull	%ebp, %ebx
	addl	$1, %eax
	sarl	$8, %eax
	addb	2(%r11), %al
	addl	$1, %ebx
	sarl	$8, %ebx
	movb	%al, 2(%r9)
	movzbl	(%r9), %eax
	addb	1(%r11), %bl
	imull	%ebp, %eax
	movb	%bl, 1(%r9)
	addl	$1, %eax
	sarl	$8, %eax
	addb	(%r11), %al
	cmpl	%edi, %r8d
	movb	%al, (%r9)
	jne	.L92
	.p2align 4,,10
	.p2align 3
.L86:
	addl	$1, %r10d
	addl	%r13d, %r12d
	cmpl	-12(%rsp), %r10d
	jne	.L93
.L84:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L110:
	.cfi_restore_state
	cmpl	-12(%rsp), %r10d
	ja	.L94
	cmpl	%edi, %r8d
	jb	.L94
	imull	%r10d, %r8d
	leal	(%r8,%rdi), %eax
	movl	$0, (%r15,%rax,4)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L94:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	leaq	.LC13(%rip), %rdi
	jmp	puts@PLT
	.cfi_endproc
.LFE8089:
	.size	_ZN8BMP_file10blend_withERKS_jj, .-_ZN8BMP_file10blend_withERKS_jj
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_file14sse_blend_withERKS_jj
	.type	_ZN8BMP_file14sse_blend_withERKS_jj, @function
_ZN8BMP_file14sse_blend_withERKS_jj:
.LFB8091:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	20(%rsi), %eax
	movl	20(%rsi), %esi
	movl	%ecx, -20(%rsp)
	sarl	$31, %eax
	xorl	%eax, %esi
	subl	%eax, %esi
	movl	24(%r13), %eax
	leal	(%rsi,%rdx), %r12d
	movl	24(%r13), %esi
	sarl	$31, %eax
	xorl	%eax, %esi
	subl	%eax, %esi
	movl	%esi, %eax
	addl	%ecx, %eax
	movl	24(%rdi), %ecx
	movl	%eax, -24(%rsp)
	testl	%ecx, %ecx
	je	.L111
	movl	20(%rdi), %r8d
	movq	%rdi, %r14
	xorl	%r15d, %r15d
	movdqa	.LC0(%rip), %xmm6
	xorl	%esi, %esi
	movq	%r13, -16(%rsp)
	movdqa	.LC1(%rip), %xmm5
	movdqa	.LC2(%rip), %xmm4
	movdqa	.LC3(%rip), %xmm8
	movdqa	.LC4(%rip), %xmm7
	.p2align 4,,10
	.p2align 3
.L116:
	movl	%r8d, %edi
	sarl	$31, %edi
	movl	%edi, %eax
	xorl	%r8d, %eax
	subl	%edi, %eax
	cmpl	$4, %eax
	jle	.L113
	movl	-20(%rsp), %ebx
	movl	%r15d, %edi
	cmpl	%r15d, %ebx
	setbe	%cl
	cmpl	%r15d, -24(%rsp)
	seta	%al
	subl	%ebx, %edi
	andl	%eax, %ecx
	movl	%edi, -28(%rsp)
	movl	$4, %eax
	movb	%cl, -29(%rsp)
	xorl	%ecx, %ecx
	jmp	.L115
	.p2align 4,,10
	.p2align 3
.L114:
	movl	%r8d, %r9d
	addl	$4, %eax
	addl	$4, %esi
	sarl	$31, %r9d
	addl	$4, %ecx
	movl	%r9d, %edi
	xorl	%r8d, %edi
	subl	%r9d, %edi
	cmpl	%edi, %eax
	jnb	.L132
.L115:
	cmpl	%ecx, %edx
	ja	.L114
	cmpl	%eax, %r12d
	jbe	.L114
	cmpb	$0, -29(%rsp)
	je	.L114
	movq	152(%r14), %r10
	movq	-16(%rsp), %rbx
	movl	%esi, %edi
	leal	2(%rsi), %ebp
	leaq	(%r10,%rdi,4), %r13
	movl	-28(%rsp), %edi
	movq	152(%rbx), %r9
	imull	20(%rbx), %edi
	movd	(%r10,%rbp,4), %xmm1
	movd	0(%r13), %xmm0
	subl	%edx, %edi
	addl	%ecx, %edi
	addq	$3, %rdi
	leaq	0(,%rdi,4), %r11
	movl	(%r9,%rdi,4), %edi
	movl	-4(%r9,%r11), %ebx
	movl	-8(%r9,%r11), %r8d
	movl	-12(%r9,%r11), %r9d
	leal	1(%rsi), %r11d
	movl	%ebx, -56(%rsp)
	leal	3(%rsi), %ebx
	movd	-56(%rsp), %xmm3
	pinsrd	$1, (%r10,%rbx,4), %xmm1
	movl	-56(%rsp), %ebx
	movl	%r9d, -56(%rsp)
	shrl	$24, %r9d
	notl	%r9d
	pinsrd	$1, (%r10,%r11,4), %xmm0
	movzbl	%r9b, %r10d
	movl	%r8d, %r11d
	movq	%r10, %r9
	salq	$16, %r10
	shrl	$24, %r11d
	orq	%r9, %r10
	notl	%r11d
	shrl	$24, %ebx
	salq	$16, %r10
	notl	%ebx
	orq	%r9, %r10
	punpcklqdq	%xmm1, %xmm0
	salq	$16, %r10
	pinsrd	$1, %edi, %xmm3
	orq	%r9, %r10
	movzbl	%r11b, %r9d
	shrl	$24, %edi
	movq	%r9, %r11
	salq	$16, %r9
	notl	%edi
	orq	%r11, %r9
	movdqa	%xmm0, %xmm1
	salq	$16, %r9
	movdqa	%xmm0, %xmm2
	orq	%r11, %r9
	movd	-56(%rsp), %xmm0
	salq	$8, %r10
	salq	$16, %r9
	pshufb	%xmm6, %xmm1
	orq	%r11, %r9
	pinsrd	$1, %r8d, %xmm0
	salq	$8, %r9
	movq	%r10, -56(%rsp)
	movq	%r9, -48(%rsp)
	movzbl	%bl, %r9d
	movq	%r9, %r8
	salq	$16, %r9
	pmulhuw	-56(%rsp), %xmm1
	orq	%r8, %r9
	punpcklqdq	%xmm3, %xmm0
	salq	$16, %r9
	pshufb	%xmm5, %xmm2
	orq	%r8, %r9
	salq	$16, %r9
	movdqa	%xmm0, %xmm9
	orq	%r8, %r9
	movzbl	%dil, %r8d
	movq	%r8, %rdi
	salq	$16, %r8
	movdqa	%xmm0, %xmm3
	orq	%rdi, %r8
	pshufb	%xmm6, %xmm9
	salq	$16, %r8
	pshufb	%xmm5, %xmm3
	orq	%rdi, %r8
	salq	$16, %r8
	salq	$8, %r9
	movdqa	%xmm9, %xmm0
	orq	%rdi, %r8
	movq	%r9, -56(%rsp)
	salq	$8, %r8
	paddq	%xmm1, %xmm0
	paddq	%xmm4, %xmm0
	movdqa	%xmm0, %xmm1
	movdqa	%xmm3, %xmm0
	movq	%r8, -48(%rsp)
	pmulhuw	-56(%rsp), %xmm2
	pshufb	%xmm8, %xmm1
	paddq	%xmm2, %xmm0
	paddq	%xmm4, %xmm0
	pshufb	%xmm7, %xmm0
	por	%xmm1, %xmm0
	movups	%xmm0, 0(%r13)
	movl	20(%r14), %r8d
	jmp	.L114
	.p2align 4,,10
	.p2align 3
.L132:
	movl	24(%r14), %ecx
.L113:
	movl	%ecx, %edi
	leal	1(%r15), %r9d
	addl	$1, %esi
	sarl	$31, %edi
	addq	$1, %r15
	movl	%edi, %eax
	xorl	%ecx, %eax
	subl	%edi, %eax
	cmpl	%r9d, %eax
	ja	.L116
.L111:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE8091:
	.size	_ZN8BMP_file14sse_blend_withERKS_jj, .-_ZN8BMP_file14sse_blend_withERKS_jj
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_file14asm_blend_withERKS_jj
	.type	_ZN8BMP_file14asm_blend_withERKS_jj, @function
_ZN8BMP_file14asm_blend_withERKS_jj:
.LFB8092:
	.cfi_startproc
	rep ret
	.cfi_endproc
.LFE8092:
	.size	_ZN8BMP_file14asm_blend_withERKS_jj, .-_ZN8BMP_file14asm_blend_withERKS_jj
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_file16set_transparencyEh
	.type	_ZN8BMP_file16set_transparencyEh, @function
_ZN8BMP_file16set_transparencyEh:
.LFB8093:
	.cfi_startproc
	movl	140(%rdi), %eax
	testl	%eax, %eax
	je	.L134
	movq	152(%rdi), %rcx
	subl	$1, %eax
	movzbl	%sil, %r8d
	leaq	4(%rcx), %rdi
	leaq	(%rdi,%rax,4), %r9
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L145:
	addq	$4, %rdi
.L137:
	movzbl	3(%rcx), %r10d
	testb	%r10b, %r10b
	je	.L136
	movzbl	(%rcx), %eax
	movb	%sil, 3(%rcx)
	sall	$8, %eax
	cltd
	idivl	%r10d
	addl	$1, %eax
	imull	%r8d, %eax
	movb	%ah, (%rcx)
	movzbl	2(%rcx), %eax
	sall	$8, %eax
	cltd
	idivl	%r10d
	addl	$1, %eax
	imull	%r8d, %eax
	movb	%ah, 2(%rcx)
	movzbl	1(%rcx), %eax
	sall	$8, %eax
	cltd
	idivl	%r10d
	addl	$1, %eax
	imull	%r8d, %eax
	movb	%ah, 1(%rcx)
.L136:
	cmpq	%rdi, %r9
	movq	%rdi, %rcx
	jne	.L145
.L134:
	rep ret
	.cfi_endproc
.LFE8093:
	.size	_ZN8BMP_file16set_transparencyEh, .-_ZN8BMP_file16set_transparencyEh
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_fileD2Ev
	.type	_ZN8BMP_fileD2Ev, @function
_ZN8BMP_fileD2Ev:
.LFB8095:
	.cfi_startproc
	movq	152(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L146
	jmp	_ZdaPv@PLT
	.p2align 4,,10
	.p2align 3
.L146:
	rep ret
	.cfi_endproc
.LFE8095:
	.size	_ZN8BMP_fileD2Ev, .-_ZN8BMP_fileD2Ev
	.globl	_ZN8BMP_fileD1Ev
	.set	_ZN8BMP_fileD1Ev,_ZN8BMP_fileD2Ev
	.section	.rodata.str1.1
.LC15:
	.string	"Without SSE: %g seconds.\n"
.LC16:
	.string	"With SSE: %g seconds.\n"
.LC17:
	.string	"SSE is faster in: %.2g times\n"
	.text
	.p2align 4,,15
	.globl	_Z12time_testingR8BMP_fileS0_
	.type	_Z12time_testingR8BMP_fileS0_, @function
_Z12time_testingR8BMP_fileS0_:
.LFB8101:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	call	clock@PLT
	movl	$1000, (%rsp)
	movq	%rax, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L159:
	movl	24(%r13), %eax
	movq	152(%r13), %r14
	cltd
	movl	%edx, %r15d
	xorl	%eax, %r15d
	subl	%edx, %r15d
	testl	%eax, %eax
	je	.L156
	movl	20(%r13), %ebp
	xorl	%r11d, %r11d
	xorl	%edi, %edi
	movl	%ebp, %eax
	sarl	$31, %eax
	movl	%eax, %ecx
	xorl	%ebp, %ecx
	subl	%eax, %ecx
	.p2align 4,,10
	.p2align 3
.L151:
	xorl	%esi, %esi
	testl	%ebp, %ebp
	leal	-100(%rdi), %r8d
	je	.L157
	leal	1(%rsi), %edx
	cmpl	%ecx, %edx
	je	.L157
	.p2align 4,,10
	.p2align 3
.L175:
	cmpl	$99, %edx
	jbe	.L152
	movl	20(%rbx), %r9d
	movl	%r9d, %r10d
	sarl	$31, %r10d
	movl	%r10d, %eax
	xorl	%r9d, %eax
	subl	%r10d, %eax
	addl	$100, %eax
	cmpl	%edx, %eax
	jbe	.L152
	cmpl	$99, %edi
	ja	.L178
.L152:
	movl	%edx, %esi
.L180:
	leal	1(%rsi), %edx
	cmpl	%ecx, %edx
	jne	.L175
.L157:
	addl	$1, %edi
	addl	%ebp, %r11d
	cmpl	%edi, %r15d
	jne	.L151
.L156:
	subl	$1, (%rsp)
	jne	.L159
.L181:
	call	clock@PLT
	subq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	leaq	.LC15(%rip), %rsi
	movl	$1, %edi
	movl	$1000, %ebp
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	divsd	.LC14(%rip), %xmm0
	movsd	%xmm0, (%rsp)
	call	__printf_chk@PLT
	call	clock@PLT
	movq	%rax, %r12
	.p2align 4,,10
	.p2align 3
.L160:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	_ZN8BMP_file14sse_blend_withERKS_jj.constprop.21
	subl	$1, %ebp
	jne	.L160
	call	clock@PLT
	pxor	%xmm1, %xmm1
	subq	%r12, %rax
	leaq	.LC16(%rip), %rsi
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	divsd	.LC14(%rip), %xmm1
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 8(%rsp)
	call	__printf_chk@PLT
	movsd	(%rsp), %xmm0
	leaq	.LC17(%rip), %rsi
	movsd	8(%rsp), %xmm1
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	divsd	%xmm1, %xmm0
	movl	$1, %edi
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L178:
	.cfi_restore_state
	movl	24(%rbx), %r10d
	movl	24(%rbx), %eax
	sarl	$31, %r10d
	xorl	%r10d, %eax
	subl	%r10d, %eax
	addl	$100, %eax
	cmpl	%edi, %eax
	jbe	.L152
	imull	%r8d, %r9d
	movq	152(%rbx), %rax
	leal	-99(%rsi,%r9), %esi
	leaq	(%rax,%rsi,4), %r9
	movl	(%r9), %eax
	movl	%eax, (%r14)
	leal	(%rdx,%r11), %eax
	movzbl	3(%r9), %r10d
	leaq	(%r14,%rax,4), %rsi
	movzbl	3(%rsi), %eax
	movl	%r10d, %r12d
	notl	%r12d
	imull	%r12d, %eax
	addl	%r10d, %eax
	testb	%al, %al
	movb	%al, 3(%rsi)
	je	.L179
	movzbl	2(%rsi), %eax
	movzbl	%r12b, %r12d
	movzbl	1(%rsi), %r10d
	imull	%r12d, %eax
	imull	%r12d, %r10d
	addl	$1, %eax
	sarl	$8, %eax
	addb	2(%r9), %al
	addl	$1, %r10d
	sarl	$8, %r10d
	movb	%al, 2(%rsi)
	movzbl	(%rsi), %eax
	addb	1(%r9), %r10b
	imull	%r12d, %eax
	movb	%r10b, 1(%rsi)
	addl	$1, %eax
	sarl	$8, %eax
	addb	(%r9), %al
	movb	%al, (%rsi)
	movl	%edx, %esi
	jmp	.L180
.L179:
	cmpl	%ecx, %edx
	ja	.L162
	cmpl	%edi, %r15d
	jb	.L162
	imull	%edi, %ecx
	subl	$1, (%rsp)
	leal	(%rcx,%rdx), %eax
	movl	$0, (%r14,%rax,4)
	jne	.L159
	jmp	.L181
	.p2align 4,,10
	.p2align 3
.L162:
	leaq	.LC13(%rip), %rdi
	call	puts@PLT
	subl	$1, (%rsp)
	jne	.L159
	jmp	.L181
	.cfi_endproc
.LFE8101:
	.size	_Z12time_testingR8BMP_fileS0_, .-_Z12time_testingR8BMP_fileS0_
	.section	.rodata.str1.1
.LC19:
	.string	"result_%d.bmp"
	.text
	.align 2
	.p2align 4,,15
	.globl	_ZN8BMP_file4drawEv
	.type	_ZN8BMP_file4drawEv, @function
_ZN8BMP_file4drawEv:
.LFB8084:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8084
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$1032, %rsp
	.cfi_def_cfa_offset 1088
	leaq	32(%rsp), %rbx
	movdqa	.LC18(%rip), %xmm0
	leaq	176(%rsp), %r15
	movl	$1, 112(%rsp)
	movl	$0, 116(%rsp)
	movq	%rbx, %rdi
	movb	$0, 120(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 1016(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 96(%rsp)
	call	_ZNSt6localeC1Ev@PLT
	movq	%rbx, %rdx
	movq	%r15, %rdi
	movq	160(%r14), %rsi
	movq	%r15, 16(%rsp)
.LEHB6:
	call	_ZN2sf6StringC1EPKcRKSt6locale@PLT
.LEHE6:
	movl	24(%r14), %eax
	movl	24(%r14), %edx
	movl	20(%r14), %esi
	movzwl	30(%r14), %ecx
	sarl	$31, %eax
	xorl	%eax, %edx
	subl	%eax, %edx
	movl	20(%r14), %eax
	sarl	$31, %eax
	xorl	%eax, %esi
	subl	%eax, %esi
	leaq	64(%rsp), %rax
	movq	%rax, %rdi
	movq	%rax, (%rsp)
.LEHB7:
	call	_ZN2sf9VideoModeC1Ejjj@PLT
	leaq	96(%rsp), %rax
	leaq	464(%rsp), %r13
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movl	$7, %r8d
	movq	%r15, %rcx
	movq	%rax, %r9
	movq	%r13, %rdi
	movq	%rax, 24(%rsp)
	call	_ZN2sf12RenderWindowC1ENS_9VideoModeERKNS_6StringEjRKNS_15ContextSettingsE@PLT
.LEHE7:
	movq	176(%rsp), %rdi
	leaq	16(%r15), %rax
	cmpq	%rax, %rdi
	je	.L183
	call	_ZdlPv@PLT
.L183:
	movq	%rbx, %rdi
	call	_ZNSt6localeD1Ev@PLT
	movq	(%rsp), %rbp
	movq	%rbp, %rdi
.LEHB8:
	call	_ZN2sf5ImageC1Ev@PLT
.LEHE8:
	movq	24(%rsp), %r15
	movl	$255, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%r15, %rdi
.LEHB9:
	call	_ZN2sf5ColorC1Ehhhh@PLT
	movl	24(%r14), %eax
	movl	24(%r14), %edx
	movq	%r15, %rcx
	movl	20(%r14), %esi
	movq	%rbp, %rdi
	sarl	$31, %eax
	xorl	%eax, %edx
	subl	%eax, %edx
	movl	20(%r14), %eax
	sarl	$31, %eax
	xorl	%eax, %esi
	subl	%eax, %esi
	call	_ZN2sf5Image6createEjjRKNS_5ColorE@PLT
	movq	16(%rsp), %rdi
	call	_ZN2sf6SpriteC1Ev@PLT
.LEHE9:
	movq	%r15, %rdi
.LEHB10:
	call	_ZN2sf7TextureC1Ev@PLT
.LEHE10:
	movl	24(%r14), %ecx
	cmpl	$0, %ecx
	jle	.L184
	movl	20(%r14), %r12d
	movl	$-1, 8(%rsp)
	imull	%ecx, %r12d
	movl	%r12d, %eax
	sarl	$31, %eax
	xorl	%eax, %r12d
	subl	%eax, %r12d
	subl	$1, %r12d
.L185:
	movl	20(%r14), %edx
	xorl	%r15d, %r15d
	.p2align 4,,10
	.p2align 3
.L189:
	testl	%edx, %edx
	je	.L187
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L188:
	movq	152(%r14), %rdx
	movl	%r12d, %eax
	movl	$255, %r8d
	movq	%rbx, %rdi
	leaq	(%rdx,%rax,4), %rax
	movzbl	(%rax), %ecx
	movzbl	1(%rax), %edx
	movzbl	2(%rax), %esi
.LEHB11:
	call	_ZN2sf5ColorC1Ehhhh@PLT
	movq	(%rsp), %rdi
	movq	%rbx, %rcx
	movl	%r15d, %edx
	movl	%ebp, %esi
	call	_ZN2sf5Image8setPixelEjjRKNS_5ColorE@PLT
.LEHE11:
	movl	20(%r14), %edx
	addl	$1, %ebp
	addl	8(%rsp), %r12d
	movl	%edx, %ecx
	sarl	$31, %ecx
	movl	%ecx, %eax
	xorl	%edx, %eax
	subl	%ecx, %eax
	cmpl	%ebp, %eax
	jg	.L188
	movl	24(%r14), %ecx
.L187:
	movl	%ecx, %esi
	addl	$1, %r15d
	sarl	$31, %esi
	movl	%esi, %eax
	xorl	%ecx, %eax
	subl	%esi, %eax
	cmpl	%r15d, %eax
	jg	.L189
.L186:
	pxor	%xmm0, %xmm0
	leaq	992(%rsp), %r14
	leaq	.LC19(%rip), %rcx
	leaq	144(%rsp), %r12
	xorl	%r8d, %r8d
	movl	$20, %edx
	movl	$1, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	movaps	%xmm0, 992(%rsp)
	movl	$0, 1008(%rsp)
	movq	%r14, %rbp
	call	__sprintf_chk@PLT
	leaq	16(%r12), %rax
	movq	%rax, 144(%rsp)
.L190:
	movl	0(%rbp), %edx
	addq	$4, %rbp
	leal	-16843009(%rdx), %eax
	notl	%edx
	andl	%edx, %eax
	andl	$-2139062144, %eax
	je	.L190
	movl	%eax, %edx
	shrl	$16, %edx
	testl	$32896, %eax
	cmove	%edx, %eax
	leaq	2(%rbp), %rdx
	movl	%eax, %edi
	cmove	%rdx, %rbp
	addb	%al, %dil
	sbbq	$3, %rbp
	subq	%r14, %rbp
	cmpq	$15, %rbp
	movq	%rbp, 32(%rsp)
	ja	.L233
	cmpq	$1, %rbp
	jne	.L194
	movzbl	992(%rsp), %eax
	movb	%al, 160(%rsp)
	leaq	16(%r12), %rax
.L195:
	movq	(%rsp), %rdi
	movq	%rbp, 152(%rsp)
	movq	%r12, %rsi
	movb	$0, (%rax,%rbp)
.LEHB12:
	call	_ZNK2sf5Image10saveToFileERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE12:
	movq	144(%rsp), %rdi
	addq	$16, %r12
	cmpq	%r12, %rdi
	je	.L196
	call	_ZdlPv@PLT
.L196:
	movq	24(%rsp), %r15
	pxor	%xmm0, %xmm0
	movq	(%rsp), %rsi
	movq	%rbx, %rdx
	movq	%r15, %rdi
	movaps	%xmm0, 32(%rsp)
.LEHB13:
	call	_ZN2sf7Texture13loadFromImageERKNS_5ImageERKNS_4RectIiEE@PLT
	movl	$1, %edx
	movq	%r15, %rsi
	movq	16(%rsp), %rdi
	call	_ZN2sf6Sprite10setTextureERKNS_7TextureEb@PLT
	leaq	48(%r13), %rbp
	.p2align 4,,10
	.p2align 3
.L201:
	movq	%r13, %rdi
	call	_ZNK2sf6Window6isOpenEv@PLT
	testb	%al, %al
	jne	.L199
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L235:
	movl	32(%rsp), %eax
	testl	%eax, %eax
	je	.L234
.L199:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	_ZN2sf6Window9pollEventERNS_5EventE@PLT
	testb	%al, %al
	jne	.L235
	movq	16(%rsp), %rsi
	leaq	_ZN2sf12RenderStates7DefaultE(%rip), %rdx
	movq	%rbp, %rdi
	call	_ZN2sf12RenderTarget4drawERKNS_8DrawableERKNS_12RenderStatesE@PLT
	movq	%r13, %rdi
	call	_ZN2sf6Window7displayEv@PLT
	jmp	.L201
.L194:
	testq	%rbp, %rbp
	leaq	16(%r12), %rax
	je	.L195
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L233:
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT
	movq	32(%rsp), %rdx
	movq	%rax, 144(%rsp)
	movq	%rdx, 160(%rsp)
.L193:
	movq	%rbp, %rdx
	movq	%r14, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	32(%rsp), %rbp
	movq	144(%rsp), %rax
	jmp	.L195
	.p2align 4,,10
	.p2align 3
.L234:
	movq	%r13, %rdi
	call	_ZN2sf6Window5closeEv@PLT
.LEHE13:
	jmp	.L199
	.p2align 4,,10
	.p2align 3
.L197:
	movq	24(%rsp), %rdi
	call	_ZN2sf7TextureD1Ev@PLT
	leaq	56+_ZTVN2sf6SpriteE(%rip), %rax
	movq	16(%rsp), %rdi
	leaq	-40(%rax), %rbx
	addq	$8, %rdi
	movq	%rbx, 8(%rsp)
	movq	8(%rsp), %xmm0
	pinsrq	$1, %rax, %xmm0
	movaps	%xmm0, 176(%rsp)
	call	_ZN2sf13TransformableD2Ev@PLT
	movq	(%rsp), %rdi
	call	_ZN2sf5ImageD1Ev@PLT
	movq	%r13, %rdi
	call	_ZN2sf12RenderWindowD1Ev@PLT
	movq	1016(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L236
	addq	$1032, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L184:
	.cfi_restore_state
	je	.L186
	movl	$1, 8(%rsp)
	xorl	%r12d, %r12d
	jmp	.L185
.L219:
	movq	144(%rsp), %rdi
	addq	$16, %r12
	movq	%rax, %rbx
	cmpq	%r12, %rdi
	je	.L207
	call	_ZdlPv@PLT
.L207:
	movq	24(%rsp), %rdi
	call	_ZN2sf7TextureD1Ev@PLT
.L208:
	leaq	56+_ZTVN2sf6SpriteE(%rip), %rax
	leaq	-40(%rax), %rdi
	movq	%rdi, 8(%rsp)
	movq	16(%rsp), %rdi
	movq	8(%rsp), %xmm0
	pinsrq	$1, %rax, %xmm0
	addq	$8, %rdi
	movaps	%xmm0, 176(%rsp)
	call	_ZN2sf13TransformableD2Ev@PLT
.L209:
	movq	(%rsp), %rdi
	call	_ZN2sf5ImageD1Ev@PLT
.L210:
	movq	%r13, %rdi
	call	_ZN2sf12RenderWindowD1Ev@PLT
	movq	%rbx, %rdi
.LEHB14:
	call	_Unwind_Resume@PLT
.L236:
	call	__stack_chk_fail@PLT
.L215:
	movq	%rax, %rbx
	jmp	.L210
.L214:
	movq	%rax, %rbp
	movq	16(%rsp), %rax
	movq	176(%rsp), %rdi
	addq	$16, %rax
	cmpq	%rax, %rdi
	je	.L204
	call	_ZdlPv@PLT
.L204:
	movq	%rbx, %rdi
	call	_ZNSt6localeD1Ev@PLT
	movq	%rbp, %rdi
	call	_Unwind_Resume@PLT
.LEHE14:
.L213:
	movq	%rax, %rbp
	jmp	.L204
.L218:
	movq	%rax, %rbx
	jmp	.L207
.L217:
	movq	%rax, %rbx
	jmp	.L208
.L216:
	movq	%rax, %rbx
	jmp	.L209
	.cfi_endproc
.LFE8084:
	.section	.gcc_except_table
.LLSDA8084:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8084-.LLSDACSB8084
.LLSDACSB8084:
	.uleb128 .LEHB6-.LFB8084
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L213-.LFB8084
	.uleb128 0
	.uleb128 .LEHB7-.LFB8084
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L214-.LFB8084
	.uleb128 0
	.uleb128 .LEHB8-.LFB8084
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L215-.LFB8084
	.uleb128 0
	.uleb128 .LEHB9-.LFB8084
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L216-.LFB8084
	.uleb128 0
	.uleb128 .LEHB10-.LFB8084
	.uleb128 .LEHE10-.LEHB10
	.uleb128 .L217-.LFB8084
	.uleb128 0
	.uleb128 .LEHB11-.LFB8084
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L218-.LFB8084
	.uleb128 0
	.uleb128 .LEHB12-.LFB8084
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L219-.LFB8084
	.uleb128 0
	.uleb128 .LEHB13-.LFB8084
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L218-.LFB8084
	.uleb128 0
	.uleb128 .LEHB14-.LFB8084
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
.LLSDACSE8084:
	.text
	.size	_ZN8BMP_file4drawEv, .-_ZN8BMP_file4drawEv
	.section	.rodata.str1.1
.LC21:
	.string	"matan.bmp"
.LC22:
	.string	"cat_load.bmp"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB8097:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8097
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.LC21(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	$16973, %edx
	movabsq	$532575944842, %rbp
	movabsq	$4123168605122, %r14
	subq	$352, %rsp
	.cfi_def_cfa_offset 384
	leaq	10(%rsp), %rdi
	leaq	2(%rsp), %rcx
	movq	$0, 2(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 344(%rsp)
	xorl	%eax, %eax
	andq	$-8, %rdi
	movq	$0, 160(%rsp)
	movq	%rsp, %rbx
	subq	%rdi, %rcx
	movdqa	.LC20(%rip), %xmm0
	addl	$166, %ecx
	shrl	$3, %ecx
	rep stosq
	movq	%rbx, %rdi
	movw	%dx, (%rsp)
	movq	%rbp, 12(%rsp)
	movq	%r14, 20(%rsp)
	movl	$1572865, 28(%rsp)
	movups	%xmm0, 56(%rsp)
	movl	$1934772034, 72(%rsp)
.LEHB15:
	call	_ZN8BMP_file9load_fileEPKc
.LEHE15:
	leaq	184(%rsp), %rdi
	xorl	%eax, %eax
	movl	$20, %ecx
	movq	$0, 178(%rsp)
	movq	$0, 336(%rsp)
	leaq	.LC22(%rip), %rsi
	rep stosq
	movq	%rbp, 188(%rsp)
	leaq	176(%rsp), %rbp
	movl	$16973, %eax
	movdqa	.LC20(%rip), %xmm1
	movq	%rbp, %rdi
	movw	%ax, 176(%rsp)
	movq	%r14, 196(%rsp)
	movl	$1572865, 204(%rsp)
	movl	$1934772034, 248(%rsp)
	movups	%xmm1, 232(%rsp)
.LEHB16:
	call	_ZN8BMP_file9load_fileEPKc
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	_ZN8BMP_file14sse_blend_withERKS_jj.constprop.21
	call	_ZN8BMP_file4drawEv
.LEHE16:
	movq	328(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L238
	call	_ZdaPv@PLT
.L238:
	movq	152(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L239
	call	_ZdaPv@PLT
.L239:
	xorl	%eax, %eax
	movq	344(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L261
	addq	$352, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L261:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
.L246:
	movq	328(%rsp), %rdi
	movq	%rax, %rbx
	testq	%rdi, %rdi
	je	.L242
	call	_ZdaPv@PLT
.L242:
	movq	152(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L243
	call	_ZdaPv@PLT
.L243:
	movq	%rbx, %rdi
.LEHB17:
	call	_Unwind_Resume@PLT
.LEHE17:
.L245:
	movq	%rax, %rbx
	jmp	.L242
	.cfi_endproc
.LFE8097:
	.section	.gcc_except_table
.LLSDA8097:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8097-.LLSDACSB8097
.LLSDACSB8097:
	.uleb128 .LEHB15-.LFB8097
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L245-.LFB8097
	.uleb128 0
	.uleb128 .LEHB16-.LFB8097
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L246-.LFB8097
	.uleb128 0
	.uleb128 .LEHB17-.LFB8097
	.uleb128 .LEHE17-.LEHB17
	.uleb128 0
	.uleb128 0
.LLSDACSE8097:
	.section	.text.startup
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.byte	-128
	.byte	0
	.byte	-128
	.byte	1
	.byte	-128
	.byte	2
	.byte	-128
	.byte	3
	.byte	-128
	.byte	4
	.byte	-128
	.byte	5
	.byte	-128
	.byte	6
	.byte	-128
	.byte	7
	.align 16
.LC1:
	.byte	-128
	.byte	8
	.byte	-128
	.byte	9
	.byte	-128
	.byte	10
	.byte	-128
	.byte	11
	.byte	-128
	.byte	12
	.byte	-128
	.byte	13
	.byte	-128
	.byte	14
	.byte	-128
	.byte	15
	.align 16
.LC2:
	.quad	72058693566333184
	.quad	72058693566333184
	.align 16
.LC3:
	.byte	1
	.byte	3
	.byte	5
	.byte	7
	.byte	9
	.byte	11
	.byte	13
	.byte	15
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 16
.LC4:
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	1
	.byte	3
	.byte	5
	.byte	7
	.byte	9
	.byte	11
	.byte	13
	.byte	15
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC14:
	.long	0
	.long	1093567616
	.section	.rodata.cst16
	.align 16
.LC18:
	.long	0
	.long	0
	.long	0
	.long	1
	.align 16
.LC20:
	.long	65280
	.long	65280
	.long	255
	.long	-16777216
	.hidden	DW.ref._ZTIPKc
	.weak	DW.ref._ZTIPKc
	.section	.data.rel.local.DW.ref._ZTIPKc,"awG",@progbits,DW.ref._ZTIPKc,comdat
	.align 8
	.type	DW.ref._ZTIPKc, @object
	.size	DW.ref._ZTIPKc, 8
DW.ref._ZTIPKc:
	.quad	_ZTIPKc
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
