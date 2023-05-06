#ifndef __MONITOR_H__
#define __MONITOR_H__

enum { STOP, RUNNING, END };
extern int temu_state;
void write_trace(int reg_no, unsigned value);

#endif
