#include <msp430.h>

int main(void)
{
  volatile unsigned int i;

  WDTCTL = WDTPW+WDTHOLD;                   
  P1DIR |= BIT0;                          

  while(1)                               
  {
    P1OUT ^= BIT0;                        
    for(i=50000;i>0;i--);                  
  }
}
