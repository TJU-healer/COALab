#include "soc_io.h"

int search_seq[] = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50};
int test_data[] = {17, 26, 45, 31, 88, 29, 22, 35, 41, 9};
int ans[] = {7, 16, 35, 21, -1, 19, 12, 25, 31, -1};

#define SEQ_LEN (sizeof(search_seq) / sizeof(search_seq[0]))
#define TEST_LEN (sizeof(test_data) / sizeof(test_data[0]))

int bin_search(int target, int low, int high){
    if(target < search_seq[low] || target > search_seq[high] || low > high)
        return -1;

    int middle = (low + high) / 2;
    if(search_seq[middle] == target)
        return middle;

    if(search_seq[middle] > target)
        bin_search(target, low, middle - 1);
    else
        bin_search(target, middle + 1, high);
}

int main(){
    init();
    int i, j;
    int loop = 0;
    for(i = 0; i < TEST_LEN; i++){
        int res = bin_search(test_data[i], 0, SEQ_LEN - 1);
        if(ans[i] == res)
            loop++;
        else
            break;
    }

    print_result(loop == TEST_LEN);
    while(1);

    return 0;
}