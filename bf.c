#include <stdio.h>
#include <string.h>
char t[30000],*p=t,c[65536];
void r(char*s){
  int i,b;
  for(i=0;s[i];i++)switch(s[i]){
    case'>':p++;break;case'<':p--;break;
    case'+':++*p;break;case'-':--*p;break;
    case'.':putchar(*p);break;
    case',':*p=getchar();break;
    case'[':if(!*p){for(b=1;b&&s[++i];)b+=s[i]=='[',b-=s[i]==']';if(b){puts("Error: unmatched [");return;}}break;
    case']':if(*p){for(b=1;b&&i--;)b+=s[i]==']',b-=s[i]=='[';if(b){puts("Error: unmatched ]");return;}}break;
  }
}
int main(int a,char**v){
  if(a>1){
    FILE*f=fopen(v[1],"r");
    if(!f){perror(v[1]);return 1;}
    int n=fread(c,1,sizeof(c)-1,f);fclose(f);c[n]=0;r(c);
  }else{
    puts("Interactive Mode: type BF code per line (Ctrl+D to quit)");
    while(fgets(c,sizeof(c),stdin)){r(c);memset(t,0,sizeof(t));p=t;puts("");}
  }
}

