#include<stdio.h>
#include<stdint.h>

int main ()
{
  union u_num {
    float xf;
    uint32_t xi;
  } num;  

  num.xf = 3060.0;
  printf("%x\n", num.xi);
  
  return 0;
}
