#include <stdio.h>
#include <conio.h>

void main()
{
	int num,n,arr[30],temp;
	int i =0,min,max;
	clrscr();
	printf("Enter the number of elements:");
	scanf("%d", &n);
    printf("Enter elements:");
    for(i=0; i<n; i++)
    {
	scanf("%d", &arr[i]);
    }

	printf("\n");
    min =arr[0];
    max=arr[0];
    n= n-1;
    i=0;

    asm mov cx, n
    outer:
	i= i+1;
	temp=arr[i];
	asm mov bx, temp
	asm cmp bx, min
	asm jnc label1
	asm mov min, bx
	label1:

	asm cmp bx, max
	asm jc label2
	asm mov max, bx
	label2:
	asm loop outer

	printf("The minimum value entered is: %d", min);
	printf("The maximum value entered is: %d", max);

	getch();

}
