*-----------------------------------------------------------
* Title      : P1
* Written by : Marcos ;)
* Date       : 14/08/24
* Description: Sieve of Eratosthenes Algorithm.
*              Muestra los números primos de 1 a N, seguido de ceros (los no primos) 
*              y de un contador que muestra la cantidad de números primos.
*              1 <= N <= 255     
*-----------------------------------------------------------
    ORG $1000
N:  EQU 10
P:  DS.B N
    DS.W 0
C:  DS.W 1
*--------------------------------------------
P2: DS.B N  ; Vector donde meter todos los números del 1 a N

START:                  
    MOVE.B #N,D0    ; D0 servirá para iterar sobre el vector P2
    SUBQ.B #1,D0
    LEA.L P2,A0     ; Guardamos la dirección de P2 en A0
    MOVE.B #1,D1    ; D1 serán los números que iremos metiendo en P2
INITIALLOOP:
    MOVE.B D1,(A0)+ ; Meter cada número en las posiciones de P2
    ADDQ.B #1,D1    ; Aumentar en 1 ese número
    DBRA D0,INITIALLOOP   ; Bucle hasta haber introducido todos los números

    MOVE.W #1,D0    ; Preparamos D0 para iterar de nuevo N veces
LOOP1:
    ADDQ.W #1,D0
    MOVE.W D0,D1    ; D1 tendrá el número inicial sobre el que iterar en Loop 2
    CMP.L #N,D0
    BHI ENDLOOP1    ; Si D0 es mayor a N, ya no nos interesa y finalizamos los bucles
    LEA.L P2,A0     ; Volvemos a preparar A0 en la posición inicial de P2
    ADD.W D0,A0
    SUBQ.W #1,A0
LOOP2:
    ADD.W D0,D1     ; Siguiente número
    ADD.W D0,A0
    MOVE.B #0,(A0)  ; Número descartado
    CMP.L #N,D1     ; Comparar el número que estamos mirando (D1) con N
    BHI LOOP1       ; Si D1 es mayor que N, ya no es relevante, así que vamos a la siguiente iteración del loop 1
    BRA LOOP2       ; En caso contrario, volvemos a iterar en el loop 2
ENDLOOP1:
    ;   Ahora queda copiar P2 ordenado en P, colocando los 0 a la derecha, y sumarle al contador C los números primos que haya
    ;   D0 será el número para iterar en la posición del vector, D1 será el número analizado y D2 será el contador para finalmente pasarlo a C
    LEA.L P2,A0 ;   Posición de P2 para poder acceder a los números
    LEA.L P,A1  ;   Posición donde meter los números que no sean 0
    LEA.L C,A2  ;   Al restarle 1, será la posición donde meter los 0
    SUBQ #1,A2
    MOVE.W #N,D0
    SUBQ.W #1,D0
LOOP3:
    MOVE.B (A0),D1
    CMP.W #0,D1
    BEQ IS0
    ; En este caso no es 0
    ADDQ.W #1,D2
    MOVE.B (A0),(A1)  ; Movemos el número de P2 a P
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
