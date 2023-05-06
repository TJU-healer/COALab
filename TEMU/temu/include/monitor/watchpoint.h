#ifndef __WATCHPOINT_H__
#define __WATCHPOINT_H__

#include "common.h"

typedef struct watchpoint {
	int NO;
	struct watchpoint *next;
    char expr[64];
	uint32_t value;
	/* TODO: Add more members if necessary */

} WP;

WP* new_wp();

void free_wp(WP *wp);

WP* gethead();

int insertExpr(char *e);

int removeNode(int id);

int Isequal_expr(WP *wp);

#endif
