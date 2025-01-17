*-----------------------------------------------------------
* Title      : P1
* Written by : Marcos ;)
* Date       : 14/08/24
* Description: Sieve of Eratosthenes Algorithm.
*              Muestra los n�meros primos de 1 a N, seguido de ceros (los no primos) 
*              y de un contador que muestra la cantidad de n�meros primos.
*              1 <= N <= 255     
*-----------------------------------------------------------
    ORG $1000
N:  EQU 10
P:  DS.B N
    DS.W 0
C:  DS.W 1
*--------------------------------------------
P2: DS.B N  ; Vector donde meter todos los n�meros del 1 a N

START:                  
    MOVE.B #N,D0    ; D0 servir� para iterar sobre el vector P2
    SUBQ.B #1,D0
    LEA.L P2,A0     ; Guardamos la direcci�n de P2 en A0
    MOVE.B #1,D1    ; D1 ser�n los n�meros que iremos metiendo en P2
INITIALLOOP:
    MOVE.B D1,(A0)+ ; Meter cada n�mero en las posiciones de P2
    ADDQ.B #1,D1    ; Aumentar en 1 ese n�mero
    DBRA D0,INITIALLOOP   ; Bucle hasta haber introducido todos los n�meros

    MOVE.W #1,D0    ; Preparamos D0 para iterar de nuevo N veces
LOOP1:
    ADDQ.W #1,D0
    MOVE.W D0,D1    ; D1 tendr� el n�mero inicial sobre el que iterar en Loop 2
    CMP.L #N,D0
    BHI ENDLOOP1    ; Si D0 es mayor a N, ya no nos interesa y finalizamos los bucles
    LEA.L P2,A0     ; Volvemos a preparar A0 en la posici�n inicial de P2
    ADD.W D0,A0
    SUBQ.W #1,A0
LOOP2:
    ADD.W D0,D1     ; Siguiente n�mero
    ADD.W D0,A0
    MOVE.B #0,(A0)  ; N�mero descartado
    CMP.L #N,D1     ; Comparar el n�mero que estamos mirando (D1) con N
    BHI LOOP1       ; Si D1 es mayor que N, ya no es relevante, as� que vamos a la siguiente iteraci�n del loop 1
    BRA LOOP2       ; En caso contrario, volvemos a iterar en el loop 2
ENDLOOP1:
    ;   Ahora queda copiar P2 ordenado en P, colocando los 0 a la derecha, y sumarle al contador C los n�meros primos que haya
    ;   D0 ser� el n�mero para iterar en la posici�n del vector, D1 ser� el n�mero analizado y D2 ser� el contador para finalmente pasarlo a C
    LEA.L P2,A0 ;   Posici�n de P2 para poder acceder a los n�meros
    LEA.L P,A1  ;   Posici�n donde meter los n�meros que no sean 0
    LEA.L C,A2  ;   Al restarle 1, ser� la posici�n donde meter los 0
    SUBQ #1,A2
    MOVE.W #N,D0
    SUBQ.W #1,D0
LOOP3:
    MOVE.B (A0),D1
    CMP.W #0,D1
    BEQ IS0
    ; En este caso no es 0
    ADDQ.W #1,D2
    MOVE.B (A0),(A1)  ; Movemos el n�mero de P2 a P
    ADDQ.W #1,A1
    ADDQ.W #1,A0
    DBRA D0,LOOP3
    BRA FINAL
IS0:
    ; En este caso es 0
    MOVE.B (A0),(A2)
    ADDQ.W #1,A0
    SUBQ.W #1,A2
    DBRA D0,LOOP3
FINAL:
    MOVE.W D2,C
    CMP.B #$FF,(A2)
    BNE FINALIZAR
    MOVE.B #0,(A2)
FINALIZAR:    
    SIMHALT             ; halt simulator

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
