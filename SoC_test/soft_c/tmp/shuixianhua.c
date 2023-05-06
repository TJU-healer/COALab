#include <stdio.h>

int ans[] = {153, 370, 371, 407};
#define ANS_LEN (sizeof(ans) / sizeof(ans[0]))

int cube(int x){
    return x * x * x;
}

int main(){
    int flag = 0;
    int loop = 0;
    for(int i = 100; i <= 999; i++){
        int a, b, c, tmp = i;
        tmp = tmp % 100;
        a = i / 100;
        b = tmp / 10;
        c = tmp % 10;
        if(cube(a) + cube(b) + cube(c) == i){
            if(ans[loop] == i)
                loop++;
            else
                flag = 1;
        }
    }

    if(loop != ANS_LEN)
        flag = 1;

    printf("%d\n", flag);

    return 0;
}