
_newline:

;MyProject.c,21 :: 		void newline()
;MyProject.c,23 :: 		Uart1_write (0x0d);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,24 :: 		Uart1_write (0x0a);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,25 :: 		}
L_end_newline:
	RETURN
; end of _newline

_main:

;MyProject.c,27 :: 		void main() {
;MyProject.c,28 :: 		trisc=0;
	CLRF       TRISC+0
;MyProject.c,29 :: 		portc.f0=1;
	BSF        PORTC+0, 0
;MyProject.c,30 :: 		ADC_Init();
	CALL       _ADC_Init+0
;MyProject.c,31 :: 		uart1_Init (9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,32 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,33 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,34 :: 		Lcd_Cmd(_LCD_CLEAR); // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,35 :: 		Lcd_Out(1, 3, "We are SPEE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,36 :: 		Uart1_write_Text ("We are SPEE");
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,38 :: 		newline();
	CALL       _newline+0
;MyProject.c,39 :: 		delay_ms(2700);
	MOVLW      28
	MOVWF      R11+0
	MOVLW      101
	MOVWF      R12+0
	MOVLW      232
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;MyProject.c,40 :: 		Lcd_Cmd(_LCD_CLEAR);// clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,41 :: 		delay_ms(280);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      216
	MOVWF      R12+0
	MOVLW      65
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;MyProject.c,42 :: 		while(1){
L_main2:
;MyProject.c,45 :: 		gas_value = ADC_Read(0); // It will read the gas value of sensor
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _gas_value+0
	MOVF       R0+1, 0
	MOVWF      _gas_value+1
;MyProject.c,46 :: 		if( gas_value > 270 ){
	MOVLW      128
	XORLW      1
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVF       R0+0, 0
	SUBLW      14
L__main11:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;MyProject.c,47 :: 		Lcd_Out(1,1, "Gas detected" );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,48 :: 		Uart1_write_Text ("Gas detected");
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,49 :: 		intToStr(gas_value, text);
	MOVF       _gas_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _gas_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _text+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,50 :: 		Lcd_Out(2,1, text );
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,51 :: 		Uart1_Write_Text (text);
	MOVLW      _text+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,52 :: 		newline();
	CALL       _newline+0
;MyProject.c,53 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;MyProject.c,54 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;MyProject.c,56 :: 		}
	GOTO       L_main6
L_main4:
;MyProject.c,59 :: 		Lcd_Out(1,4, "No Gas " );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,60 :: 		Uart1_write_Text ("No Gas ");
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,61 :: 		intToStr(gas_value, Ltrim(text));
	MOVLW      _text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_output+0
	MOVF       _gas_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _gas_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	CALL       _IntToStr+0
;MyProject.c,62 :: 		Lcd_Out(2,1, text );
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,63 :: 		Uart1_Write_Text (text);
	MOVLW      _text+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,64 :: 		newline();
	CALL       _newline+0
;MyProject.c,65 :: 		portc.f1=0;
	BCF        PORTC+0, 1
;MyProject.c,66 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
;MyProject.c,68 :: 		}
L_main6:
;MyProject.c,70 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;MyProject.c,72 :: 		Lcd_Cmd(_LCD_CLEAR); // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,73 :: 		}
	GOTO       L_main2
;MyProject.c,74 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
