#include<stdio.h>
#include<stdint.h>

int main ()
{
  union u_num {
    float xf;
    uint32_t xi;
  } num;  

  num.xf = 1156.36;
  printf("%x\n", num.xi);
  
  return 0;
}
