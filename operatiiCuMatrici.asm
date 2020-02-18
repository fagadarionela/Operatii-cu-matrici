.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern scanf: proc
extern fscanf: proc
extern printf: proc
extern fprintf: proc
extern fopen : proc
extern fclose : proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
matrice_c dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
matrice_a dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
matrice_b dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0
		  dd 0,0,0,0,0,0,0,0,0,0

formata db "matrice_a.txt",0
formatb db "matrice_b.txt",0
formatrez db "rezultat.txt",0
mod_scriere db "w",0
formatnu db "nu se poate realiza",0
datistring db "Dati operatia:",13,10,"1.A+B sau B+A",13,10,"2.A-B",13,10,"3.B-A",13,10,"4.aA",13,10,"5.aB",13,10,"6.trA",13,10,"7.trB",13,10,"8.detA",13,10,"9.detB",13,10,0
operatie db 0
formats db "%s",0
mod_citire db "r",0
formatd db "%d ",0
formatdd db "%d",0
formatlinienoua db 10,13,0
pointer_fisier dd -1
pointer_scriere dd -1  
nra dd 0
nrb dd 0
rez dd 0
dimensiune_matrice_a dd 0
dimensiune_matrice_b dd 0
scalar dd 0
var1 dd 0
nr3 dd 3
aplusb db "A+B",0
bplusa db "B+A",0
fisierrezultat db 13,10,"Rezultat:rezultat.txt",13,10,0
.code

citirea PROC
	push EBP
	mov EBP,ESP
	mov eax,0
	
	push offset mod_citire
	push offset formata
	call fopen
	add ESP,8
	mov [pointer_fisier],eax
	
	mov ecx,0
	
	push offset nra
	push offset formatd
	push pointer_fisier
	call fscanf
	add esp,12
	
	mov eax,0
	mov eax,nra
	mul nra
	mov edi,4
	mul edi
	mov dimensiune_matrice_a,eax
	
	; push dimensiune_matrice_a
		; push offset formatd
		; call printf
		; add esp,8
	
	mov eax,nra
	mov edi,4
	mul edi
	mov nra,eax
	
	mov esi, 0 ;pentru parcurgerea coloanelor
	mov ebx, 0 ;pentru parcurgerea liniilor
	mov edx,0
	lea edx,matrice_a ;contor
	;mov ecx,nra
	
	etichetai:
	mov esi,0
	etichetaj:
	push edx
	push ebx
	push esi
	push ecx
		push edx
		push offset formatd
		push pointer_fisier
		call fscanf
		add esp,12
	pop ecx
	pop esi
	pop ebx
	pop edx
		; mov eax, 0
		; add eax,matrice_a[ebx+esi]
	add edx,4
	; push edx
	; push ebx
	add esi,4
	; push esi
		; push eax
		; push offset formatd
		; call printf
		; add esp,8
	; pop esi
	; pop ebx
	; pop edx

	
	cmp esi,nra
	jb etichetaj
	add ebx,nra
	
	cmp ebx,dimensiune_matrice_a
	jb etichetai
	 
	push pointer_fisier
	call fclose
	add esp,4
	
	mov ESP,EBP
	pop EBP
	ret 0
	 
citirea ENDP

citireb PROC
		push EBP
	mov EBP,ESP
	mov eax,0
	
	push offset mod_citire
	push offset formatb
	call fopen
	add ESP,8
	mov [pointer_fisier],eax
	
	mov ecx,0
	
	push offset nrb
	push offset formatd
	push pointer_fisier
	call fscanf
	add esp,12
	
	mov eax,0
	mov eax,nrb
	mul nrb
	mov edi,4
	mul edi
	mov dimensiune_matrice_b,eax
	
	; push dimensiune_matrice_b
		; push offset formatd
		; call printf
		; add esp,8
	
	mov eax,nrb
	mov edi,4
	mul edi
	mov nrb,eax
	
	mov esi, 0 ;pentru parcurgerea coloanelor
	mov ebx, 0 ;pentru parcurgerea liniilor
	mov edx,0
	lea edx,matrice_b ;contor
	;mov ecx,nra
	
	etichetai:
	mov esi,0
	etichetaj:
	push edx
	push ebx
	push esi
	push ecx
		push edx
		push offset formatd
		push pointer_fisier
		call fscanf
		add esp,12
	pop ecx
	pop esi
	pop ebx
	pop edx
		mov eax, 0
		add eax,matrice_b[ebx+esi]
	add edx,4
	; push edx
	; push ebx
	add esi,4
	; push esi
		; push eax
		; push offset formatd
		; call printf
		; add esp,8
	; pop esi
	; pop ebx
	; pop edx

	
	cmp esi,nrb
	jb etichetaj
	add ebx,nrb
	
	cmp ebx,dimensiune_matrice_b
	jb etichetai
	 
	push pointer_fisier
	call fclose
	add esp,4
	
	mov ESP,EBP
	pop EBP
	ret 0
citireb ENDP
adunare PROC
	push EBP
	mov EBP,ESP

	mov ebx,0
	
	etichetai:
	mov esi,0
	etichetaj:
	mov eax, 0
	add eax,matrice_a[ebx+esi]
	add eax,matrice_b[ebx+esi]
	mov matrice_c[ebx+esi],eax

	push ebx
	 
	push esi
	mov eax,0
		mov eax,matrice_c[ebx+esi]
		push eax
		push eax
		push offset formatd
		call printf
		add esp,8
		
		pop eax
		push eax
		push offset formatd
		push pointer_scriere
		call fprintf
		add esp,12
	pop esi
	pop ebx
	add esi,4
	 
	cmp esi,nrb
	jb etichetaj
	add ebx,nrb
	
	push ebx
	push esi
		push offset formatlinienoua
		call printf
		add esp,4
		
		push offset formatlinienoua
		push pointer_scriere
		call fprintf
		add esp,8
	pop esi
	pop ebx
	
	cmp ebx,dimensiune_matrice_b
	jb etichetai
	 
	mov ESP,EBP
	pop EBP
	ret 0
adunare ENDP
inmultirescalara PROC
	push EBP
	mov EBP,ESP

	mov ebx,0
	
	push offset scalar
	push offset formatdd
	call scanf
	add esp,8
	
	
	etichetai:
	mov esi,0
	etichetaj:
	mov eax,0
	mov eax,matrice_a[ebx+esi]
	mul scalar
	mov matrice_c[ebx+esi],eax
	
	push ebx
	push esi
	mov eax,0
		mov eax,matrice_c[ebx+esi]
		push eax
		push eax
		push offset formatd
		call printf
		add esp,8
		
		pop eax
		push eax
		push offset formatd
		push pointer_scriere
		call fprintf
		add esp,12
	pop esi
	pop ebx
	add esi,4
	 
	cmp esi,nra
	jb etichetaj
	
	add ebx,nra
	
	push ebx
	push esi
		push offset formatlinienoua
		call printf
		add esp,4
		
		push offset formatlinienoua
		push pointer_scriere
		call fprintf
		add esp,8
	pop esi
	pop ebx
	cmp ebx,dimensiune_matrice_a
	jb etichetai
	 
	 mov ESP,EBP
	 pop EBP
	 ret 0
inmultirescalara ENDP
inmultirescalarb PROC
	push EBP
	mov EBP,ESP

	mov ebx,0
	
	push offset scalar
	push offset formatdd
	call scanf
	add esp,8
	
	
	etichetai:
	mov esi,0
	etichetaj:
	mov eax,0
	mov eax,matrice_b[ebx+esi]
	mul scalar
	mov matrice_c[ebx+esi],eax
	
	push ebx
	push esi
	mov eax,0
		mov eax,matrice_c[ebx+esi]
		push eax
		push eax
		push offset formatd
		call printf
		add esp,8
		
		pop eax
		push eax
		push offset formatd
		push pointer_scriere
		call fprintf
		add esp,12
	pop esi
	pop ebx
	add esi,4
	 
	cmp esi,nrb
	jb etichetaj
	
	add ebx,nrb
	
	push ebx
	push esi
		push offset formatlinienoua
		call printf
		add esp,4
		
		push offset formatlinienoua
		push pointer_scriere
		call fprintf
		add esp,8
	pop esi
	pop ebx
	cmp ebx,dimensiune_matrice_b
	jb etichetai
	 
	 mov ESP,EBP
	 pop EBP
	 ret 0
inmultirescalarb ENDP
scadereab PROC
	push EBP
	mov EBP,ESP
	mov edi, [ebp+8]
	mov ebx, 0
	etichetai:
	mov esi,0
	etichetaj:
	mov eax,0
	cmp edi, 1
	je bminusa
		mov eax,matrice_a[ebx+esi]
		sub eax,matrice_b[ebx+esi]
		jmp mov_c
	bminusa:
		mov eax,matrice_b[ebx+esi]
		sub eax,matrice_a[ebx+esi]
	mov_c:
	mov matrice_c[ebx+esi],eax
	
	push ebx
	push esi
	mov eax,0
		mov eax,matrice_c[ebx+esi]
		push eax
		push eax
		push offset formatd
		call printf
		add esp,8
		
		pop eax
		push eax
		push offset formatd
		push pointer_scriere
		call fprintf
		add esp,12
	pop esi
	pop ebx
	add esi,4
	 
	cmp esi,nra
	jb etichetaj
	
	add ebx,nra
	
	
	push ebx
	push esi
		push offset formatlinienoua
		call printf
		add esp,4
		
		push offset formatlinienoua
		push pointer_scriere
		call fprintf
		add esp,8
	pop esi
	pop ebx
	
	cmp ebx,dimensiune_matrice_a
	jb etichetai
	 
	mov ESP,EBP
	pop EBP
	ret 
scadereab ENDP	
transpusaa PROC
	push EBP
	mov EBP,ESP
	mov eax,0				;contorizare matrice_c
	mov esi,0 				;ESI pt linii
	etichetai:
	
	mov ebx,esi				
	etichetaj:
	mov edx,matrice_a[ebx]
	mov matrice_c[eax],edx
	add eax,4
	add ebx,nra
	
	cmp ebx,dimensiune_matrice_a
	jb etichetaj

	
	add esi,4
	cmp esi,nra
	jb etichetai
	 
	; mov eax,0
	; etichetaip:
	; push eax
	; push matrice_c[eax]
	; push offset formatd
	; call printf
	; add esp,8
	; pop eax
	; add eax,4
	
	; cmp eax,dimensiune_matrice_a
	; jb etichetaip
	
	mov ebx, 0
	etichetaip:
	mov esi,0
	etichetajp:
	
	push ebx
	push esi
	mov eax,0
		mov eax,matrice_c[ebx+esi]
		push eax
		push eax
		push offset formatd
		call printf
		add esp,8
		
		pop eax
		push eax
		push offset formatd
		push pointer_scriere
		call fprintf
		add esp,12
	pop esi
	pop ebx
	add esi,4
	 
	cmp esi,nra
	jb etichetajp
	
	add ebx,nra
	
	
	push ebx
	push esi
		push offset formatlinienoua
		call printf
		add esp,4
		
		push offset formatlinienoua
		push pointer_scriere
		call fprintf
		add esp,8
	pop esi
	pop ebx
	
	cmp ebx,dimensiune_matrice_a
	jb etichetaip
	
	mov ESP,EBP
	pop EBP
	ret 0
transpusaa ENDP	
transpusab PROC
	push EBP
	mov EBP,ESP
	mov eax,0				;contorizare matrice_c
	mov esi,0 				;ESI pt linii
	etichetai:
	
	mov ebx,esi				
	etichetaj:
	mov edx,matrice_b[ebx]
	mov matrice_c[eax],edx
	add eax,4
	add ebx,nrb
	
	cmp ebx,dimensiune_matrice_b
	jb etichetaj

	
	add esi,4
	cmp esi,nrb
	jb etichetai
	 
	; mov eax,0
	; etichetaip:
	; push eax
	; push matrice_c[eax]
	; push offset formatd
	; call printf
	; add esp,8
	; pop eax
	; add eax,4
	
	; cmp eax,dimensiune_matrice_b
	; jb etichetaip
	
		mov ebx, 0
	etichetaip:
	mov esi,0
	etichetajp:
	
	push ebx
	push esi
	mov eax,0
		mov eax,matrice_c[ebx+esi]
		push eax
		push eax
		push offset formatd
		call printf
		add esp,8
		
		pop eax
		push eax
		push offset formatd
		push pointer_scriere
		call fprintf
		add esp,12
	pop esi
	pop ebx
	add esi,4
	 
	cmp esi,nra
	jb etichetajp
	
	add ebx,nra
	
	
	push ebx
	push esi
		push offset formatlinienoua
		call printf
		add esp,4
		
		push offset formatlinienoua
		push pointer_scriere
		call fprintf
		add esp,8
	pop esi
	pop ebx
	
	cmp ebx,dimensiune_matrice_a
	jb etichetaip
	
	
	mov ESP,EBP
	pop EBP
	ret 0
transpusab ENDP	
determinanta PROC
	push EBP
	mov EBP,ESP 
	cmp nra,12
	ja nuseface
	cmp nra,12
	je trei
	cmp nra,8
	je doi
	cmp nra,4 
	je unu
trei:
	mov eax,1
	mov ecx,matrice_a[0]
	mul ecx
	mov ecx,matrice_a[16]
	mul ecx
	mov ecx,matrice_a[32]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_a[4]
	mul ecx
	mov ecx,matrice_a[20]
	mul ecx
	mov ecx,matrice_a[24]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_a[8]
	mul ecx
	mov ecx,matrice_a[12]
	mul ecx
	mov ecx,matrice_a[28]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_a[8]
	mul ecx
	mov ecx,matrice_a[16]
	mul ecx
	mov ecx,matrice_a[24]
	mul ecx
	sub rez,eax
	
	mov eax,1
	mov ecx,matrice_a[20]
	mul ecx
	mov ecx,matrice_a[28]
	mul ecx
	mov ecx,matrice_a[0]
	mul ecx
	sub rez,eax
	
	mov eax,1
	mov ecx,matrice_a[4]
	mul ecx
	mov ecx,matrice_a[12]
	mul ecx
	mov ecx,matrice_a[32]
	mul ecx
	sub rez,eax
	
	push rez
	push offset formatd
	call printf
	
	push rez
	push offset formatd
	push pointer_scriere
	call fprintf
	add esp,12
	
	jmp seface

doi:
	mov eax,1
	mov ecx,matrice_a[0]
	mul ecx
	mov ecx,matrice_a[12]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_a[4]
	mul ecx
	mov ecx,matrice_a[8]
	mul ecx
	sub rez,eax
	
	push rez
	push offset formatd
	call printf
	
	push rez
	push offset formatd
	push pointer_scriere
	call fprintf
	add esp,12
	
	jmp seface
unu:
	push ebx
	push offset formatd
	call printf
	
	push rez
	push offset formatd
	push pointer_scriere
	call fprintf
	add esp,12
	
	jmp seface
	
nuseface:
	push offset formatnu
	call printf
	
seface:
	mov ESP,EBP
	pop EBP
	ret 0
determinanta ENDP	
determinantb PROC
	push EBP
	mov EBP,ESP 
	cmp nrb,12
	ja nuseface
	cmp nrb,12
	je trei
	cmp nrb,8
	je doi
	cmp nrb,4 
	je unu
trei:
	mov eax,1
	mov ecx,matrice_b[0]
	mul ecx
	mov ecx,matrice_b[16]
	mul ecx
	mov ecx,matrice_b[32]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_b[4]
	mul ecx
	mov ecx,matrice_b[20]
	mul ecx
	mov ecx,matrice_b[24]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_b[8]
	mul ecx
	mov ecx,matrice_b[12]
	mul ecx
	mov ecx,matrice_b[28]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_b[8]
	mul ecx
	mov ecx,matrice_b[16]
	mul ecx
	mov ecx,matrice_b[24]
	mul ecx
	sub rez,eax
	
	mov eax,1
	mov ecx,matrice_b[20]
	mul ecx
	mov ecx,matrice_b[28]
	mul ecx
	mov ecx,matrice_b[0]
	mul ecx
	sub rez,eax
	
	mov eax,1
	mov ecx,matrice_b[4]
	mul ecx
	mov ecx,matrice_b[12]
	mul ecx
	mov ecx,matrice_b[32]
	mul ecx
	sub rez,eax
	
	push rez
	push offset formatd
	call printf
	
	push rez
	push offset formatd
	push pointer_scriere
	call fprintf
	add esp,12
	
	jmp seface

doi:
	mov eax,1
	mov ecx,matrice_b[0]
	mul ecx
	mov ecx,matrice_b[12]
	mul ecx
	add rez,eax
	
	mov eax,1
	mov ecx,matrice_b[4]
	mul ecx
	mov ecx,matrice_b[8]
	mul ecx
	sub rez,eax
	
	push rez
	push offset formatd
	call printf
	
	push rez
	push offset formatd
	push pointer_scriere
	call fprintf
	add esp,12
	
	jmp seface
unu:
	push ebx
	push offset formatd
	call printf
	
	push rez
	push offset formatd
	push pointer_scriere
	call fprintf
	add esp,12
	
	jmp seface
	
nuseface:
	push offset formatnu
	call printf
	
seface:
	mov ESP,EBP
	pop EBP
	ret 0
determinantb ENDP	
start:
	;aici se scrie codul
	push offset datistring
	call printf
	add esp,4
	
	push offset operatie
	push offset formatdd
	call scanf
	add esp,8
	
	
	
	push offset mod_scriere
	push offset formatrez
	call fopen
	add ESP,8
	mov [pointer_scriere],eax
	
	; push offset operatie
	; push offset formatdd
	; call printf
	; add esp,8
	call citirea
		; push offset formatlinienoua
		; call printf
		; add esp,4
	 call citireb
	; push offset formatlinienoua
		  ; call printf
		  ; add esp,4
		  
	cmp operatie,1
	je aduna
	cmp operatie,2
	je s1
	cmp operatie,3
	je s2
	cmp operatie,4
	je s3
	cmp operatie,5
	je s4
	cmp operatie,6
	je s5
	cmp operatie,7
	je s6
	cmp operatie,8
	je s7
	cmp operatie,9
	je s8
aduna:		  
	call adunare
		push offset formatlinienoua
		call printf
		add esp,4
jmp final
s3:
	call inmultirescalara
		push offset formatlinienoua
		call printf
		add esp,4
jmp final		
s4:		
	call inmultirescalarb
		push offset formatlinienoua
		call printf
		add esp,4
jmp final	
s1:
	mov eax,0
	push eax
	call scadereab
	add esp,4
		push offset formatlinienoua
		call printf
		add esp,4
jmp final
s2:
	mov eax,1
	push eax
	call scadereab
	add esp,4	
		push offset formatlinienoua
		call printf
		add esp,4
jmp final
s5:	
	call transpusaa
		push offset formatlinienoua
		call printf
		add esp,4
jmp final		
s6:
	 call transpusab
		push offset formatlinienoua
		call printf
		add esp,4
jmp final
s7:
	 call determinanta
		push offset formatlinienoua
		call printf
		add esp,4
jmp final
s8:
	 call determinantb
		push offset formatlinienoua
		call printf
		add esp,4
jmp final
final:
	push pointer_fisier
	call fclose
	add esp,4
	
	push offset fisierrezultat
	call printf
	add esp,4
	;terminarea programului
	push 0
	call exit
end start
