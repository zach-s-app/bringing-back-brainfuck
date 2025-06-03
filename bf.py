import sys
c=open(sys.argv[1]).read();t=[0]*9999;p=i=0
while i<len(c):
 z=c[i]
 if z=='>':p+=1
 elif z=='<':p-=1
 elif z=='+':t[p]+=1
 elif z=='-':t[p]-=1
 elif z=='.':print(chr(t[p]%256),end='')
 elif z==',':t[p]=ord(sys.stdin.read(1))
 elif z=='[':
  if not t[p]:
   o=1
   while o:i+=1;o+=(c[i]=='[')-(c[i]==']')
 elif z==']':
  if t[p]:
   o=1
   while o:i-=1;o+=(c[i]==']')-(c[i]=='[')
 i+=1

