#include "watchpoint.h"
#include "expr.h"

#define NR_WP 32

static WP wp_pool[NR_WP];
static WP *head, *free_;

void init_wp_pool() {
	int i;
	for(i = 0; i < NR_WP; i ++) {
		wp_pool[i].NO = i;
		wp_pool[i].next = &wp_pool[i + 1];
	}
	wp_pool[NR_WP - 1].next = NULL;

	head = NULL;
	free_ = wp_pool;
}

WP* new_wp(){ //从free_链表中返回一个空闲的监视点结构
	if(free_ == NULL) assert(0);
	else {
		WP *ret = free_;
		free_ = ret -> next;
		ret -> next = NULL;
		return ret;
	}

}

void wp_free(WP *wp){ //将wp归还到 free_链表中
	wp->next = free_;
	free_ = wp;
}

WP* gethead(){ //返回使用中的监视点结构指针
	return head;
}

int insertExpr(char *e){  //将待监测表达式记录在监测点结构体中
	bool success = false;
	uint32_t value = expr(e, &success);
	if(success == false) 
		return -1;
	WP *wp = new_wp();
	wp->next = head;
	strcpy(wp->expr, e);
	wp->value = value;
	head = wp;
	return wp->NO;
}

int removeNode(int id) { //删除NO为id的监视点结构
	if(head == NULL)
		return 0;
	if(head->NO == id){
		WP* tmp = head;
		head = head->next;
		wp_free(tmp);
		return 1;
	}
	WP* now = head;
	while(now->next != NULL) {
		if(now->next->NO == id) {
			WP* tmp = now->next;
			now->next = now->next->next;
			wp_free(tmp);
			return 1;
		}
		now = now->next;
	}
	return 0;
}

int Isequal_expr(WP *wp) { //判断待监测表达式的值是否发生改变
	if(wp == NULL)
		return 1;
	bool success = false;
	uint32_t value = expr(wp->expr, &success);
	if(success == false)
		return -1;  //fail
	if(value == wp->value)
		return 1;
	printf("In watchpoint %d: last value is 0x%x, current value is 0x%x\n", wp->NO, wp->value, value);
	wp->value = value;
	//print the value of this expression
	return 0;
}

/* TODO: Implement the functionality of watchpoint */


