#include "monitor.h"
#include "temu.h"
#include "watchpoint.h"

#include <stdlib.h>
#include <readline/readline.h>
#include <readline/history.h>
#include <memory.h>
#include <expr.h>



void cpu_exec(uint32_t);

void display_reg();

/* We use the `readline' library to provide more flexibility to read from stdin. */
char* rl_gets() {
	static char *line_read = NULL;

	if (line_read) {
		free(line_read);
		line_read = NULL;
	}

	line_read = readline("(temu) ");

	if (line_read && *line_read) {
		add_history(line_read);
	}

	return line_read;
}

static int cmd_help(char *args);

static int cmd_c(char *args) {
	cpu_exec(-1);
	return 0;
}

static int cmd_q(char *args) {
	return -1;
}

static int cmd_si(char *args) {  //si [N] 
	if(args == NULL){ //默认情况执行1次
		cpu_exec(1);
	}
	else{
		int step = atoi(args); //传入执行次数
		if(step < 1){
			fprintf(stderr,"error: 执行步数小于1!\n");
			return -1;
		}
		cpu_exec(step);
	}
	return 0;
}

static int cmd_info(char *args) { //info SUBCMD
	char *arg = strtok(args," ");
	if(!strcmp(arg,"r")){ //info r
		int i;
		for(i = R_ZERO; i <= R_RA; i++){ //循环打印寄存器的名字和对应值
			printf("%s:\t0x%08x\n", regfile[i], reg_w(i));
		}
		printf("\n$pc:\t0x%08x\n", cpu.pc);
		printf("$hi:\t0x%08x\n", cpu.hi);
		printf("$lo:\t0x%08x\n", cpu.lo);
	}
	else if(!strcmp(arg,"w")){ //info w
		WP *wp = gethead();
		while(wp != NULL){   //依次打印各个监视点的序号和对应值
			printf("watchpoint %d: %s 0x%x\n", wp->NO, wp->expr, wp->value);
			wp = wp->next;
		}
	}
	return 0;
}

static int cmd_p(char *args) { //p EXPR 
	bool flag;
	uint32_t num = expr(args,&flag); //计算表达式的值
	if(flag){
		printf("Expression %s:\t0x%x\t%d\n", args, num, num);
	}
	else{
		printf("Bad expression!\n");
	}
	return 0;
}

static int cmd_x(char *args) { //x N EXPR
	if(args == NULL) return 0; 

	char *token = strtok(args," ");
	if(token == NULL) return 0;  //缺少参数N
	int N = atoi(token);  //char->int

	char *EXPR = strtok(NULL," ");
	if(EXPR == NULL) return 0;//缺少参数EXPR

	bool flag;
	//求出表达式expr的值并将其作为起始内存地址addr
	uint32_t addr = expr(EXPR,&flag);
	if(flag){
		int i,j;
		for(i = 0; i < N; i++ ){
			uint32_t data = mem_read(addr + 4 * i,4); //读取内存addr[i]处的值data
			printf("0x%08x: ",addr + 4 * i);
			for(j = 0; j < 4; j++ ){
				printf("0x%02x ",data & 0xff); //每次输出data的1个字节
				data = data >> 8;
			}
			printf("\n");
		}
	}
    else{//退出
		assert(0);
	}
	return 0;
}

static int cmd_w(char *args) {  //w EXPR
	if(args == NULL) return 0;
	int ID = insertExpr(args);  //将待监视表达式记录在NO为ID的监视点结构中
    if(ID == -1) {
		printf("Invalid expression!\n");
		return 0;
	}
	printf("Add watchpoint %d\n",ID);
	return 0;
}

static int cmd_d(char *args) { //d N 
	if(args == NULL) return 0;
	int N = atoi(args);
    if(removeNode(N) == 1) {
		printf("Delete watchpoint %d\n",N);
		return 0;
	}	
	printf("head is empty!\n");
	return 0;
}


static struct {
	char *name;
	char *description;
	int (*handler) (char *);
} cmd_table [] = {
	{ "help", "Display informations about all supported commands", cmd_help },
	{ "c", "Continue the execution of the program", cmd_c },
	{ "q", "Exit TEMU", cmd_q },
	/* TODO: Add more commands */
	{ "si","Single Step",cmd_si},
	{ "info","r for print register state \n w for print watchpoint information",cmd_info},
	{ "p","Expression Evaluation",cmd_p},
	{ "x","Scan Memory",cmd_x},
	{ "w","Set Watchpoint",cmd_w},
    { "d", "Delete Watchpoint",cmd_d}
};

#define NR_CMD (sizeof(cmd_table) / sizeof(cmd_table[0]))

static int cmd_help(char *args) {
	/* extract the first argument */
	char *arg = strtok(NULL, " ");
	int i;

	if(arg == NULL) {
		/* no argument given */
		for(i = 0; i < NR_CMD; i ++) {
			printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
		}
	}
	else {
		for(i = 0; i < NR_CMD; i ++) {
			if(strcmp(arg, cmd_table[i].name) == 0) {
				printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
				return 0;
			}
		}
		printf("Unknown command '%s'\n", arg);
	}
	return 0;
}

void ui_mainloop() {
	while(1) {
		char *str = rl_gets();
		char *str_end = str + strlen(str);

		/* extract the first token as the command */
		char *cmd = strtok(str, " ");
		if(cmd == NULL) { continue; }

		/* treat the remaining string as the arguments,
		 * which may need further parsing
		 */
		char *args = cmd + strlen(cmd) + 1;
		if(args >= str_end) {
			args = NULL;
		}

		int i;
		for(i = 0; i < NR_CMD; i ++) {
			if(strcmp(cmd, cmd_table[i].name) == 0) {
				if(cmd_table[i].handler(args) < 0) { return; }
				break;
			}
		}

		if(i == NR_CMD) { printf("Unknown command '%s'\n", cmd); }
	}
}
