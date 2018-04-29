;Bandi Nandor
;bnim1995
;511
;Projekt/Julia Fraktal

;Forditas/Linkeles:
;nasm -f win32 bnim1995_JULIA.asm
;nlink bnim1995_JULIA.obj -lio -lgfx -o bnim1995_JULIA.exe
 
%include 'io.inc'
%include 'gfx.inc'

%define WIDTH  1024
%define HEIGHT 768
%define DELTA_COLOUR 100
%define maximumIterations 200
global main

section .data

	oneandhalf: dd 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5
	offset_x: 	dd 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
	offset_y: 	dd 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
	const_x: 		dd -0.71, -0.71,-0.71, -0.71,    -0.71, -0.71,-0.71, -0.71 
	const_y: 		dd 0.27015, 0.27015,0.27015, 0.27015,    0.27015, 0.27015,0.27015, 0.27015 
	
	
	
	
	delta_const_x:	 dd 0.0025,0.0025,0.0025,0.0025,0.0025,0.0025,0.0025,0.0025
	delta_const_y:   dd 0.0025, 0.0025,0.0025, 0.0025,0.0025, 0.0025,0.0025, 0.0025
	
	opt_1_x: 		dd 0.285, 0.285,0.285, 0.285,    0.285, 0.285,0.285, 0.285 
	opt_1_y: 		dd 0.0, 0.0,0.0, 0.0,    0.0, 0.0,0.0, 0.0 
	delta_const_x_opt_1:	 dd 0.0001, 0.0001,0.0001, 0.0001,0.0001, 0.0001,0.0001, 0.0001
	delta_const_y_opt_1:   dd 0.0001, 0.0001,0.0001, 0.0001,0.0001, 0.0001,0.0001, 0.0001

	opt_2_x: 		dd 0.45, 0.45,0.45, 0.45,    0.45, 0.45,0.45, 0.45 
	opt_2_y: 		dd 0.1428, 0.1428,0.1428, 0.1428,    0.1428, 0.1428,0.1428, 0.1428 
	delta_const_x_opt_2:	 dd 0.0015, 0.0015,0.0015, 0.0015,0.0015, 0.0015,0.0015, 0.0015
	delta_const_y_opt_2:   dd 0.0015, 0.0015,0.0015, 0.0015,0.0015, 0.0015,0.0015, 0.0015
	
	opt_3_x: 		dd -0.70176,-0.70176,-0.70176,-0.70176,    -0.70176,-0.70176,-0.70176,-0.70176 
	opt_3_y: 		dd -0.3842, -0.3842,-0.3842, -0.3842,    -0.3842, -0.3842,-0.3842, -0.3842 
	delta_const_x_opt_3:	 dd 0.001, 0.001,0.001, 0.001,0.001, 0.001,0.001, 0.001
	delta_const_y_opt_3:   dd 0.001, 0.001,0.001, 0.001,0.001, 0.001,0.001, 0.001

	opt_4_x: 		dd -0.835, -0.835,-0.835, -0.835,    -0.835, -0.835,-0.835, -0.835 
	opt_4_y: 		dd -0.2321, -0.2321,-0.2321, -0.2321,    -0.2321, -0.2321,-0.2321, -0.2321 
	delta_const_x_opt_4:	 dd 0.0005, 0.0005,0.0005, 0.0005,0.0005, 0.0005,0.0005, 0.0005
	delta_const_y_opt_4:   dd 0.0005, 0.0005,0.0005, 0.0005,0.0005, 0.0005,0.0005, 0.0005
	opt_5_x: 		dd -0.8, -0.8,-0.8, -0.8,    -0.8, -0.8,-0.8, -0.8 
	opt_5_y: 		dd 0.156, 0.156,0.156, 0.156,    0.156, 0.156,0.156, 0.156 
	;opt_5: 		dd -0.8, 0.0,-0.8, 0.0,    -0.8, 0.0,-0.8, 0.0  
	delta_const_x_opt_5:	 dd 0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013
	delta_const_y_opt_5:   dd 0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013
	
	opt_6_x: 		dd 0.0,0.0,0.0,0.0,    0.0,0.0,0.0,0.0 	
	opt_6_y: 		dd -0.8, -0.8,-0.8, -0.8,    -0.8, -0.8,-0.8, -0.8 	
	delta_const_x_opt_6:	 dd 0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013
	delta_const_y_opt_6:   dd 0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013,0.0013, 0.0013

	opt_7_x: 		dd -0.71, -0.71,-0.71, -0.71,    -0.71, -0.71,-0.71, -0.71 
	opt_7_y: 		dd 0.27015, 0.27015,0.27015, 0.27015,    0.27015, 0.27015,0.27015, 0.27015 

	delta_const_x_opt_7:	 dd 0.0025, 0.0025,0.0025, 0.0025,0.0025, 0.0025,0.0025, 0.0025
	delta_const_y_opt_7:   dd 0.0025, 0.0025,0.0025, 0.0025,0.0025, 0.0025,0.0025, 0.0025

	delta_offset_x:  dd 0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009, 0.009
	delta_offset_y:  dd 0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009, 0.009
	dec_delta_offset_x: dd 0.92500000,0.92500000,0.92500000,0.92500000,0.92500000,0.92500000,0.92500000,0.92500000
	dec_delta_offset_y: dd 0.92500000,0.92500000,0.92500000,0.92500000,0.92500000,0.92500000,0.92500000,0.92500000
	

	copy_delta_offset_x:  dd 0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009, 0.009
	copy_delta_offset_y:  dd 0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009, 0.009
	copy_dec_delta_offset_x: dd 0.9250000,0.9250000,0.9250000,0.9250000,0.9250000,0.9250000,0.9250000,0.9250000
	copy_dec_delta_offset_y: dd 0.9250000,0.9250000,0.9250000,0.9250000,0.9250000,0.9250000,0.9250000,0.9250000
	
	four: 		dd 4.0,4.0,4.0,4.0,   4.0,4.0,4.0,4.0
	iterations: db 0,0,0,0,0,0,0,0

	delta_colour dd 50
	zoom 		dd 1.0
	one_d 		dd 1.0
	TWO_d 	dd 2.0

	inc_delta_zoom  dd 1.1
	copy_inc_delta_zoom  dd 1.1
	
	

	timer db 0
	movement_control dd 0
;		~~~~~~~~quadword data section~~~~~~~~~~~
	d_null_packed: dq 0.0, 0.0, 0.0, 0.0
	d_oneandhalf: dq 1.5, 1.5, 1.5, 1.5
	d_offset_x: 	dq 0.0, 0.0, 0.0, 0.0
	d_offset_y: 	dq 0.0, 0.0, 0.0, 0.0

	d_const_x: 		dq -0.71,-0.71,-0.71, -0.71
	d_const_y: 		dq 0.27015, 0.27015,0.27015, 0.27015

	d_delta_const_x:	 dq 0.0025, 0.0025,0.0025, 0.0025
	d_delta_const_y:   dq 0.0025, 0.0025,0.0025, 0.0025

	d_opt_1_x: 		dq 0.285, 0.285,0.285, 0.285
	d_opt_1_y: 		dq 0.0, 0.0,0.0, 0.0
	d_delta_const_x_opt_1:	 dq 0.0001, 0.0001,0.0001, 0.0001
	d_delta_const_y_opt_1:   dq 0.0001, 0.0001,0.0001, 0.0001
	
	
	d_opt_2_x: 		dq 0.45, 0.45,0.45, 0.45
	d_opt_2_y: 		dq 0.1428, 0.1428,0.1428, 0.1428
	d_delta_const_x_opt_2:	 dq 0.0015, 0.0015,0.0015, 0.0015
	d_delta_const_y_opt_2:   dq 0.0015, 0.0015,0.0015, 0.0015
	
	
	d_opt_3_x: 		dq -0.70176, -0.70176,-0.70176, -0.70176
	d_opt_3_y: 		dq -0.3842, -0.3842,-0.3842, -0.3842
	d_delta_const_x_opt_3:	 dq 0.001, 0.001,0.001, 0.001
	d_delta_const_y_opt_3:   dq 0.001, 0.001,0.001, 0.001
	

	d_opt_4_x: 		dq -0.835, -0.835,-0.835, -0.835
	d_opt_4_y: 		dq -0.2321, -0.2321,-0.2321, -0.2321
	d_delta_const_x_opt_4:	 dq 0.0005, 0.0005,0.0005, 0.0005
	d_delta_const_y_opt_4:   dq 0.0005, 0.0005,0.0005, 0.0005
	


	d_opt_5_x: 		dq -0.8, -0.8,-0.8, -0.8
	d_opt_5_y: 		dq 0.156, 0.156,0.156, 0.156
	d_delta_const_x_opt_5:	 dq 0.0013, 0.0013,0.0013, 0.0013
	d_delta_const_y_opt_5:   dq 0.0013, 0.0013,0.0013, 0.0013
	

	d_opt_6_x: 		dq  0.0, 0.0,0.0, 0.0
	d_opt_6_y: 		dq -0.8, -0.8,-0.8, -0.8
	d_delta_const_x_opt_6:	 dq 0.0013, 0.0013,0.0013, 0.0013
	d_delta_const_y_opt_6:   dq 0.0013, 0.0013,0.0013, 0.0013
	


	d_opt_7_x: 		dq -0.71, -0.71,-0.71, -0.71
	d_opt_7_y: 		dq 0.27015, 0.27015,0.27015, 0.27015
	d_delta_const_x_opt_7:	 dq 0.0025, 0.0025,0.0025, 0.0025
	d_delta_const_y_opt_7:   dq 0.0025, 0.0025,0.0025, 0.0025
	


	d_delta_offset_x:  dq 0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009, 0.009
	d_delta_offset_y:  dq 0.009,0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009
	d_dec_delta_offset_x: dq 0.92500000,0.9250,0.92500000,0.9250,0.92500000,0.9250,0.92500000,0.925
	d_dec_delta_offset_y: dq 0.9250,0.92500000,0.9250,0.92500000,0.9250,0.92500000,0.9250,0.92500000
	

	d_copy_delta_offset_x:  dq 0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009, 0.009
	d_copy_delta_offset_y:  dq 0.009,  0.009,  0.009,  0.009, 0.009, 0.009,  0.009,  0.009
	d_copy_dec_delta_offset_x: dq 0.92500000,0.9250,0.92500000,0.9250,0.92500000,0.9250,0.92500000,0.925
	d_copy_dec_delta_offset_y: dq 0.9250,0.92500000,0.9250,0.92500000,0.9250,0.92500000,0.9250,0.92500000
	

	d_four: 		dq 4.0,4.0,4.0,4.0
	d_zoom 		dq 1.0
	d_one_q: 	dq 1.0
	d_TWO_q 	dq 2.0

	d_inc_delta_zoom  dq 1.1
	d_copy_inc_delta_zoom  dq 1.1
	null 		dq 0.0

	animate_on db 1
	color_animate_on db -1
    title db "Julia Set", 0
	infomsg db 10,9,9,9,"     ___  __   __  ___      ___   _______",10,9,9,9,"    |   ||  | |  ||   |    |   | |   _   |",10,9,9,9,"    |   ||  | |  ||   |    |   | |  |_|  |",10,9,9,9,"    |   ||  |_|  ||   |    |   | |       |",10,9,9,9," ___|   ||       ||   |___ |   | |       |",10,9,9,9,"|       ||       ||       ||   | |   _   |",10,9,9,9,"|_______||_______||_______||___| |__| |__|",10,9,9,9,9,9,"    Bandi Nandor-2017/2018",10,9,9,9,"Press:",10,9,9,9,"1,2,3,4,5,6,7 for different Julia sets",10,9,9,9,"x     to change precision(single<->double) ",10,9,9,9,"m     to toggle animation",10,10,10,9,9,9,"Hold:",10,9,9,9,"WASD to move around the image",10,9,9,9,"c for color animation",0
	errormsg db "ERROR: could not initialize graphics!", 0
	float_mode db 10,9,9,9,"SINGLE PRECISION FLOATING POINT MODE",10,0
	double_mode db 10,9,9,9,"DOUBLE PRECISION FLOATING POINT MODE",10,0
section .text


main:
	; Create the graphics window

	
	
    mov		eax, WIDTH		; window width (X)
	mov		ebx, HEIGHT		; window hieght (Y)
	mov		ecx, 0			; window mode (NOT fullscreen!)
	mov		edx, title		; window title
	call	gfx_init
	
	test	eax, eax		; if the return value is 0, something went wrong
	jnz		.init
	; Print error message and exit
	mov		eax, errormsg
	call	io_writestr
	call	io_writeln
	ret
	
	
.init:

	mov		eax, infomsg	; print some usage info
	call	io_writestr
	call	io_writeln
	
	
	
.single_float_entry:
	mov eax,float_mode
	call io_writestr
	;ZOOM
	movsd xmm0,[d_zoom]
	cvtsd2ss  xmm1,xmm0
	movss 	 [zoom],xmm1
	;CONSTANTS
	movsd xmm0,[d_const_x]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1
	vmovups [const_x],ymm1
	movsd xmm0,[d_const_y]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1
	vmovups [const_y],ymm1

	;OFFSET
	movsd xmm0,[d_offset_x]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1;
	vmovups [offset_x],ymm1
	movsd xmm0,[d_offset_y]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1
	vmovups [offset_y],ymm1
;DELTAS
	;CONSTANTS
	movsd xmm0,[d_delta_const_x]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1
	vmovups [delta_const_x],ymm1
	movsd xmm0,[d_delta_const_y]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1
	vmovups [delta_const_y],ymm1

	;OFFSET
	movsd xmm0,[d_delta_offset_x]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1;
	vmovups [delta_offset_x],ymm1
	movsd xmm0,[d_delta_offset_y]
	cvtsd2ss  xmm1,xmm0	
	vbroadcastss ymm1,xmm1
	vmovups [delta_offset_y],ymm1
; Main loop
.mainloop_float:
	
	call	gfx_map			; map the framebuffer -> EAX will contain the pointer
	;save the framebuffer to edi, as we will use eax later
	mov 	edi,eax
	;Loop over the rows

	xor		ecx, ecx		; ECX row (Y)
	

	;Initialize constants 
	vmovaps ymm5,[four]
	vbroadcastss ymm6,dword[zoom]
	;ymm6:zoom,zoom,zoom,zoom,zoom,zoom,zoom,zoom
	vbroadcastss ymm3,dword[TWO_d]
	;ymm3:2,2,2,2,2,2,2,2

.loopover_rows:
	cmp		ecx, HEIGHT
	jge		.row_end	
	
; Loop over the columns
	xor		edx, edx		; EDX - column (X)
	
.loopover_columns:
	cmp		edx, WIDTH
	jge		.column_end


  ;	Color calculation algorithm:
  ;		we will use AVX vectorisation with single precision values,thus
  ;		calculating colours for 8 pixels in parallel
  ;		One AVX register is of 256 bits,and can hold 8 32 bit values
  ; 	two of them,  coordinates for 8 pixels


  ;Next, we will:

  ;   calculate the initial real and imaginary part of z, based on the pixel location, zoom and position values
  ;   for each pixel in the AVX register,in parallel 
  ;   newRe = 1.5 * (x - w / 2) / (0.5 * zoom * w) + moveX;
  ;   newIm = (y - h / 2) / (0.5 * zoom * h) + moveY;

  ;   //i will represent the number of iterations
  ;   int i;
  ;   //start the iteration process
  ;   for(i = 0; i < maxIterations; i++)
  ;   {
  ;     //remember value of previous iteration
  ;     oldRe = newRe;
  ;     oldIm = newIm;
  ;     //the actual iteration, the real and imaginary part are calculated
  ;     newRe = oldRe * oldRe - oldIm * oldIm + cRe;
  ;     newIm = 2 * oldRe * oldIm + cIm;
  ;     //if the point is outside the circle with radius 2: stop
  ;     if((newRe * newRe + newIm * newIm) > 4) break;
  ;   }
  ;	 



 
   ;Scale p1,p2,p3,p4 coordinates as
   ;   newRe = 1.5 * (x - w / 2) / (0.5 * zoom * w) + moveX;
   ;   newIm = (y - h / 2) / (0.5 * zoom * h) + moveY;

   vcvtsi2ss 	xmm0,xmm0,ecx
   ;ymm0:0,0,0,0,0,0,0,y1
   vpermilps    xmm0,xmm0,0
   ;ymm0;y1,y1,y1,y1,y1,y1,y1,y1

   vcvtsi2ss 	xmm1,xmm1,edx
   ;ymm1;0,0,0,0,0,0,0,x1
   vpermilps    xmm1,xmm1,0
   ;ymm1:x1,x1,x1,x1,x1,x1,x1,x1
   ;inserted first pixel,    p1

;Leaping to next pixel 
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline1
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline1:

	vcvtsi2ss 	xmm0,xmm0,ecx
	;ymm0:y1y1y1y1y1y1y1y2
	vcvtsi2ss 	xmm1,xmm1,edx
	;ymm1:x1x1x1x1x1x1x1x2

   vpermilpd    xmm0,xmm0,0
   ;ymm0;0,0,0,0,y1,y2,y1,y2
   vpermilpd    xmm1,xmm1,0
   ;ymm1;0,0,0,0,x1,x2,x1,x2
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline2
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline2:
   
	vcvtsi2ss 	xmm0,xmm0,ecx
	;ymm0;0,0,0,0,y1,y2,y1,y3
	vcvtsi2ss 	xmm1,xmm1,edx
	;ymm1;0,0,0,0,x1,x2,x1,x3
	vpermilps    xmm0,xmm0,0xE0
    ;ymm0;0,0,0,0,y1,y2,y3,y3 mask: 11 10 00 00
    vpermilps    xmm1,xmm1,0xE0
    ;ymm1;0,0,0,0,x1,x2,x3,x3 mask: 11 10 00 00
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline3
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline3:
	vcvtsi2ss 	xmm0,xmm0,ecx
	vcvtsi2ss 	xmm1,xmm1,edx
   ;ymm0;0,0,0,0,y1,y2,y3,y4
   ;ymm1;0,0,0,0,x1,x2,x3,x4
   ;			p1	p2 p3 p4
   ;inserted 4 pixels
			  
;Leaping to next pixel 
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline4
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline4:
    ;ymm0;0,0,0,0,y1,y2,y3,y4
	;ymm1;0,0,0,0,x1,x2,x3,x4
	vpermpd 		ymm2,ymm0,0x40
	;ymm2:y1,y2,y3,y4,y3,y4,y3,y4   	mask:01 00   00 00
	vpermpd 		ymm4,ymm1,0x40
	;ymm4:x1,x2,x3,x4,x3,x4,x3,x4   	mask:01 00   00 00

    vcvtsi2ss 	xmm0,xmm0,ecx
	;ymm0:00000,0,0,y5
	vcvtsi2ss 	xmm1,xmm1,edx
	;ymm1:00000,0,0,x5
	vpermilps    xmm0,xmm0,0
	;ymm0;y5y5y5y5,y5,y5,y5,y5
	vpermilps    xmm1,xmm1,0
	;ymm0;x5x5x5x5,x5,x5,x5,x5
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline5
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline5:
	vcvtsi2ss 	xmm0,xmm0,ecx
	;ymm0;0,0,0,0,0,0,y5,y6
	vcvtsi2ss 	xmm1,xmm1,edx
	;ymm1;0,0,0,0,0,0,x5,x6
   
			  
;Leaping to next pixel 
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline6
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline6:



	vpermilpd    xmm0,xmm0,0
	;ymm0;0,0,0,0,y5,y6,y5,y6
   	vpermilpd    xmm1,xmm1,0
	;ymm1;0,0,0,0,x5,x6,x5,x6

	vcvtsi2ss 	xmm0,xmm0,ecx
	;ymm0;0,0,0,0,y5,y6,y5,y7
	vcvtsi2ss 	xmm1,xmm1,edx
	;ymm1;0,0,0,0,x5,x6,x5,x7

	vpermilps    xmm0,xmm0,0xE0
	;ymm0;0,0,0,0,y5,y6,y7,y7 mask: 11 10 00 00
	vpermilps    xmm1,xmm1,0xE0
	;ymm1;0,0,0,0,x5,x6,x7,x7 mask: 11 10 00 00

;Leaping to next pixel 
inc 		edx 
	cmp		edx, WIDTH
	jl 		.inline7
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.inline7:

	vcvtsi2ss 	xmm0,xmm0,ecx
	;ymm0;0,0,0,0,y5,y6,y7,y8
	;ymm2:y1,y2,y3,y4,y3,y4,y3,y4
	vcvtsi2ss 	xmm1,xmm1,edx
	;ymm1;0,0,0,0,x5,x6,x7,x8
	;ymm4:x1,x2,x3,x4,x3,x4,x3,x4

vblendpd 	ymm7,ymm2,ymm0,3
;ymm7:y1,y2,y3,y4,y5,y6,y7,y8	mask:0011
vblendpd 	ymm0,ymm4,ymm1,3
;ymm0:x1,x2,x3,x4,x5,x6,x7,x8	mask:0011

;Now ymm0,ymm7 holds all 8 pixel coordinates, but these are not scaled	   
	   			mov eax,HEIGHT
	   vcvtsi2ss xmm1,eax
	   ;xmm1:0,0,0,h
	   vpermilps    xmm1,xmm1,0
	   ;xmm1:h,h,h,h
	   vpermpd 		ymm1,ymm1,0
	   ;ymm1:h,h,h,h,h,h,h,h	mask:00 00  00 00

	   			mov eax,WIDTH
	   vcvtsi2ss xmm2,eax
	   ;xmm2:0,0,0,w
	   vpermilps    xmm2,xmm2,0
	   ;xmm2:w,w,w,w

	   vpermpd ymm2,ymm2,0
	   ;ymm1:h,h,h,h,h,h,h,h    mask:00 00  00 00
	   ;ymm2:w,w,w,w,w,w,w,w

    ;ymm3:2,2,2,2 2,2,2,2 (constant )
   	;ymm7:y1,y2,y3,y4,y5,y6,y7,y8
   	;ymm0:x1,x2,x3,x4,x5,x6,x7,x8

   	vdivps 	ymm1,ymm1,ymm3
   	;ymm1: h/2,h/2,h/2,h/2,h/2,h/2,h/2,h/2
   	vdivps 	ymm2,ymm2,ymm3
   	;ymm2: w/2,w/2,w/2,w/2,w/2,w/2,w/2,w/2

   	vsubps 	ymm0,ymm0,ymm2
   	;ymm0: x1-w/2,x2-w/2,x3-w/2,x4-w/2, x5-w/2,x6-w/2,x7-w/2,x8-w/2
   	vsubps 	ymm7,ymm7,ymm1
   	;ymm7: y1-h/2,y2-h/2,y3-h/2,y4-h/2, y5-h/2,y6-h/2,y7-h/2,y8-h/2

    ;ymm6:zoom,zoom,zoom,zoom,zoom,zoom,zoom,zoom(constant in this context)

   	vmulps 		ymm1,ymm1,ymm6
    ;ymm1: 	zoom*h/2,zoom*h/2,zoom*h/2,zoom*h/2 zoom*h/2,zoom*h/2,zoom*h/2,zoom*h/2 
    vmulps 		ymm2,ymm2,ymm6
    ;ymm2: 	zoom*w/2,zoom*w/2,zoom*w/2,zoom*w/2 zoom*w/2,zoom*w/2,zoom*w/2,zoom*w/2 

    vdivps 		ymm7,ymm7,ymm1
    ;ymm7:{(y1-h/2)/(zoom*h/2)},{(y2-h/2)/(zoom*h/2)},{(y3-h/2)/(zoom*h/2)},{(y4-h/2)/(zoom*h/2)}
   	;	  {(y5-h/2)/(zoom*h/2)},{(y6-h/2)/(zoom*h/2)},{(y7-h/2)/(zoom*h/2)},{(y8-h/2)/(zoom*h/2)}
    vdivps 		ymm0,ymm0,ymm2
    ;ymm0:{(x1-w/2)/(zoom*w/2)},{(x2-w/2)/(zoom*w/2)},{(x3-w/2)/(zoom*w/2)},{(x4-w/2)/(zoom*w/2)}
   	;	  {(x5-w/2)/(zoom*w/2)},{(x6-w/2)/(zoom*w/2)},{(x7-w/2)/(zoom*w/2)},{(x8-w/2)/(zoom*w/2)}
    
    vmulps 		ymm0,ymm0,[oneandhalf]
    ;ymm0:{(x1-w/2)/(zoom*w/2)*1.5},{(x2-w/2)*1.5/(zoom*w/2)*1.5},{(x3-w/2)*1.5/(zoom*w/2)*1.5},{(x4-w/2)*1.5/(zoom*w/2)*1.5}
   	;	  {(x5-w/2)*1.5/(zoom*w/2)*1.5},{(x6-w/2)*1.5/(zoom*w/2)*1.5},{(x7-w/2)*1.5/(zoom*w/2)*1.5},{(x8-w/2)*1.5/(zoom*w/2)*1.5}
    
    vaddps 		ymm0,ymm0,[offset_x]
	;ymm0:{(x1-w/2)/(zoom*w/2)*1.5+ox},{(x2-w/2)/(zoom*w/2)*1.5+ox},{(x3-w/2)/(zoom*w/2)*1.5+ox},{(x4-w/2)/(zoom*w/2)*1.5+ox}
  	;	  {(x5-w/2)/(zoom*w/2)*1.5+ox},{(x6-w/2)/(zoom*w/2)*1.5+ox},{(x7-w/2)/(zoom*w/2)*1.5+ox},{(x8-w/2)/(zoom*w/2)*1.5+ox}
    vaddps 		ymm7,ymm7,[offset_y]  
    ;ymm7:{(y1-h/2)/(zoom*h/2)+oy},{(y2-h/2)/(zoom*h/2)+oy},{(y3-h/2)/(zoom*h/2)+oy},{(y4-h/2)/(zoom*h/2)+oy}
   	;	  {(y5-h/2)/(zoom*h/2)+oy},{(y6-h/2)/(zoom*h/2)+oy},{(y7-h/2)/(zoom*h/2)+oy},{(y8-h/2)/(zoom*h/2)+oy}
   
    ;finished vectorized scaling of 8 pixels
  movq 	xmm1,[null]
  ;initialise iterations count
  movq [iterations],xmm1
  xor ebx,ebx
.iter:
	;In this loop we apply the fn(z)=(f(n-1)(z))^2+c,   function to the complex numbers derived from the scaled pixels,(in parallel)
	;until either we reach the maximum number of iterations, or all of the absolute values of our complex numbers exceed the value of 2.
	;We will keep track of the number of iterations that correspond to each complex number in the iterations field,that consists of 8 bytes,
	;in which every byte tells us how many iterations that particular pixel took before its absolute value exceeded the value of 2.
	;we will refer to the scaled values x,y that were in the ymm0,ymm7 registers as a,b, the real and imaginary part of the complex number z.

	cmp ebx,maximumIterations
	jge .out;reached limit of iterations
	;ymm0:a1,a2,a3,a4,a5,a6,a7,a8
	;ymm7:b1,b2,b3,b4,b5,b6,b7,b8
	vmulps 		ymm2,ymm0,ymm0;a^2
	;ymm2:a1a1,a2a2,a3a3,a4a4,a5a5,a6a6,a7a7,a8a8
	vmulps 		ymm4,ymm7,ymm7;b^2
	;ymm4:b1b1,b2b2,b3b3,b4b4,b5b5,b6b6,b7b7,b8b8
	vsubps 	 	ymm2,ymm2,ymm4;a^2-b^2
	;ymm2:a1a1-b1b1,a2a2-b2b2,a3a3-b3b3,a4a4-b4b4,a5a5-b5b5,a6a6-b6b6,a7a7-b7b7,a8a8-b8b8
	
	;ymm0:a1,a2,a3,a4,a5,a6,a7,a8
	;ymm7:b1,b2,b3,b4,b5,b6,b7,b8
	vmulps 		ymm1,ymm0,ymm7;ab
	;ymm1:a1b1,a2b2,a3b3,a4b4,a5b5,a6b6,a7b7,a8b8
	vaddps 		ymm7,ymm1,ymm1;2ab
	;ymm7:2a1b1,2a2b2,2a3b3,2a4b4,2a5b5,2a6b6,2a7b7,2a8b8
	vaddps 		ymm7,ymm7,[const_y];2ab+cy
	;ymm7:2a1b1+cy,2a2b2+cy,2a3b3+cy,2a4b4+cy,2a5b5+cy,2a6b6+cy,2a7b7+cy,2a8b8+cy
	;ymm7:B1,B2,B3,B4,B5,B6,B7,B8
	vaddps		ymm0,ymm2,[const_x];a^2-b^2+cx
	;ymm0:a1a1-b1b1+cx,a2a2-b2b2+cx,a3a3-b3b3+cx,a4a4-b4b4+cx,a5a5-b5b5+cx,a6a6-b6b6+cx,a7a7-b7b7+cx,a8a8-b8b8+cx
	;ymm0:A1,A2,A3,A4,A5,A6,A7,A8
	vmulps 		ymm1,ymm0,ymm0;A^2
	vmulps 		ymm2,ymm7,ymm7;B^2
	vaddps 		ymm4,ymm1,ymm2;A^2+B^2

	vcmpleps ymm1,ymm4,ymm5;we compare the squares of our absolute values to 4, which compare is equivalent to 
						   ;the comparison of the absolute values to 2
	;ymm1:mask of previous compare
	vmovmskps eax,ymm1
	;al-extracted mask of ymm1
	test al,al
	jz .out;if all of the absolute values of our  comlex numbers are bigger than 2, jump out of iteration loop

	;we increment the corresponding  byte in the iterations field of those pixels only, whose 
	;absolute value is less than 2.
	SHR eax,1
	adc byte[iterations+7],0
	SHR eax,1
	adc byte[iterations+6],0
	SHR eax,1
	adc byte[iterations+5],0
	SHR eax,1
	adc byte[iterations+4],0
	SHR eax,1
	adc byte[iterations+3],0
	SHR eax,1
	adc byte[iterations+2],0
	SHR eax,1
	adc byte[iterations+1],0
	SHR eax,1
	adc byte[iterations],0
		
	inc ebx
jmp .iter
.out:
	;We will color these eight pixels in the framebuffer according to the 
	;corresponing bytes in the iterations field.
	mov al,byte[iterations]
	add al,al
	mov byte[edi],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+1],al
	add al,al
	mov byte[edi+2],al
	mov byte[edi+3],0

		mov al,byte[iterations+1]
	add al,al
	mov byte[edi+4],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+5],al
	add al,al
	mov byte[edi+6],al
	mov byte[edi+7],0
	
		mov al,byte[iterations+2]
	add al,al
	mov byte[edi+8],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+9],al
	add al,al
	mov byte[edi+10],al
	mov byte[edi+11],0

		mov al,byte[iterations+3]
	add al,al
	mov byte[edi+12],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+13],al
	add al,al
	mov byte[edi+14],al
	mov byte[edi+15],0

	mov al,byte[iterations+4]
	add al,al
	mov byte[edi+16],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+17],al
	add al,al
	mov byte[edi+18],al
	mov byte[edi+19],0

		mov al,byte[iterations+5]
	add al,al
	mov byte[edi+20],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+21],al
	add al,al
	mov byte[edi+22],al
	mov byte[edi+23],0
	
		mov al,byte[iterations+6]
	add al,al
	mov byte[edi+24],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+25],al
	add al,al
	mov byte[edi+26],al
	mov byte[edi+27],0

		mov al,byte[iterations+7]
	add al,al
	mov byte[edi+28],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+29],al
	add al,al
	mov byte[edi+30],al
	mov byte[edi+31],0


;Leap to next 8 pixel section of framebuffer	
add		edi,32   ; next pixel
;Leap to next pixel on screen
inc		edx
;jump back into the loop
jmp		.loopover_columns
.column_end:
	inc		ecx
	jmp		.loopover_rows
	
.row_end:
	call	gfx_unmap		; unmap the framebuffer
	call	gfx_draw		; draw the contents of the framebuffer 
	
	
	; Query and handle the events 
	xor		ebx, ebx		; load some constants into registers: 0, -1, 1
	mov		ecx, -1
	mov		edx, 1
	
.eventloop:
	;increment animation timer
	inc byte[timer]

	call	gfx_getevent
	

	;check button press
	cmp eax,'i'
	je .set_inc_constX
	cmp eax,'o'
	je .set_dec_constX
	cmp eax,'t'
	je .set_inc_constY
	cmp eax,'y'
	je .set_dec_constY
	cmp eax,'b'
	je .set_inc_zoom
	cmp eax,'k'
	je .set_dec_zoom
	cmp eax,'w'
	je .set_dec_Yoff
	cmp eax,'a'
	je .set_dec_Xoff
	cmp eax,'s'
	je .set_inc_Yoff
	cmp eax,'d'
	je .set_inc_Xoff
	cmp eax,'c'
	je .set_color_animation
	;check if button release
	cmp eax,-'i'
	je .unset_inc_constX
	cmp eax,-'o'
	je .unset_dec_constX
	cmp eax,-'t'
	je .unset_inc_constY
	cmp eax,-'y'
	je .unset_dec_constY
	cmp eax,-'b'
	je .unset_inc_zoom
	cmp eax,-'k'
	je .unset_dec_zoom
	cmp eax,-'w'
	je .unset_dec_Yoff
	cmp eax,-'a'
	je .unset_dec_Xoff
	cmp eax,-'s'
	je .unset_inc_Yoff
	cmp eax,-'d'
	je .unset_inc_Xoff
	cmp eax,-'c'
	je .unset_color_animation
	;check if option selected 
	cmp eax,'1'
	je .opt_1
	cmp eax,'2'
	je .opt_2
	cmp eax,'3'
	je .opt_3
	cmp eax,'4'
	je .opt_4
	cmp eax,'5'
	je .opt_5
	cmp eax,'6'
	je .opt_6
	cmp eax,'7'
	je .opt_7
	;check if precision change selected
	cmp eax,'x'
	je .double_float_entry
	;check if animation toggle selected
	cmp eax,'m'
	je .toggle_animation

	jmp	.animation

	.set_inc_constX:
	mov byte[movement_control],1
	 jmp .animation
	.set_dec_constX:
	mov byte[movement_control+1],1
	 jmp .animation
	.set_inc_constY:
	mov byte[movement_control+2],1
	 jmp .animation
	.set_dec_constY:
	mov byte[movement_control+3],1
	 jmp .animation
	.set_inc_zoom:
	mov byte[movement_control+4],1
	 jmp .animation
	.set_dec_zoom:
	mov byte[movement_control+5],1
	 jmp .animation
	.set_dec_Yoff:
	mov byte[movement_control+6],1
	 jmp .animation
	.set_dec_Xoff:
	mov byte[movement_control+7],1
	 jmp .animation
	.set_inc_Yoff:
	mov byte[movement_control+8],1
	 jmp .animation
	.set_inc_Xoff:
	mov byte[movement_control+9],1
	 jmp .animation
	.set_color_animation:
	mov byte[color_animate_on],1
	 jmp .animation


	.unset_inc_constX:
	mov byte[movement_control],0
	 jmp .animation
	.unset_dec_constX:
	mov byte[movement_control+1],0
	 jmp .animation
	.unset_inc_constY:
	mov byte[movement_control+2],0
	 jmp .animation
	.unset_dec_constY:
	mov byte[movement_control+3],0
	 jmp .animation
	.unset_inc_zoom:
	mov byte[movement_control+4],0
	 jmp .animation
	.unset_dec_zoom:
	mov byte[movement_control+5],0
	 jmp .animation
	.unset_dec_Yoff:
	mov byte[movement_control+6],0
	 jmp .animation
	.unset_dec_Xoff:
	mov byte[movement_control+7],0
	 jmp .animation
	.unset_inc_Yoff:
	mov byte[movement_control+8],0
	 jmp .animation
	.unset_inc_Xoff:
	mov byte[movement_control+9],0
	 jmp .animation
	.unset_color_animation:
	mov byte[color_animate_on],-1
	 jmp .animation

.toggle_animation:
	mov dl,byte[animate_on]
	neg dl
	mov byte[animate_on],dl
jmp .animation
;Copying constants at option select
.opt_1:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	


	vmovaps ymm0,[opt_1_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_1_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_1]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_1]
	vmovaps [delta_const_y],ymm0
	
jmp .animation
.opt_2:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	

	vmovaps ymm0,[opt_2_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_2_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_2]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_2]
	vmovaps [delta_const_y],ymm0
	
jmp .animation
.opt_3:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	


	vmovaps ymm0,[opt_3_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_3_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_3]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_3]
	vmovaps [delta_const_y],ymm0
	
	
jmp .animation
.opt_4:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	

	vmovaps ymm0,[opt_4_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_4_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_4]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_4]
	vmovaps [delta_const_y],ymm0
	
	
jmp .animation
.opt_5:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	

	
	vmovaps ymm0,[opt_5_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_5_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_5]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_5]
	vmovaps [delta_const_y],ymm0
	
	
jmp .animation
.opt_6:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	

	vmovaps ymm0,[opt_6_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_6_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_6]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_6]
	vmovaps [delta_const_y],ymm0
	
	
jmp .animation
.opt_7:
	xor ebx,ebx
	mov byte[timer],bl
	movss xmm0,[one_d]
	movss [zoom],xmm0
	movss xmm0,[copy_inc_delta_zoom]
	movss [inc_delta_zoom],xmm0
	

	vmovaps ymm0,[copy_delta_offset_x]
	vmovaps [delta_offset_x],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_x]
	vmovaps [dec_delta_offset_x],ymm0
	
	

	vmovaps ymm0,[copy_delta_offset_y]
	vmovaps [delta_offset_y],ymm0
	vmovaps ymm0,[copy_dec_delta_offset_y]
	vmovaps [dec_delta_offset_y],ymm0
	

	vmovaps ymm0,[opt_7_x]
	vmovaps [const_x],ymm0
	vmovaps ymm0,[opt_7_y]
	vmovaps [const_y],ymm0

	vmovaps ymm0,[delta_const_x_opt_7]
	vmovaps [delta_const_x],ymm0

	vmovaps ymm0,[delta_const_y_opt_7]
	vmovaps [delta_const_y],ymm0
	
	
.animation:
;Changing constant values according to pressed key
.inc_constX:
	cmp byte[movement_control],0
	je .end_inc_constX
	vmovaps ymm0,[delta_const_x]
	vmovaps ymm1,[const_x]
	vaddps ymm1,ymm0,ymm1
	vmovaps [const_x],ymm1
.end_inc_constX:

.dec_constX:
	cmp byte[movement_control+1],0
	je .end_dec_constX
	vmovaps ymm0,[delta_const_x]
	vmovaps ymm1,[const_x]
	vsubps ymm1,ymm1,ymm0
	vmovaps [const_x],ymm1
.end_dec_constX:
.inc_constY:
	cmp byte[movement_control+2],0
	je .end_inc_constY
	vmovaps ymm0,[delta_const_y]
	vmovaps ymm1,[const_y]
	vaddps ymm1,ymm0,ymm1
	vmovaps [const_y],ymm1
.end_inc_constY:

.dec_constY:
	cmp byte[movement_control+3],0
	je .end_dec_constY
	vmovaps ymm0,[delta_const_y]
	vmovaps ymm1,[const_y]
	vsubps ymm1,ymm1,ymm0
	vmovaps [const_y],ymm1
.end_dec_constY:
;Zooming in,out
.inc_zoom:
	cmp byte[movement_control+4],0
	je .end_inc_zoom
	
	movss xmm2,[inc_delta_zoom]
	movss xmm1,[zoom]
	mulss xmm1,xmm2
	movss [zoom],xmm1


	
	
	vmovups ymm1,[delta_offset_x]
	vmulps ymm1,ymm1,[dec_delta_offset_x]
	vmovups [delta_offset_x],ymm1

	
	vmovups ymm1,[delta_offset_y]
	vmulps ymm1,ymm1,[dec_delta_offset_y]
	vmovups [delta_offset_y],ymm1
.end_inc_zoom:
.dec_zoom:
	cmp byte[movement_control+5],0
	je .end_dec_zoom
	
	movss xmm2,[inc_delta_zoom]
	movss xmm1,[zoom]
	divss xmm1,xmm2
	movss [zoom],xmm1


	
	
	vmovups ymm1,[delta_offset_x]
	vdivps ymm1,ymm1,[dec_delta_offset_x]
	vmovups [delta_offset_x],ymm1


	
	vmovups ymm1,[delta_offset_y]
	vdivps ymm1,ymm1,[dec_delta_offset_y]
	vmovups [delta_offset_y],ymm1
	
.end_dec_zoom:
;Moving the picture around
.dec_Yoff:
	cmp byte[movement_control+6],0
	je .end_dec_Yoff
	vmovaps ymm0,[delta_offset_y]
	vmovaps ymm1,[offset_y]
	vsubps ymm1,ymm1,ymm0
	vmovaps [offset_y],ymm1
.end_dec_Yoff:
.dec_Xoff:
	cmp byte[movement_control+7],0
	je .end_dec_Xoff
	vmovaps ymm0,[delta_offset_x]
	vmovaps ymm1,[offset_x]
	vsubps ymm1,ymm1,ymm0
	vmovaps [offset_x],ymm1
.end_dec_Xoff:
.inc_Yoff:
	cmp byte[movement_control+8],0
	je .end_inc_Yoff
	vmovaps ymm0,[delta_offset_y]
	vmovaps ymm1,[offset_y]
	vaddps ymm1,ymm1,ymm0
	vmovaps [offset_y],ymm1
.end_inc_Yoff:
.inc_Xoff:
	cmp byte[movement_control+9],0
	je .end_inc_Xoff
	vmovaps ymm0,[delta_offset_x]
	vmovaps ymm1,[offset_x]
	vaddps ymm1,ymm1,ymm0
	vmovaps [offset_x],ymm1
.end_inc_Xoff:

;COLOR ANIMATION

mov dl,byte[color_animate_on]
cmp dl,0
jl .color_animation_end

	inc byte[delta_colour]
	inc byte[delta_colour]
	
.color_animation_end:


 
;CONSTANT ANIMATION
mov dl,byte[animate_on]
cmp dl,0
jl .animation_end

	mov bl,byte[timer]
	cmp bl,128

	jb .inc_constY_animation
	jmp .dec_constY_animation
.inc_constY_animation:
	vmovaps ymm0,[delta_const_y]
	vmovaps ymm1,[const_y]
	vaddps ymm1,ymm1,ymm0
	vmovaps [const_y],ymm1
	; inc byte[delta_colour]
	; inc byte[delta_colour]
jmp .end_key_input

.dec_constY_animation:
	vmovaps ymm0,[delta_const_y]
	vmovaps ymm1,[const_y]
	vsubps ymm1,ymm1,ymm0
	vmovaps [const_y],ymm1
	; dec byte[delta_colour]
	; dec byte[delta_colour]
.animation_end:
.end_key_input:
	

	

;Exiting 
	cmp		eax, 23			;the window close button
	je		.end
	cmp		eax, 27			;ESC
	je		.end
	test	eax, eax		; 0: no more events
	jnz		.eventloop
	
	
jmp 	.mainloop_float
;-------------------DOUBLE PRECISION-------------------------------------
.double_float_entry:
	mov eax,double_mode
	call io_writestr
	xor ebx,ebx
	mov byte[timer],bl
	;Copy zoom, constants,offset from single precision
	;ZOOM
	movss xmm0,[zoom]
	cvtss2sd  xmm1,xmm0
	movsd 	 [d_zoom],xmm1
	;CONSTANTS
	movss xmm0,[const_x]
	cvtss2sd  xmm1,xmm0	
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_const_x],ymm1
	movss xmm0,[const_y]
	cvtss2sd  xmm1,xmm0
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_const_y],ymm1

	;OFFSET
	movss xmm0,[offset_x]
	cvtss2sd  xmm1,xmm0	
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_offset_x],ymm1
	movss xmm0,[offset_y]
	cvtss2sd  xmm1,xmm0
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_offset_y],ymm1
;DELTAS
	;DELTA_CONSTANTS
	movss xmm0,[delta_const_x]
	cvtss2sd  xmm1,xmm0	
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_delta_const_x],ymm1
	movss xmm0,[delta_const_y]
	cvtss2sd  xmm1,xmm0
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_delta_const_y],ymm1

	;DELTA_OFFSET
	movss xmm0,[delta_offset_x]
	cvtss2sd  xmm1,xmm0	
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_delta_offset_x],ymm1
	movss xmm0,[delta_offset_y]
	cvtss2sd  xmm1,xmm0
	vpermpd ymm1,ymm1,0;mask 00 00 00 00
	vmovupd [d_delta_offset_y],ymm1
.d_mainloop:
	
	call	gfx_map			; EAX will contain the pointer to the framebuffer
	;save the framebuffer to edi, as we will use eax later
	mov 	edi,eax
	;Loop over the rows

	xor		ecx, ecx		; ECX row (Y)
	

	;Initialize constants 
	vmovupd ymm5,[d_four]
	;ymm5:4,4,4,4
	vbroadcastsd ymm6,qword[d_zoom]
	;ymm6:zoom,zoom,zoom,zoom
	vbroadcastsd ymm3,qword[d_TWO_q]
	;ymm3:2,2,2,2

.d_loopover_rows:
	cmp		ecx, HEIGHT
	jge		.d_row_end	
	
; Loop over the columns
	xor		edx, edx		; EDX - column (X)
	
.d_loopover_columns:
	cmp		edx, WIDTH
	jge		.d_column_end


  ;	Color calculation algorithm:
  ;		we will use AVX vectorisation with double precision values,thus
  ;		calculating colours for 2 pixels in parallel
  ;		One AVX register is of 256 bits,and can hold 4 64 bit values
  ; 	two register will contain 4 coordinates for 4 pixels


  ;Next, we will:

  ;   calculate the initial real and imaginary part of z, based on the pixel location, zoom and position values
  ;   for each pixel in the AVX register,in parallel of course
  ;   newRe = 1.d_5 * (x - w / 2) / (0.d_5 * zoom * w) + moveX;
  ;   newIm = (y - h / 2) / (0.d_5 * zoom * h) + moveY;

  ;   //i will represent the number of iterations
  ;   int i;
  ;   //start the iteration process
  ;   for(i = 0; i < maxIterations; i++)
  ;   {
  ;     //remember value of previous iteration
  ;     oldRe = newRe;
  ;     oldIm = newIm;
  ;     //the actual iteration, the real and imaginary part are calculated
  ;     newRe = oldRe * oldRe - oldIm * oldIm + cRe;
  ;     newIm = 2 * oldRe * oldIm + cIm;
  ;     //if the point is outside the circle with radius 2: stop
  ;     if((newRe * newRe + newIm * newIm) > 4) break;
  ;   }
  ;	 



 
   ;Scale p1,p2 coordinates as
   ;   newRe = 1.d_5 * (x - w / 2) / (0.d_5 * zoom * w) + moveX;
   ;   newIm = (y - h / 2) / (0.d_5 * zoom * h) + moveY;

   vcvtsi2sd 	xmm0,xmm0,ecx
   ;ymm0:0,0,0,y1
   vpermilpd    xmm0,xmm0,0
   ;ymm0;y1,y1,y1,y1

   vcvtsi2sd 	xmm1,xmm1,edx
   ;ymm1;0,0,0,x1
   vpermilpd    xmm1,xmm1,0
   ;ymm1:x1,x1,x1,x1
   ;inserted first pixel,    p1

;Leaping to next pixel 
inc 		edx 
	cmp		edx, WIDTH
	jl 		.d_inline1
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.d_row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.d_inline1:

	vcvtsi2sd 	xmm0,xmm0,ecx
	;ymm0:y1y1y1y2
	vcvtsi2sd 	xmm1,xmm1,edx
	;ymm1:x1x1x1x2

   vpermpd    ymm0,ymm0,0x44  ;mask:01 00 01 00 
   ;ymm0;y1,y2,y1,y2 
   vpermpd    ymm1,ymm1,0x44  ;mask:01 00 01 00 
   ;ymm1;x1,x2,x1,x2
inc 		edx 
	cmp		edx, WIDTH
	jl 		.d_inline2
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.d_row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.d_inline2:
   
	cvtsi2sd 	xmm0,ecx
	;ymm0;y1,y2,y1,y3
	cvtsi2sd 	xmm1,edx
	;ymm1;x1,x2,x1,x3
	vpermpd    ymm7,ymm0,0xE0
    ;ymm7;y1,y2,y3,y3 mask: 11 10 00 00
    vpermpd    ymm0,ymm1,0xE0
    ;ymm0;x1,x2,x3,x3 mask: 11 10 00 00
inc 		edx 
	cmp		edx, WIDTH
	jl 		.d_inline3
	;we are at the end of a row
	inc 		ecx;leap to next row
	cmp		ecx, HEIGHT;check if we are at the end of screen
	jge		.d_row_end   ;in this case, jump out of loop

	xor		edx, edx 		;otherwise,start at the beginning of new row
.d_inline3:
	cvtsi2sd 	xmm7,ecx
	cvtsi2sd 	xmm0,edx
   ;ymm7;y1,y2,y3,y4
   ;ymm0;x1,x2,x3,x4
   ;	 p1	p2 p3 p4
   ;inserted 4 pixels
			  


;Now ymm0,ymm7 holds all 4 pixel coordinates, but these are not scaled	   
	   			mov eax,HEIGHT
	   vcvtsi2sd xmm1,eax
	   ;ymm1:0,0,0,h
	  
	   vpermpd 		ymm1,ymm1,0
	   ;ymm1:h,h,h,h	mask:00 00  00 00

	   			mov eax,WIDTH
	   vcvtsi2sd xmm2,eax
	   ;ymm2:0,0,0,w
	   

	   vpermpd ymm2,ymm2,0
	   ;ymm1:h,h,h,h    mask:00 00  00 00
	   ;ymm2:w,w,w,w

    ;ymm3:2,2,2,2 (constant )
   	;ymm7:y1,y2,y3,y4
   	;ymm0:x1,x2,x3,x4

   	vdivpd 	ymm1,ymm1,ymm3
   	;ymm1: h/2,h/2,h/2,h/2
   	vdivpd 	ymm2,ymm2,ymm3
   	;ymm2: w/2,w/2,w/2,w/2

   	vsubpd 	ymm0,ymm0,ymm2
   	;ymm0: x1-w/2,x2-w/2,x3-w/2,x4-w/2
   	vsubpd 	ymm7,ymm7,ymm1
   	;ymm7: y1-h/2,y2-h/2,y3-h/2,y4-h/2

    ;ymm6:zoom,zoom,zoom,zoom(constant in this context)

   	vmulpd 		ymm1,ymm1,ymm6
    ;ymm1: 	zoom*h/2,zoom*h/2,zoom*h/2,zoom*h/2 
    vmulpd 		ymm2,ymm2,ymm6
    ;ymm2: 	zoom*w/2,zoom*w/2,zoom*w/2,zoom*w/2 

    vdivpd 		ymm7,ymm7,ymm1
    ;ymm7:{(y1-h/2)/(zoom*h/2)},{(y2-h/2)/(zoom*h/2)},{(y3-h/2)/(zoom*h/2)},{(y4-h/2)/(zoom*h/2)}
    vdivpd 		ymm0,ymm0,ymm2
    ;ymm0:{(x1-w/2)/(zoom*w/2)},{(x2-w/2)/(zoom*w/2)},{(x3-w/2)/(zoom*w/2)},{(x4-w/2)/(zoom*w/2)}
    
    vmulpd 		ymm0,ymm0,[d_oneandhalf]
    ;ymm0:{(x1-w/2)/(zoom*w/2)*1.5},{(x2-w/2)*1.5/(zoom*w/2)*1.5},{(x3-w/2)*1.5/(zoom*w/2)*1.5},{(x4-w/2)*1.5/(zoom*w/2)*1.5}
   
    
    vaddpd 		ymm0,ymm0,[d_offset_x]
	;ymm0:{(x1-w/2)/(zoom*w/2)*1.5+ox},{(x2-w/2)/(zoom*w/2)*1.5+ox},{(x3-w/2)/(zoom*w/2)*1.5+ox},{(x4-w/2)/(zoom*w/2)*1.5+ox}
  	;	  {(x5-w/2)/(zoom*w/2)*1.5+ox},{(x6-w/2)/(zoom*w/2)*1.5+ox},{(x7-w/2)/(zoom*w/2)*1.5+ox},{(x8-w/2)/(zoom*w/2)*1.5+ox}
    vaddpd 		ymm7,ymm7,[d_offset_y]  
    ;ymm7:{(y1-h/2)/(zoom*h/2)+oy},{(y2-h/2)/(zoom*h/2)+oy},{(y3-h/2)/(zoom*h/2)+oy},{(y4-h/2)/(zoom*h/2)+oy}
   	;	  {(y5-h/2)/(zoom*h/2)+oy},{(y6-h/2)/(zoom*h/2)+oy},{(y7-h/2)/(zoom*h/2)+oy},{(y8-h/2)/(zoom*h/2)+oy}
   
    ;finished vectorized scaling of 8 pixels
  movq 	xmm1,[null]
  ;initialise iterations count
  movq [iterations],xmm1
  xor ebx,ebx
.d_iter:
	;In this loop we apply the fn(z)=(f(n-1)(z))^2+c,   function to the complex numbers derived from the scaled pixels,(in parallel)
	;until either we reach the maximum number of iterations, or all of the absolute values of our complex numbers exceed the value of 2.
	;We will keep track of the number of iterations that correspond to each complex number in the iterations field,that consists of 8 bytes,
	;in which every byte tells us how many iterations that particular pixel took before its absolute value exceeded the value of 2.
	;we will refer to the scaled values x,y that were in the ymm0,ymm7 registers as a,b, the real and imaginary part of the complex number z.

	cmp ebx,maximumIterations
	jge .d_out;reached limit of iterations
	;ymm0:a1,a2,a3,a4
	;ymm7:b1,b2,b3,b4
	vmulpd 		ymm2,ymm0,ymm0;a^2
	;ymm2:a1a1,a2a2,a3a3,a4a4
	vmulpd 		ymm4,ymm7,ymm7;b^2
	;ymm4:b1b1,b2b2,b3b3,b4b4
	vsubpd 	 	ymm2,ymm2,ymm4;a^2-b^2
	;ymm2:a1a1-b1b1,a2a2-b2b2,a3a3-b3b3,a4a4-b4b4
	
	;ymm0:a1,a2,a3,a4
	;ymm7:b1,b2,b3,b4
	vmulpd 		ymm1,ymm0,ymm7;ab
	;ymm1:a1b1,a2b2,a3b3,a4b4
	vaddpd 		ymm7,ymm1,ymm1;2ab
	;ymm7:2a1b1,2a2b2,2a3b3,2a4b4
	vaddpd 		ymm7,ymm7,[d_const_y];2ab+cy
	;ymm7:2a1b1+cy,2a2b2+cy,2a3b3+cy,2a4b4+cy
	;ymm7:B1,B2,B3,B4
	vaddpd		ymm0,ymm2,[d_const_x];a^2-b^2+cx
	;ymm0:a1a1-b1b1+cx,a2a2-b2b2+cx,a3a3-b3b3+cx,a4a4-b4b4+cx
	;ymm0:A1,A2,A3,A4
	vmulpd 		ymm1,ymm0,ymm0;A^2
	vmulpd 		ymm2,ymm7,ymm7;B^2
	vaddpd 		ymm4,ymm1,ymm2;A^2+B^2

	vcmplepd ymm1,ymm4,ymm5;we compare the squares of our absolute values to 4, which compare is equivalent to 
						   ;the comparison of the absolute values to 2
	;ymm1:mask of previous compare
	vmovmskpd eax,ymm1
	;al-extracted mask of ymm1
	test al,al
	jz .d_out;if all of the absolute values of our  comlex numbers are bigger than 2, jump out of iteration loop

	;we increment the corresponding  byte in the iterations field of those pixels only, whose 
	;absolute value is less than 2.
	
	SHR eax,1
	adc byte[iterations+3],0
	SHR eax,1
	adc byte[iterations+2],0
	SHR eax,1
	adc byte[iterations+1],0
	SHR eax,1
	adc byte[iterations],0
		
	inc ebx
jmp .d_iter
.d_out:
	;We will color these four pixels in the framebuffer according to the 
	;corresponing bytes in the iterations field.
	mov al,byte[iterations]
	add al,al
	mov byte[edi],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+1],al
	add al,al
	mov byte[edi+2],al
	mov byte[edi+3],0

		mov al,byte[iterations+1]
	add al,al
	mov byte[edi+4],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+5],al
	add al,al
	mov byte[edi+6],al
	mov byte[edi+7],0
	
		mov al,byte[iterations+2]
	add al,al
	mov byte[edi+8],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+9],al
	add al,al
	mov byte[edi+10],al
	mov byte[edi+11],0

		mov al,byte[iterations+3]
	add al,al
	mov byte[edi+12],al
	add al,[delta_colour];DELTA_COLOUR
	mov byte[edi+13],al
	add al,al
	mov byte[edi+14],al
	mov byte[edi+15],0



	

;Leap to next 4 pixel section of framebuffer	
add		edi,16   ; next pixel
;Leap to next pixel on screen
inc		edx
;jump back into the loop
jmp		.d_loopover_columns
.d_column_end:
	inc		ecx
	jmp		.d_loopover_rows
	
.d_row_end:
	call	gfx_unmap		; unmap the framebuffer
	call	gfx_draw		; draw the contents of the framebuffer 
	
	
	; Query and handle the events 
	xor		ebx, ebx		; load some constants into registers: 0, -1, 1
	mov		ecx, -1
	mov		edx, 1
	
.d_eventloop:
	;increment animation timer
	inc byte[timer]

	call	gfx_getevent
	

	

	;check button press
	cmp eax,'i'
	je .d_set_inc_constX
	cmp eax,'o'
	je .d_set_dec_constX
	cmp eax,'t'
	je .d_set_inc_constY
	cmp eax,'y'
	je .d_set_dec_constY
	cmp eax,'b'
	je .d_set_inc_zoom
	cmp eax,'k'
	je .d_set_dec_zoom
	cmp eax,'w'
	je .d_set_dec_Yoff
	cmp eax,'a'
	je .d_set_dec_Xoff
	cmp eax,'s'
	je .d_set_inc_Yoff
	cmp eax,'d'
	je .d_set_inc_Xoff
	cmp eax,'c'
	je .d_set_color_animation
	;check if button release
	cmp eax,-'i'
	je .d_unset_inc_constX
	cmp eax,-'o'
	je .d_unset_dec_constX
	cmp eax,-'t'
	je .d_unset_inc_constY
	cmp eax,-'y'
	je .d_unset_dec_constY
	cmp eax,-'b'
	je .d_unset_inc_zoom
	cmp eax,-'k'
	je .d_unset_dec_zoom
	cmp eax,-'w'
	je .d_unset_dec_Yoff
	cmp eax,-'a'
	je .d_unset_dec_Xoff
	cmp eax,-'s'
	je .d_unset_inc_Yoff
	cmp eax,-'d'
	je .d_unset_inc_Xoff
	cmp eax,-'c'
	je .d_unset_color_animation
	;check if option selected 
	cmp eax,'1'
	je .d_opt_1
	cmp eax,'2'
	je .d_opt_2
	cmp eax,'3'
	je .d_opt_3
	cmp eax,'4'
	je .d_opt_4
	cmp eax,'5'
	je .d_opt_5
	cmp eax,'6'
	je .d_opt_6
	cmp eax,'7'
	je .d_opt_7
	;check if precision change selected
	cmp eax,'x'
	je .single_float_entry
	;check if animation toggle selected
	cmp eax,'m'
	je .d_toggle_animation

	

	jmp	.d_animation

	.d_set_inc_constX:
	mov byte[movement_control],1
	 jmp .d_animation
	.d_set_dec_constX:
	mov byte[movement_control+1],1
	 jmp .d_animation
	.d_set_inc_constY:
	mov byte[movement_control+2],1
	 jmp .d_animation
	.d_set_dec_constY:
	mov byte[movement_control+3],1
	 jmp .d_animation
	.d_set_inc_zoom:
	mov byte[movement_control+4],1
	 jmp .d_animation
	.d_set_dec_zoom:
	mov byte[movement_control+5],1
	 jmp .d_animation
	.d_set_dec_Yoff:
	mov byte[movement_control+6],1
	 jmp .d_animation
	.d_set_dec_Xoff:
	mov byte[movement_control+7],1
	 jmp .d_animation
	.d_set_inc_Yoff:
	mov byte[movement_control+8],1
	 jmp .d_animation
	.d_set_inc_Xoff:
	mov byte[movement_control+9],1
	 jmp .d_animation
	.d_set_color_animation:
	mov byte[color_animate_on],1
	 jmp .d_animation


	.d_unset_inc_constX:
	mov byte[movement_control],0
	 jmp .d_animation
	.d_unset_dec_constX:
	mov byte[movement_control+1],0
	 jmp .d_animation
	.d_unset_inc_constY:
	mov byte[movement_control+2],0
	 jmp .d_animation
	.d_unset_dec_constY:
	mov byte[movement_control+3],0
	 jmp .d_animation
	.d_unset_inc_zoom:
	mov byte[movement_control+4],0
	 jmp .d_animation
	.d_unset_dec_zoom:
	mov byte[movement_control+5],0
	 jmp .d_animation
	.d_unset_dec_Yoff:
	mov byte[movement_control+6],0
	 jmp .d_animation
	.d_unset_dec_Xoff:
	mov byte[movement_control+7],0
	 jmp .d_animation
	.d_unset_inc_Yoff:
	mov byte[movement_control+8],0
	 jmp .d_animation
	.d_unset_inc_Xoff:
	mov byte[movement_control+9],0
	 jmp .d_animation
	.d_unset_color_animation:
	mov byte[color_animate_on],-1
	 jmp .d_animation

.d_toggle_animation:
	mov dl,byte[animate_on]
	neg dl
	mov byte[animate_on],dl
jmp .d_animation



.d_opt_1:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1


	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1


	vmovupd ymm0,[d_opt_1_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_1_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_1]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_1]
	vmovupd [d_delta_const_y],ymm0
	
jmp .d_animation
.d_opt_2:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1

	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

	vmovupd ymm0,[d_opt_2_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_2_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_2]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_2]
	vmovupd [d_delta_const_y],ymm0
	
jmp .d_animation
.d_opt_3:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1

	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

	vmovupd ymm0,[d_opt_3_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_3_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_3]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_3]
	vmovupd [d_delta_const_y],ymm0
	
	
jmp .d_animation
.d_opt_4:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1

	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

	vmovupd ymm0,[d_opt_4_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_4_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_4]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_4]
	vmovupd [d_delta_const_y],ymm0
	
jmp .d_animation
.d_opt_5:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1

	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

	vmovupd ymm0,[d_opt_5_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_5_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_5]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_5]
	vmovupd [d_delta_const_y],ymm0
	
	
jmp .d_animation
.d_opt_6:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1

	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

	vmovupd ymm0,[d_opt_6_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_6_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_6]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_6]
	vmovupd [d_delta_const_y],ymm0
	
	
jmp .d_animation
.d_opt_7:
	xor ebx,ebx
	mov byte[timer],bl
	movq xmm0,[d_one_q]
	movq [d_zoom],xmm0
	movq xmm0,[d_copy_inc_delta_zoom]
	movq [d_inc_delta_zoom],xmm0

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_x],ymm1

	vmovupd ymm1,[d_null_packed]
	vmovupd [d_offset_y],ymm1


	vmovupd ymm1,[d_copy_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_copy_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

	vmovupd ymm0,[d_opt_7_x]
	vmovupd [d_const_x],ymm0
	vmovupd ymm0,[d_opt_7_y]
	vmovupd [d_const_y],ymm0

	vmovupd ymm0,[d_delta_const_x_opt_7]
	vmovupd [d_delta_const_x],ymm0

	vmovupd ymm0,[d_delta_const_y_opt_7]
	vmovupd [d_delta_const_y],ymm0
	
	
.d_animation:

.d_inc_constX:
	cmp byte[movement_control],0
	je .end_d_inc_constX
	vmovupd ymm0,[d_delta_const_x]
	vmovupd ymm1,[d_const_x]
	vaddpd ymm1,ymm0,ymm1
	vmovupd [d_const_x],ymm1

.end_d_inc_constX:
.d_dec_constX:
	cmp byte[movement_control+1],0
	je .end_d_dec_constX
	vmovupd ymm0,[d_delta_const_x]
	vmovupd ymm1,[d_const_x]
	vsubpd ymm1,ymm1,ymm0
	vmovupd [d_const_x],ymm1
.end_d_dec_constX:
.d_inc_constY:
	cmp byte[movement_control+2],0
	je .end_d_inc_constY
	vmovupd ymm0,[d_delta_const_y]
	vmovupd ymm1,[d_const_y]
	vaddpd ymm1,ymm0,ymm1
	vmovupd [d_const_y],ymm1

.end_d_inc_constY:
.d_dec_constY:
	cmp byte[movement_control+3],0
	je .end_d_dec_constY
	vmovupd ymm0,[d_delta_const_y]
	vmovupd ymm1,[d_const_y]
	vsubpd ymm1,ymm1,ymm0
	vmovupd [d_const_y],ymm1

.end_d_dec_constY:
.d_inc_zoom:
	cmp byte[movement_control+4],0
	je .end_d_inc_zoom

	movq xmm0,[d_inc_delta_zoom]
	movq xmm1,[d_zoom]
	mulpd xmm1,xmm0
	movq [d_zoom],xmm1
	
	vmovupd ymm1,[d_delta_offset_x]
	vmulpd ymm1,ymm1,[d_dec_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_delta_offset_y]
	vmulpd ymm1,ymm1,[d_dec_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

.end_d_inc_zoom:
.d_dec_zoom:
	cmp byte[movement_control+5],0
	je .end_d_dec_zoom
	
	movq xmm0,[d_inc_delta_zoom]
	movq xmm1,[d_zoom]
	divpd xmm1,xmm0
	movq [d_zoom],xmm1

	vmovupd ymm1,[d_delta_offset_x]
	vdivpd ymm1,ymm1,[d_dec_delta_offset_x]
	vmovupd [d_delta_offset_x],ymm1

	vmovupd ymm1,[d_delta_offset_y]
	vdivpd ymm1,ymm1,[d_dec_delta_offset_y]
	vmovupd [d_delta_offset_y],ymm1

.end_d_dec_zoom:

.d_dec_Yoff:
	cmp byte[movement_control+6],0
	je .end_d_dec_Yoff
	vmovupd ymm0,[d_delta_offset_y]
	vmovupd ymm1,[d_offset_y]
	vsubpd ymm1,ymm1,ymm0
	vmovupd [d_offset_y],ymm1
.end_d_dec_Yoff:
.d_dec_Xoff:
	cmp byte[movement_control+7],0
	je .end_d_dec_Xoff
	vmovupd ymm0,[d_delta_offset_x]
	vmovupd ymm1,[d_offset_x]
	vsubpd ymm1,ymm1,ymm0
	vmovupd [d_offset_x],ymm1
.end_d_dec_Xoff:
.d_inc_Yoff:
	cmp byte[movement_control+8],0
	je .end_d_inc_Yoff
	vmovupd ymm0,[d_delta_offset_y]
	vmovupd ymm1,[d_offset_y]
	vaddpd ymm1,ymm1,ymm0
	vmovupd [d_offset_y],ymm1
.end_d_inc_Yoff:
.d_inc_Xoff:
	cmp byte[movement_control+9],0
	je .end_d_inc_Xoff
	vmovupd ymm0,[d_delta_offset_x]
	vmovupd ymm1,[d_offset_x]
	vaddpd ymm1,ymm1,ymm0
	vmovupd [d_offset_x],ymm1
.end_d_inc_Xoff:

;COLOR ANIMATION

mov dl,byte[color_animate_on]
cmp dl,0
jl .d_color_animation_end
	
	inc byte[delta_colour]
	inc byte[delta_colour]
	
.d_color_animation_end:
;CONSTANT ANIMATION
mov dl,byte[animate_on]
cmp dl,0
jl .d_animation_end
	mov bl,byte[timer]
	cmp bl,128

	jb .d_inc_constY_animation
	jmp .d_dec_constY_animation
.d_inc_constY_animation:
	vmovupd ymm0,[d_delta_const_y]
	vmovupd ymm1,[d_const_y]
	vaddpd ymm1,ymm1,ymm0
	vmovupd [d_const_y],ymm1
	
jmp .d_end_key_input

.d_dec_constY_animation:
	vmovupd ymm0,[d_delta_const_y]
	vmovupd ymm1,[d_const_y]
	vsubpd ymm1,ymm1,ymm0
	vmovupd [d_const_y],ymm1
	
.d_animation_end:

.d_end_key_input:
	

	

;exit
	cmp		eax, 23			; window close button
	je		.end
	cmp		eax, 27			; ESC
	je		.end
	test	eax, eax		; 0: no more events
	jnz		.d_eventloop
	
	
jmp 	.d_mainloop
	; Exit
.end:
	call	gfx_destroy
ret
    

	
	