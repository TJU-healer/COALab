#include "temu.h"

/* We use the POSIX regex functions to process regular expressions.
 * Type 'man regex' for more information about POSIX regex functions.
 */
#include <sys/types.h>
#include <regex.h>

enum {
	NOTYPE = 0, PLUS, MINUS, STAR, DIV,
	EQ, NOTEQ, OR, AND,
 	NOT, NEG, POINTER,
	LB, RB, HEX, DEC, REG,
	/* TODO: Add more token types */

};

/*priority*/
//const char *PRE = "04455331266600000";
const int PRE[] = {0, 4, 4, 5, 5, 3, 3, 1, 2, 6, 6, 6, 0, 0, 0, 0, 0, 0};

static struct rule {
	char *regex;
	int token_type;
} rules[] = {

	/* TODO: Add more rules.
	 * Pay attention to the precedence level of different rules.
	 */

	{" +",	NOTYPE},				// spaces:0
	{"\\+", PLUS},					// plus:4
	{"-", MINUS},					// minus:4
	{"\\*", STAR},					// star:5
	{"/", DIV},						// div:5
	{"==", EQ},						// equal:3
	{"!=", NOTEQ},					// noteq:3
	{"&&", AND},					// and:1
	{"\\|\\|", OR},					// or:2
	{"!", NOT},						// not:6
	{"\\(", LB},					// lb:6
	{"\\)", RB},					// rb:6
	{"0[xX][0-9a-zA-Z]+", HEX},		// hex:0
	{"[0-9]+", DEC},				// dec:0
	{"\\$[a-z0-9]+", REG}			// reg:0
};

#define NR_REGEX (sizeof(rules) / sizeof(rules[0]) )

static regex_t re[NR_REGEX];

/* Rules are used for many times.
 * Therefore we compile them only once before any usage.
 */
void init_regex() {
	int i;
	char error_msg[128];
	int ret;

	for(i = 0; i < NR_REGEX; i ++) {
		ret = regcomp(&re[i], rules[i].regex, REG_EXTENDED);
		if(ret != 0) {
			regerror(ret, &re[i], error_msg, 128);
			Assert(ret == 0, "regex compilation failed: %s\n%s", error_msg, rules[i].regex);
		}
	}
}

typedef struct token {
	int type;
	char str[32];
} Token;

Token tokens[32];
int nr_token;

static bool make_token(char *e) {
	int position = 0;
	int i;
	regmatch_t pmatch;
	
	nr_token = 0; //已经被识别出的token数目

	while(e[position] != '\0') {
		/* Try all rules one by one. */
		for(i = 0; i < NR_REGEX; i ++) {
			if(regexec(&re[i], e + position, 1, &pmatch, 0) == 0 && pmatch.rm_so == 0) {
				// char *substr_start = e + position;
				int substr_len = pmatch.rm_eo;

				// Log("match rules[%d] = \"%s\" at position %d with len %d: %.*s", i, rules[i].regex, position, substr_len, substr_len, substr_start);
				position += substr_len;

				/* TODO: Now a new token is recognized with rules[i]. Add codes
				 * to record the token in the array `tokens'. For certain types
				 * of tokens, some extra actions should be performed.
				 */

				switch(rules[i].token_type) {
					case NOTYPE: break; 
					case HEX:
					case DEC:
					case REG:
					tokens[nr_token].type = rules[i].token_type; //type
					strncpy(tokens[nr_token].str,e + position -substr_len,substr_len); //str
					tokens[nr_token].str[substr_len] = '\0';
					nr_token++;
					break;
					case MINUS:  //NEG OR MINUS
					if(nr_token == 0 || (tokens[nr_token - 1].type >= PLUS && tokens[nr_token - 1].type <= LB)) // 加减乘除+逻辑运算+左括号(
					    tokens[nr_token++].type = NEG;   //作为负数进行处理
					else 
					    tokens[nr_token++].type = MINUS;  //作为减法运算进行处理
					break;
					case STAR:  //POINTER OR MULT
				    if(nr_token == 0 ||(tokens[nr_token - 1].type >= PLUS && tokens[nr_token - 1].type <= LB)) // 加减乘除+逻辑运算+左括号(
                        tokens[nr_token++].type = POINTER; //作为指针进行处理
					else
					    tokens[nr_token++].type = STAR;  //作为乘法运算进行处理
					break;
                    default: //其他情况
					tokens[nr_token++].type = rules[i].token_type;
					break;
					//default: panic("please implement me");
				}

				break;
			}
		}

		if(i == NR_REGEX) {
			printf("no match at position %d\n%s\n%*.s^\n", position, e, position, "");
			return false;
		}
	}

	return true; 
}

bool check_parentheses(int p, int q, bool *success) {  //检查括号匹配
	*success = true;
	if(p > q) return *success = false;
	int ptr = 0, flag = 1, i;		
	for(i = p;i <= q; i++){
		if(tokens[i].type == LB) ptr++;
		if(tokens[i].type == RB) ptr--;
		if(ptr < 0)	
			return *success = false; //Bad Expression
		if(i != q && ptr == 0) flag = 0;
	}
	if(ptr != 0) 
		return *success = false; //Bad Expression
	return flag;
}

uint32_t eval(int p, int q, bool *success) {
	*success = true;
	if(p > q) {   // Bad Expression, exit!
		*success = false;
		return 0;
	}
	if(p == q){	  //HEX or DEC or REG, otherwise bad expression
		uint32_t tmp;
		if(tokens[p].type == HEX) { //print num
			sscanf(tokens[p].str, "%x", &tmp);
			return tmp;
		} 
		else if(tokens[p].type == DEC) { //print num
			sscanf(tokens[p].str, "%d", &tmp);
			return tmp;
		} 
		else if(tokens[p].type == REG) {	//read register
			if(strcmp(tokens[p].str + 1, "zero") == 0) return cpu.zero;
			if(strcmp(tokens[p].str + 1, "at") == 0) return cpu.at;
			if(strcmp(tokens[p].str + 1, "v0") == 0) return cpu.v0;
			if(strcmp(tokens[p].str + 1, "v1") == 0) return cpu.v1;
			if(strcmp(tokens[p].str + 1, "a0") == 0) return cpu.a0;
			if(strcmp(tokens[p].str + 1, "a1") == 0) return cpu.a1;
			if(strcmp(tokens[p].str + 1, "a2") == 0) return cpu.a2;
			if(strcmp(tokens[p].str + 1, "a3") == 0) return cpu.a3;
			if(strcmp(tokens[p].str + 1, "t0") == 0) return cpu.t0;
			if(strcmp(tokens[p].str + 1, "t1") == 0) return cpu.t1;
			if(strcmp(tokens[p].str + 1, "t2") == 0) return cpu.t2;
			if(strcmp(tokens[p].str + 1, "t3") == 0) return cpu.t3;
			if(strcmp(tokens[p].str + 1, "t4") == 0) return cpu.t4;
			if(strcmp(tokens[p].str + 1, "t5") == 0) return cpu.t5;
			if(strcmp(tokens[p].str + 1, "t6") == 0) return cpu.t6;
			if(strcmp(tokens[p].str + 1, "t7") == 0) return cpu.t7;
			if(strcmp(tokens[p].str + 1, "s0") == 0) return cpu.s0;
			if(strcmp(tokens[p].str + 1, "s1") == 0) return cpu.s1;
			if(strcmp(tokens[p].str + 1, "s2") == 0) return cpu.s2;
			if(strcmp(tokens[p].str + 1, "s3") == 0) return cpu.s3;
			if(strcmp(tokens[p].str + 1, "s4") == 0) return cpu.s4;
			if(strcmp(tokens[p].str + 1, "s5") == 0) return cpu.s5;
			if(strcmp(tokens[p].str + 1, "s6") == 0) return cpu.s6;
			if(strcmp(tokens[p].str + 1, "s7") == 0) return cpu.s7;
			if(strcmp(tokens[p].str + 1, "t8") == 0) return cpu.t8;
			if(strcmp(tokens[p].str + 1, "t9") == 0) return cpu.t9;
			if(strcmp(tokens[p].str + 1, "k0") == 0) return cpu.k0;
			if(strcmp(tokens[p].str + 1, "k1") == 0) return cpu.k1;
			if(strcmp(tokens[p].str + 1, "gp") == 0) return cpu.gp;
			if(strcmp(tokens[p].str + 1, "sp") == 0) return cpu.sp;
			if(strcmp(tokens[p].str + 1, "fp") == 0) return cpu.fp;
			if(strcmp(tokens[p].str + 1, "ra") == 0) return cpu.ra;

			if(strcmp(tokens[p].str + 1, "pc") == 0) return cpu.pc;
			if(strcmp(tokens[p].str + 1, "hi") == 0) return cpu.hi;
			if(strcmp(tokens[p].str + 1, "lo") == 0) return cpu.lo;
			*success = false;
		    return 0;
		}
		*success = false;
		return 0;
	}

	//check parentheses
	bool flag = check_parentheses(p, q, success);
	if(*success == false)
		return 0;						  //Bad Expression, exit!
	if(flag) 
	return eval(p + 1, q - 1, success);  //OK, through away the parentheses!


	//find the dominant token
	int op = -1, MIN_PRE = 0x3f3f3f3f, ptr = 0;
	int i;
	for(i = p; i <= q; i++) {
		if(tokens[i].type == LB) ptr++;
		if(tokens[i].type == RB) ptr--;
		if(ptr != 0) continue;	//此时运算符处在括号内，直接判断下一个
		if(tokens[i].type >= PLUS && tokens[i].type <= POINTER) { //从左向右判断运算符
			if(PRE[tokens[i].type] <= MIN_PRE){
				MIN_PRE = PRE[tokens[i].type];
				op = i;
			}
		}
	}
	// printf("%d %d %d %d\n", p, q, MIN_PRE, op);
	if(MIN_PRE == 6) op = p; //说明此时是一个仅含有NOT or NEG OR POINTER的一元表达式，优先级从左向右依次递增,dominant token是第一个type
	assert(op != -1);

	uint32_t val, val1, val2;
	
    if(tokens[op].type >= NOT) {   //NOT or NEG OR POINTER 一元表达式
		val = eval(p + 1, q, success);
		if(*success == false)    return 0;
		if(tokens[op].type == NOT)   return !val;
		if(tokens[op].type == NEG)    return -val;
		if(tokens[op].type == POINTER)   return mem_read(val, 1);
		*success = false;
		return 0;
	}
	else{ //二元表达式
		val1 = eval(p, op - 1, success);
	    if(*success == false)  return 0;

		val2 = eval(op + 1, q ,success);
		if(*success == false)  return 0;

		switch(tokens[op].type){
		case PLUS: return val1 + val2; 
		case MINUS: return val1 - val2; 
		case STAR: return val1 * val2; 
		case DIV: return val1 / val2; 
		case EQ: return val1 == val2; 
		case NOTEQ: return val1 != val2;
		case AND: return val1 && val2; 
		case OR: return val1 || val2;
		default: assert(0);
	    }
	}

}

uint32_t expr(char *e, bool *success) {
	if(!make_token(e)) {
		*success = false;
		return 0;
	}

	/* TODO: Insert codes to evaluate the expression. */
	//panic("please implement me");
	return eval(0, nr_token - 1, success);  //call eval to calculate the value of expression e
}

