// LCD module connections
 sbit LCD_RS at RD2_bit;
 sbit LCD_EN at RD3_bit;
 sbit LCD_D4 at RD4_bit;
 sbit LCD_D5 at RD5_bit;
 sbit LCD_D6 at RD6_bit;
 sbit LCD_D7 at RD7_bit;
 sbit LCD_RS_Direction at TRISD2_bit;
 sbit LCD_EN_Direction at TRISD3_bit;
 sbit LCD_D4_Direction at TRISD4_bit;
 sbit LCD_D5_Direction at TRISD5_bit;
 sbit LCD_D6_Direction at TRISD6_bit;
 sbit LCD_D7_Direction at TRISD7_bit;
 // End LCD module connections
 ////// MQ-2 gas sensor interfacing with pic microcontroller ///////

int gas_value;
char text[10];

 ////////neeeeewline//////////////////////
 void newline()
{
  Uart1_write (0x0d);
  Uart1_write (0x0a);
}
//////////Main_FUNC///////////
void main() {
trisc=0;
portc.f0=1;
 ADC_Init();
 uart1_Init (9600);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF); // cursor off
 Lcd_Cmd(_LCD_CLEAR); // clear LCD
 Lcd_Out(1, 3, "We are SPEE");
 Uart1_write_Text ("We are SPEE");
//Uart1_Write_Text (txt);
newline();
delay_ms(2700);
Lcd_Cmd(_LCD_CLEAR);// clear LCD
delay_ms(280);
 while(1){

 //---------------------GAS SENSOR-----------------
gas_value = ADC_Read(0); // It will read the gas value of sensor
if( gas_value > 270 ){
Lcd_Out(1,1, "Gas detected" );
 Uart1_write_Text ("Gas detected");
  intToStr(gas_value, text);
Lcd_Out(2,1, text );
Uart1_Write_Text (text);
newline();
portc.f1=1;
delay_ms(600);

}
else
{
Lcd_Out(1,4, "No Gas " );
Uart1_write_Text ("No Gas ");
intToStr(gas_value, Ltrim(text));
Lcd_Out(2,1, text );
Uart1_Write_Text (text);
newline();
portc.f1=0;
delay_ms(600);

}

 delay_ms(500);

  Lcd_Cmd(_LCD_CLEAR); // clear LCD
 }
}